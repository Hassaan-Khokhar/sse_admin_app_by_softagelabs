import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `schools` in schema.sql §1.
@DataClassName('School')
class Schools extends Table with SyncColumns {
  @override
  String get tableName => 'schools';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get logoUrl => text().named('logo_url').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `academic_years` in schema.sql §1.
///
/// Terms live inside an academic year — not semesters. See CLAUDE.md §11.
@DataClassName('AcademicYear')
class AcademicYears extends Table with SyncColumns {
  @override
  String get tableName => 'academic_years';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();

  /// e.g. `'2026-2027'`.
  TextColumn get name => text()();

  /// DATE as `YYYY-MM-DD`.
  TextColumn get startDate => text().named('start_date')();
  TextColumn get endDate => text().named('end_date')();

  BoolColumn get isCurrent =>
      boolean().named('is_current').withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `classes` in schema.sql §1.
///
/// A "class" here is grade AND section together — grade 9 section A. This is
/// the school model replacing the university app's Department; see CLAUDE.md
/// §11.
@DataClassName('SchoolClass')
class Classes extends Table with SyncColumns {
  @override
  String get tableName => 'classes';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get academicYearId => text().named('academic_year_id')();

  /// 1..12.
  IntColumn get grade => integer()();

  /// `'A'`, `'B'`.
  TextColumn get section => text()();

  /// `'9-A'` — denormalised so list screens do not join to render a label.
  TextColumn get displayName => text().named('display_name')();

  TextColumn get classTeacherId =>
      text().named('class_teacher_id').nullable()();
  TextColumn get room => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {schoolId, academicYearId, grade, section},
      ];
}

/// Mirrors `subjects` in schema.sql §1.
///
/// Subjects belong to a CLASS, not to a student — everyone in 9-A takes the
/// same subjects. The student app's subject grid is literally
/// `SELECT * FROM subjects WHERE class_id = <my class>`, and that query is the
/// entire "dynamic per student" requirement. No per-student enrolment table,
/// unlike the university app this came from.
@DataClassName('Subject')
class Subjects extends Table with SyncColumns {
  @override
  String get tableName => 'subjects';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get classId => text().named('class_id')();

  /// `'Mathematics'`.
  TextColumn get name => text()();

  /// `'MATH'`.
  TextColumn get code => text().nullable()();

  TextColumn get teacherId => text().named('teacher_id').nullable()();

  IntColumn get totalMarks =>
      integer().named('total_marks').withDefault(const Constant(100))();
  IntColumn get sortOrder =>
      integer().named('sort_order').withDefault(const Constant(0))();

  /// Icon key for the student app's grid tile.
  TextColumn get icon => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
