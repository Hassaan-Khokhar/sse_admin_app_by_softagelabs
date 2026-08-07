import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

/// Exams, mark entry, and the publish gate.
class MarksRepository {
  MarksRepository(this._db) : _writer = OutboxWriter(_db);

  final AppDatabase _db;
  final OutboxWriter _writer;

  Stream<List<Exam>> watchExams() {
    final query = _db.select(_db.exams)
      ..where((e) => e.deletedAt.isNull())
      ..orderBy([(e) => OrderingTerm.desc(e.startDate)]);
    return query.watch();
  }

  Stream<List<Subject>> watchSubjects(String classId) {
    final query = _db.select(_db.subjects)
      ..where((s) => s.classId.equals(classId) & s.deletedAt.isNull())
      ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]);
    return query.watch();
  }

  /// Marks for one exam + subject, keyed by student.
  Stream<Map<String, Mark>> watchMarks({
    required String examId,
    required String subjectId,
  }) {
    final query = _db.select(_db.marks)
      ..where((m) =>
          m.examId.equals(examId) &
          m.subjectId.equals(subjectId) &
          m.deletedAt.isNull());
    return query.watch().map((rows) => {for (final r in rows) r.studentId: r});
  }

  Future<void> saveExam({
    required String schoolId,
    required String academicYearId,
    String? id,
    required String name,
    required String examType,
    String? startDate,
    String? endDate,
    bool isPublished = false,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.exams,
      rowId: rowId,
      row: ExamsCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        academicYearId: academicYearId,
        name: name,
        examType: examType,
        startDate: Value(startDate),
        endDate: Value(endDate),
        isPublished: Value(isPublished),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  /// Flips the publish switch.
  ///
  /// This is the gate the whole marks workflow turns on: the principal enters
  /// results over several days, then publishes once and every student sees
  /// them at the same moment (CLAUDE.md §8). Half-entered results never leak.
  ///
  /// It is enforced server-side too — the student RLS policy on `marks` joins
  /// to `exams` and requires `is_published`, so this is not merely a UI filter
  /// a modified app could bypass.
  Future<void> setPublished(Exam exam, {required bool published}) =>
      saveExam(
        schoolId: exam.schoolId,
        academicYearId: exam.academicYearId,
        id: exam.id,
        name: exam.name,
        examType: exam.examType,
        startDate: exam.startDate,
        endDate: exam.endDate,
        isPublished: published,
      );

  /// The paper total in use for [examId] + [subjectId].
  ///
  /// `subjects.total_marks` is the subject's *default* (usually 100), but a
  /// class test may be out of 10 or 25. The real total lives on each `marks`
  /// row, so the first existing row is the source of truth once any mark has
  /// been entered; before that, the subject default applies.
  Future<double?> currentPaperTotal({
    required String examId,
    required String subjectId,
  }) async {
    final row = await (_db.select(_db.marks)
          ..where((m) =>
              m.examId.equals(examId) &
              m.subjectId.equals(subjectId) &
              m.deletedAt.isNull())
          ..limit(1))
        .getSingleOrNull();
    return row?.totalMarks;
  }

  /// Changes the paper total and re-grades every mark already entered.
  ///
  /// Re-grading is the whole point. If the principal enters marks out of 100
  /// and then corrects the paper to be out of 10, a mark of 8 must become 80%
  /// (grade A), not stay at 8% (grade F). Leaving old rows on the old total
  /// would produce a marksheet where two students with the same score have
  /// different grades.
  Future<int> setPaperTotal({
    required String examId,
    required String subjectId,
    required double total,
    required String enteredBy,
  }) async {
    if (total <= 0) {
      throw ArgumentError.value(total, 'total', 'must be greater than zero');
    }

    final existing = await (_db.select(_db.marks)
          ..where((m) =>
              m.examId.equals(examId) &
              m.subjectId.equals(subjectId) &
              m.deletedAt.isNull()))
        .get();

    for (final mark in existing) {
      if (mark.totalMarks == total) continue;

      await _writer.upsert(
        table: _db.marks,
        rowId: mark.id,
        conflictTarget: [
          _db.marks.examId,
          _db.marks.studentId,
          _db.marks.subjectId,
        ],
        row: MarksCompanion.insert(
          id: mark.id,
          schoolId: mark.schoolId,
          examId: mark.examId,
          studentId: mark.studentId,
          subjectId: mark.subjectId,
          classId: mark.classId,
          obtainedMarks: Value(mark.obtainedMarks),
          totalMarks: Value(total),
          isAbsent: Value(mark.isAbsent),
          grade: Value(gradeForMarks(
            obtained: mark.obtainedMarks,
            total: total,
            isAbsent: mark.isAbsent,
          )),
          enteredBy: Value(enteredBy),
          updatedAt: nowTimestamp(),
        ),
      );
    }

    return existing.length;
  }

  /// Records one student's mark for one subject.
  ///
  /// Idempotent on `(exam_id, student_id, subject_id)` — re-entering a mark
  /// corrects it rather than adding a second row.
  ///
  /// The grade is computed here and stored, using the shared scale from
  /// school_core so the admin app and the student app can never disagree about
  /// what 82% means.
  Future<void> saveMark({
    required Student student,
    required Exam exam,
    required Subject subject,
    required double? obtained,
    required double total,
    bool isAbsent = false,
    String? existingId,
    required String enteredBy,
  }) async {
    final rowId = existingId ?? newId();

    await _writer.upsert(
      table: _db.marks,
      rowId: rowId,
      conflictTarget: [
        _db.marks.examId,
        _db.marks.studentId,
        _db.marks.subjectId,
      ],
      row: MarksCompanion.insert(
        id: rowId,
        schoolId: student.schoolId,
        examId: exam.id,
        studentId: student.id,
        subjectId: subject.id,
        classId: student.classId!,
        obtainedMarks: Value(obtained),
        totalMarks: Value(total),
        isAbsent: Value(isAbsent),
        grade: Value(
          gradeForMarks(obtained: obtained, total: total, isAbsent: isAbsent),
        ),
        enteredBy: Value(enteredBy),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  /// Fetches a student's full academic history (all marks across all exams).
  Stream<List<StudentReportItem>> watchStudentReport(String studentId) {
    final query = _db.select(_db.marks).join([
      innerJoin(_db.exams, _db.exams.id.equalsExp(_db.marks.examId)),
      innerJoin(_db.subjects, _db.subjects.id.equalsExp(_db.marks.subjectId)),
    ])..where(_db.marks.studentId.equals(studentId) & _db.marks.deletedAt.isNull());
    
    return query.watch().map((rows) {
      return rows.map((row) {
        return StudentReportItem(
          exam: row.readTable(_db.exams),
          subject: row.readTable(_db.subjects),
          mark: row.readTable(_db.marks),
        );
      }).toList();
    });
  }
}

class StudentReportItem {
  final Exam exam;
  final Subject subject;
  final Mark mark;
  
  StudentReportItem({
    required this.exam,
    required this.subject,
    required this.mark,
  });
}
