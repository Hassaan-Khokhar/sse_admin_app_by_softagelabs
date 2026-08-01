import 'package:drift/drift.dart';

import 'tables/academics.dart';
import 'tables/attendance.dart';
import 'tables/exams.dart';
import 'tables/fees.dart';
import 'tables/local.dart';
import 'tables/lost_found.dart';
import 'tables/people.dart';
import 'tables/reference.dart';

part 'database.g.dart';

/// The full local database — the same schema on the admin desktop app and the
/// student mobile app.
///
/// The two apps differ only in how much of it is populated: the desktop holds
/// the whole school (~30 MB), a phone holds its own student's slice (~2 MB).
/// The tables are identical, which is what lets one sync engine serve both.
///
/// **Reads and writes hit this database first, always.** The UI never waits on
/// the network — the school's internet is down for hours at a time, and that
/// constraint is the entire premise of the system (CLAUDE.md §2). The network
/// is a sync channel, not a dependency.
///
/// Each app supplies its own executor, because opening a database file is
/// platform work this pure-Dart package deliberately stays out of:
///
/// ```dart
/// // in the app, using drift_flutter:
/// final db = AppDatabase(driftDatabase(name: 'sse_school'));
/// ```
@DriftDatabase(
  tables: [
    // §1 reference
    Schools,
    AcademicYears,
    Classes,
    Subjects,
    // §2 people & access
    AppUsers,
    Teachers,
    TeacherClassAssignments,
    Students,
    // §3 attendance
    Attendance,
    // §4 exams & marks
    Exams,
    Marks,
    // §5 fees
    FeeStructures,
    FeeChallans,
    // §6 timetable, assignments, notices
    TimetableSlots,
    Assignments,
    Notices,
    // §7 lost & found
    LostItems,
    ItemClaims,
    // local-only — never created in Postgres
    Outbox,
    AttachmentOutbox,
    SyncState,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _createIndexes();
        },
        beforeOpen: (details) async {
          // Foreign key enforcement is deliberately left OFF (SQLite's
          // default).
          //
          // Rows arrive from the server in `server_seq` order, which is the
          // order they were WRITTEN, not an order that respects dependencies.
          // A pull can legitimately deliver an attendance row before the
          // student row it points at. With `PRAGMA foreign_keys = ON` that
          // insert fails, the batch aborts, and the cursor never advances —
          // the device wedges permanently.
          //
          // The references declared on the tables document the model and match
          // schema.sql; Postgres is where they are actually enforced, because
          // there the write order is under our control.
          //
          // Do not "fix" this by turning the pragma on.
        },
      );

  /// Mirrors the CREATE INDEX statements in schema.sql.
  ///
  /// Written out rather than generated so the two files can be diffed by eye —
  /// an index that exists on the server but not on the device turns a snappy
  /// screen into a full table scan that nobody notices until the demo.
  Future<void> _createIndexes() async {
    const statements = [
      // Class roster — the attendance screen's first query.
      'CREATE INDEX IF NOT EXISTS idx_students_class '
          'ON students(class_id) WHERE deleted_at IS NULL',

      // Monthly attendance calendar for one student.
      'CREATE INDEX IF NOT EXISTS idx_attendance_student_date '
          'ON attendance(student_id, date)',

      // "Mark today's attendance for 9-A" — loads the whole class for a day.
      'CREATE INDEX IF NOT EXISTS idx_attendance_class_date '
          'ON attendance(class_id, date)',

      // A student's marksheet across subjects for one exam.
      'CREATE INDEX IF NOT EXISTS idx_marks_student '
          'ON marks(student_id, exam_id)',

      'CREATE INDEX IF NOT EXISTS idx_challans_student '
          'ON fee_challans(student_id, year, month)',

      // Defaulter list: WHERE status='unpaid' AND due_date < today.
      'CREATE INDEX IF NOT EXISTS idx_challans_status '
          "ON fee_challans(status) WHERE status = 'unpaid'",

      // Lost & found feed, newest first.
      'CREATE INDEX IF NOT EXISTS idx_lost_items_feed '
          'ON lost_items(school_id, status, created_at) '
          'WHERE deleted_at IS NULL',

      // Sync engine: find un-pushed rows, and drain the outbox in order.
      'CREATE INDEX IF NOT EXISTS idx_outbox_drain '
          'ON outbox(seq)',
      'CREATE INDEX IF NOT EXISTS idx_attachment_outbox_status '
          'ON attachment_outbox(status)',
    ];

    for (final statement in statements) {
      await customStatement(statement);
    }
  }
}
