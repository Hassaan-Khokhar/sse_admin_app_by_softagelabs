/// Shared contract for the SSE school management system.
///
/// Consumed by BOTH apps — the admin desktop app (this repo) and the student
/// mobile app (separate repo, different city). Anything in here is a promise to
/// the other dev.
///
/// What belongs in school_core:
///   * the Drift schema mirroring schema.sql, table for table
///   * the wire strings for every TEXT + CHECK column ([UserRole] and friends)
///   * domain rules both apps must compute identically — [gradeForPercentage],
///     [AttendanceSummary], the limits in policy.dart
///   * the sync engine: outbox, cursor, push/pull
///
/// What does NOT: anything with a `dart:ui` import, anything about how the
/// admin app happens to lay out a screen, and anything only one app needs.
library;

export 'src/attendance_stats.dart';
export 'src/db/database.dart';
export 'src/db/tables/academics.dart';
export 'src/db/tables/attendance.dart';
export 'src/db/tables/exams.dart';
export 'src/db/tables/fees.dart';
export 'src/db/tables/local.dart';
export 'src/db/tables/lost_found.dart';
export 'src/db/tables/people.dart';
export 'src/db/tables/reference.dart';
export 'src/db/tables/sync_columns.dart';
export 'src/enums.dart';
export 'src/grading.dart';
export 'src/ids.dart';
export 'src/policy.dart';
export 'src/supabase_config.dart';
export 'src/sync/outbox_writer.dart';
export 'src/time.dart';
