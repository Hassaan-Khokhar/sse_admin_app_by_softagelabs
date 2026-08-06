import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `app_users` in schema.sql §2.
///
/// `id` equals `auth.users.id` in Supabase — this table mirrors Supabase Auth
/// rather than owning credentials.
@DataClassName('AppUser')
class AppUsers extends Table with SyncColumns {
  @override
  String get tableName => 'app_users';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();

  /// `UserRole.wire` — `'super_admin'` | `'teacher'` | `'student'`.
  TextColumn get role => text()();

  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get fullName => text().named('full_name')();

  /// Flipped to false when a student is withdrawn.
  ///
  /// The student app checks this on every sync and logs out if false. That is
  /// the closing beat of the demo video (CLAUDE.md §12).
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  TextColumn get lastLoginAt => text().named('last_login_at').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `teachers` in schema.sql §2.
@DataClassName('Teacher')
class Teachers extends Table with SyncColumns {
  @override
  String get tableName => 'teachers';

  TextColumn get id => text()();

  /// Null until the teacher has an app login.
  TextColumn get userId => text().named('user_id').nullable()();

  TextColumn get schoolId => text().named('school_id')();
  TextColumn get employeeNo => text().named('employee_no').nullable()();
  TextColumn get fullName => text().named('full_name')();
  TextColumn get cnic => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get qualification => text().nullable()();
  TextColumn get joiningDate => text().named('joining_date').nullable()();
  TextColumn get photoUrl => text().named('photo_url').nullable()();

  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {schoolId, employeeNo},
      ];
}

/// Mirrors `teacher_class_assignments` in schema.sql §2.
///
/// Deferred for the prototype, which is principal-only — but the table exists
/// now so enabling the teacher role later is seeding rows, not a migration
/// (CLAUDE.md §8).
@DataClassName('TeacherClassAssignment')
class TeacherClassAssignments extends Table with SyncColumns {
  @override
  String get tableName => 'teacher_class_assignments';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get teacherId => text().named('teacher_id')();
  TextColumn get classId => text().named('class_id')();

  /// Null means this teacher is the CLASS teacher rather than a subject
  /// teacher.
  TextColumn get subjectId => text().named('subject_id').nullable()();

  BoolColumn get canMarkAttendance => boolean()
      .named('can_mark_attendance')
      .withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `students` in schema.sql §2.
///
/// A student belongs to ONE class-section. There is no per-student course
/// enrolment — that was the university model (CLAUDE.md §11).
///
/// Withdrawing a student sets `status = 'withdrawn'` and
/// `app_users.is_active = false`. The row is never deleted: three years of
/// attendance, marks and fee history hang off it.
@DataClassName('Student')
class Students extends Table with SyncColumns {
  @override
  String get tableName => 'students';

  TextColumn get id => text()();

  /// Null until the student has an app login.
  TextColumn get userId => text().named('user_id').nullable()();

  TextColumn get schoolId => text().named('school_id')();

  /// Null while a student is enrolled but not yet placed in a class.
  TextColumn get classId => text().named('class_id').nullable()();

  /// `'2026-0341'` — school-wide and PERMANENT.
  ///
  /// Distinct from [rollNo], which is per-class and resets every year. The
  /// university app's single `FA23-BCS-067` could not express both
  /// (CLAUDE.md §8).
  TextColumn get admissionNo => text().named('admission_no')();

  /// `23` — position within the class, reset yearly.
  IntColumn get rollNo => integer().named('roll_no').nullable()();

  TextColumn get fullName => text().named('full_name')();
  TextColumn get fatherName => text().named('father_name').nullable()();

  /// Guardian's number, for the OFFICE only.
  ///
  /// These are minors: this must never be rendered anywhere in the student
  /// app. CLAUDE.md §7.
  TextColumn get guardianPhone => text().named('guardian_phone').nullable()();

  TextColumn get dateOfBirth => text().named('date_of_birth').nullable()();

  /// `Gender.wire` — `'male'` | `'female'`.
  TextColumn get gender => text().nullable()();

  TextColumn get address => text().nullable()();
  TextColumn get documents => text().nullable()();
  TextColumn get photoUrl => text().named('photo_url').nullable()();
  TextColumn get admissionDate => text().named('admission_date').nullable()();

  /// `StudentStatus.wire`, defaulting to `'active'`.
  TextColumn get status =>
      text().withDefault(const Constant('active'))();

  TextColumn get leftDate => text().named('left_date').nullable()();
  TextColumn get leftReason => text().named('left_reason').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {schoolId, admissionNo},
      ];
}
