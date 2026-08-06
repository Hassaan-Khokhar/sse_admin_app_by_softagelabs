import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_core/school_core.dart';
import 'package:sse_admin_app/src/data/marks_repository.dart';

void main() {
  late AppDatabase db;
  late MarksRepository repo;

  const schoolId = 'school-1';
  const classId = 'class-1';
  const yearId = 'year-1';
  const subjectId = 'subject-1';
  const examId = 'exam-1';

  late Student student;
  late Exam exam;
  late Subject subject;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = MarksRepository(db);
    final now = nowTimestamp();

    await db.into(db.schools).insert(SchoolsCompanion.insert(
        id: schoolId, name: 'Test', updatedAt: now));
    await db.into(db.academicYears).insert(AcademicYearsCompanion.insert(
          id: yearId,
          schoolId: schoolId,
          name: '2026-2027',
          startDate: '2026-04-01',
          endDate: '2027-03-31',
          updatedAt: now,
        ));
    await db.into(db.classes).insert(ClassesCompanion.insert(
          id: classId,
          schoolId: schoolId,
          academicYearId: yearId,
          grade: 9,
          section: 'A',
          displayName: '9-A',
          updatedAt: now,
        ));
    await db.into(db.subjects).insert(SubjectsCompanion.insert(
          id: subjectId,
          schoolId: schoolId,
          classId: classId,
          name: 'Mathematics',
          totalMarks: const Value(100),
          updatedAt: now,
        ));
    await db.into(db.students).insert(StudentsCompanion.insert(
          id: 'student-1',
          schoolId: schoolId,
          classId: const Value(classId),
          admissionNo: '2026-0001',
          fullName: 'Ahmed Raza',
          updatedAt: now,
        ));
    await db.into(db.exams).insert(ExamsCompanion.insert(
          id: examId,
          schoolId: schoolId,
          academicYearId: yearId,
          name: 'Class Test',
          examType: ExamType.test.wire,
          updatedAt: now,
        ));

    student = await db.select(db.students).getSingle();
    exam = await db.select(db.exams).getSingle();
    subject = await db.select(db.subjects).getSingle();
  });

  tearDown(() async => db.close());

  Future<Mark> markOf() => db.select(db.marks).getSingle();

  group('saveMark', () {
    test('stores the grade from the shared scale', () async {
      await repo.saveMark(
        student: student,
        exam: exam,
        subject: subject,
        obtained: 82,
        total: 100,
        enteredBy: 'u',
      );
      final mark = await markOf();
      expect(mark.obtainedMarks, 82);
      expect(mark.grade, 'A');
    });

    test('re-entering a mark corrects it rather than adding a row', () async {
      // UNIQUE(exam_id, student_id, subject_id).
      for (final value in [40.0, 55.0, 91.0]) {
        await repo.saveMark(
          student: student,
          exam: exam,
          subject: subject,
          obtained: value,
          total: 100,
          enteredBy: 'u',
        );
      }
      final marks = await db.select(db.marks).get();
      expect(marks, hasLength(1));
      expect(marks.single.obtainedMarks, 91);
      expect(marks.single.grade, 'A+');
    });

    test('absent scores F regardless of any number entered', () async {
      await repo.saveMark(
        student: student,
        exam: exam,
        subject: subject,
        obtained: null,
        total: 100,
        isAbsent: true,
        enteredBy: 'u',
      );
      final mark = await markOf();
      expect(mark.isAbsent, isTrue);
      expect(mark.grade, 'F');
    });
  });

  group('paper total', () {
    test('a class test can be out of 10, not the subject default of 100',
        () async {
      // The reported gap: a 10-mark test was forced onto a 100-mark scale, so
      // 8/10 graded as 8% (F) instead of 80% (A).
      await repo.saveMark(
        student: student,
        exam: exam,
        subject: subject,
        obtained: 8,
        total: 10,
        enteredBy: 'u',
      );
      final mark = await markOf();
      expect(mark.totalMarks, 10);
      expect(mark.grade, 'A', reason: '8 out of 10 is 80%');
    });

    test('currentPaperTotal reports what was actually used', () async {
      expect(
        await repo.currentPaperTotal(examId: examId, subjectId: subjectId),
        isNull,
        reason: 'nothing entered yet — the subject default applies',
      );

      await repo.saveMark(
        student: student,
        exam: exam,
        subject: subject,
        obtained: 7,
        total: 25,
        enteredBy: 'u',
      );

      expect(
        await repo.currentPaperTotal(examId: examId, subjectId: subjectId),
        25,
      );
    });

    test('changing the total RE-GRADES marks already entered', () async {
      // The dangerous case. Enter out of 100, then correct the paper to be out
      // of 10: 8 must become 80% (A), not stay 8% (F). Leaving old rows on the
      // old denominator produces a marksheet where identical scores carry
      // different grades.
      await repo.saveMark(
        student: student,
        exam: exam,
        subject: subject,
        obtained: 8,
        total: 100,
        enteredBy: 'u',
      );
      expect((await markOf()).grade, 'F');

      final updated = await repo.setPaperTotal(
        examId: examId,
        subjectId: subjectId,
        total: 10,
        enteredBy: 'u',
      );

      expect(updated, 1);
      final mark = await markOf();
      expect(mark.totalMarks, 10);
      expect(mark.grade, 'A');
    });

    test('re-grading queues every changed row for sync', () async {
      await repo.saveMark(
        student: student,
        exam: exam,
        subject: subject,
        obtained: 8,
        total: 100,
        enteredBy: 'u',
      );
      final before = (await db.select(db.outbox).get()).length;

      await repo.setPaperTotal(
        examId: examId,
        subjectId: subjectId,
        total: 10,
        enteredBy: 'u',
      );

      final after = (await db.select(db.outbox).get()).length;
      expect(after, greaterThan(before),
          reason: 'a re-grade the phone never sees is worse than no re-grade');
    });

    test('rejects a total of zero rather than dividing by it', () async {
      expect(
        () => repo.setPaperTotal(
            examId: examId, subjectId: subjectId, total: 0, enteredBy: 'u'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('publish gate', () {
    test('exams start hidden from students', () async {
      expect(exam.isPublished, isFalse);
    });

    test('publishing flips the flag and queues it for sync', () async {
      await repo.setPublished(exam, published: true);
      final after = await db.select(db.exams).getSingle();
      expect(after.isPublished, isTrue);

      final queued = await db.select(db.outbox).get();
      expect(queued.any((o) => o.tableNameRef == 'exams'), isTrue,
          reason: 'students only see results once the server knows');
    });
  });
}
