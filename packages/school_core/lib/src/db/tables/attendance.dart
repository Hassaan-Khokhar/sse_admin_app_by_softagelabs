import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `attendance` in schema.sql §3.
///
/// DAILY attendance — one row per student per day. The class teacher marks the
/// whole class once each morning. Per-period attendance was considered and
/// rejected: eight times the rows and eight times the teacher's work, and it
/// is not how the school operates (CLAUDE.md §8).
@DataClassName('AttendanceRow')
class Attendance extends Table with SyncColumns {
  @override
  String get tableName => 'attendance';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get studentId => text().named('student_id')();
  TextColumn get classId => text().named('class_id')();

  /// DATE as `YYYY-MM-DD`, in the school's LOCAL calendar. See
  /// `encodeDate` in time.dart for why this must not go through UTC.
  TextColumn get date => text()();

  /// `AttendanceStatus.wire` — one of `present`, `absent`, `leave`, `late`,
  /// `holiday`. Five states, not a boolean (CLAUDE.md §8).
  TextColumn get status => text()();

  TextColumn get remarks => text().nullable()();
  TextColumn get markedBy => text().named('marked_by')();
  TextColumn get markedAt => text().named('marked_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  /// IDEMPOTENCY — marking the same student on the same day UPDATES rather
  /// than duplicating.
  ///
  /// This is what makes an offline retry safe: the teacher marks 40 students,
  /// the connection drops mid-push, the outbox retries, and nothing doubles.
  /// **Do not drop this constraint** (schema.sql §6, CLAUDE.md §6).
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {studentId, date},
      ];
}

/// Mirrors `teacher_attendance`, added in migration 003.
///
/// Separate from [Attendance] because `attendance.student_id` is NOT NULL and
/// the table is keyed `UNIQUE(student_id, date)` — the idempotency guarantee
/// the whole offline retry story depends on. Bending that to fit staff rows
/// would have been a bad trade for one saved table.
///
/// **Staff data.** Students must never read this: RLS gives it to the
/// principal only. A student knowing which teacher was absent is none of their
/// business, and in a school where everyone knows everyone, unkind.
@DataClassName('TeacherAttendanceRow')
class TeacherAttendance extends Table with SyncColumns {
  @override
  String get tableName => 'teacher_attendance';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get teacherId => text().named('teacher_id')();

  /// DATE as `YYYY-MM-DD`, local calendar — same rules as student attendance.
  TextColumn get date => text()();

  /// `AttendanceStatus.wire` — the same five states, deliberately. One enum
  /// serves both registers.
  TextColumn get status => text()();

  /// `'08:05'`. Wall-clock text, not a timestamp: it is a time of day and
  /// never needs a timezone. Null when the office did not record arrival.
  TextColumn get checkInTime => text().named('check_in_time').nullable()();

  /// 'Medical leave', 'Official duty'. Free text — leave categories vary by
  /// school and guessing at this one's HR policy would be worse than nothing.
  TextColumn get remarks => text().nullable()();

  TextColumn get markedBy => text().named('marked_by')();
  TextColumn get markedAt => text().named('marked_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  /// Same idempotency guarantee as the student register.
  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {teacherId, date},
      ];
}
