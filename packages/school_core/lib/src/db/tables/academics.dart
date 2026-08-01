import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `timetable_slots` in schema.sql §6.
///
/// The timetable belongs to the CLASS, not the student — 40 students share one
/// timetable. That is 40× less data than the university per-student model the
/// original app used (CLAUDE.md §11).
@DataClassName('TimetableSlot')
class TimetableSlots extends Table with SyncColumns {
  @override
  String get tableName => 'timetable_slots';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get classId => text().named('class_id')();

  /// Null for a break or assembly.
  TextColumn get subjectId => text().named('subject_id').nullable()();
  TextColumn get teacherId => text().named('teacher_id').nullable()();

  /// 1..7, where 1 = Monday.
  IntColumn get dayOfWeek => integer().named('day_of_week')();

  IntColumn get periodNo => integer().named('period_no')();

  /// `'08:00'` — wall-clock strings, not timestamps.
  TextColumn get startTime => text().named('start_time')();
  TextColumn get endTime => text().named('end_time')();

  /// `SlotType.wire` — `'class'` | `'break'` | `'assembly'`.
  TextColumn get slotType =>
      text().named('slot_type').withDefault(const Constant('class'))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
        {classId, dayOfWeek, periodNo},
      ];
}

/// Mirrors `assignments` in schema.sql §6.
///
/// VIEW ONLY. Students do not submit through the app in v1 (CLAUDE.md §9).
@DataClassName('Assignment')
class Assignments extends Table with SyncColumns {
  @override
  String get tableName => 'assignments';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get classId => text().named('class_id')();
  TextColumn get subjectId => text().named('subject_id').nullable()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get attachmentUrl => text().named('attachment_url').nullable()();

  TextColumn get assignedDate => text().named('assigned_date')();
  TextColumn get dueDate => text().named('due_date').nullable()();
  TextColumn get createdBy => text().named('created_by').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `notices` in schema.sql §6.
@DataClassName('Notice')
class Notices extends Table with SyncColumns {
  @override
  String get tableName => 'notices';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();

  /// Null means the notice goes to the whole school.
  TextColumn get classId => text().named('class_id').nullable()();

  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get attachmentUrl => text().named('attachment_url').nullable()();

  /// `NoticePriority.wire` — `'normal'` | `'important'` | `'urgent'`.
  TextColumn get priority =>
      text().withDefault(const Constant('normal'))();

  TextColumn get publishDate => text().named('publish_date')();
  TextColumn get expiresAt => text().named('expires_at').nullable()();
  TextColumn get createdBy => text().named('created_by').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
