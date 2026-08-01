import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `exams` in schema.sql §4.
@DataClassName('Exam')
class Exams extends Table with SyncColumns {
  @override
  String get tableName => 'exams';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get academicYearId => text().named('academic_year_id')();

  /// `'First Term'`.
  TextColumn get name => text()();

  /// `ExamType.wire` — `first_term` | `mid_term` | `final_term` | `test` |
  /// `quiz`.
  TextColumn get examType => text().named('exam_type')();

  TextColumn get startDate => text().named('start_date').nullable()();
  TextColumn get endDate => text().named('end_date').nullable()();

  /// The gate. False means hidden from students.
  ///
  /// The principal enters marks over several days, then flips one switch and
  /// every student sees their result at once. It stops half-entered results
  /// leaking, and it is a good demo beat (CLAUDE.md §8).
  ///
  /// Enforced server-side too: the student RLS policy on `marks` joins to
  /// `exams` and requires `is_published`, so this is not merely a UI filter.
  BoolColumn get isPublished =>
      boolean().named('is_published').withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `marks` in schema.sql §4.
@DataClassName('Mark')
class Marks extends Table with SyncColumns {
  @override
  String get tableName => 'marks';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get examId => text().named('exam_id')();
  TextColumn get studentId => text().named('student_id')();
  TextColumn get subjectId => text().named('subject_id')();
  TextColumn get classId => text().named('class_id')();

  /// NUMERIC(6,2) → REAL. Null while the paper is unmarked.
  RealColumn get obtainedMarks =>
      real().named('obtained_marks').nullable()();

  RealColumn get totalMarks =>
      real().named('total_marks').withDefault(const Constant(100))();

  BoolColumn get isAbsent =>
      boolean().named('is_absent').withDefault(const Constant(false))();

  /// `'A+'`, `'A'`, … Computed on save via `gradeForMarks` in grading.dart.
  ///
  /// Denormalised deliberately: the report card and the student's marksheet
  /// must show the same letter forever, even if the school changes its scale
  /// next year.
  TextColumn get grade => text().nullable()();

  TextColumn get remarks => text().nullable()();
  TextColumn get enteredBy => text().named('entered_by').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  /// Idempotent, exactly as attendance is — re-entering a mark UPDATES.
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {examId, studentId, subjectId},
      ];
}
