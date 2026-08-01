import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

/// Reads and writes the daily attendance register.
///
/// Reads are Drift streams straight off local SQLite; writes go through
/// [OutboxWriter] so the row and its sync entry land in one transaction. No
/// method here touches the network, and none of them can — that is the point
/// (CLAUDE.md §2).
class AttendanceRepository {
  AttendanceRepository(this._db) : _writer = OutboxWriter(_db);

  final AppDatabase _db;
  final OutboxWriter _writer;

  /// Classes to choose from, ordered the way a register is: grade then section.
  Stream<List<SchoolClass>> watchClasses() {
    final query = _db.select(_db.classes)
      ..where((c) => c.deletedAt.isNull())
      ..orderBy([
        (c) => OrderingTerm.asc(c.grade),
        (c) => OrderingTerm.asc(c.section),
      ]);
    return query.watch();
  }

  /// The class roster, in roll-number order.
  ///
  /// Only `active` students. A withdrawn student keeps every historical row —
  /// convention 3 forbids deleting them — but must not appear on tomorrow's
  /// register.
  Stream<List<Student>> watchRoster(String classId) {
    final query = _db.select(_db.students)
      ..where((s) =>
          s.classId.equals(classId) &
          s.deletedAt.isNull() &
          s.status.equals(StudentStatus.active.wire))
      ..orderBy([
        (s) => OrderingTerm.asc(s.rollNo),
        (s) => OrderingTerm.asc(s.fullName),
      ]);
    return query.watch();
  }

  /// Attendance already recorded for [classId] on [date], keyed by student id.
  ///
  /// A student missing from the map has not been marked yet — which is
  /// different from being marked absent, and the UI must show that difference
  /// or a half-finished register looks complete.
  Stream<Map<String, AttendanceRow>> watchRegister(String classId, String date) {
    final query = _db.select(_db.attendance)
      ..where((a) =>
          a.classId.equals(classId) &
          a.date.equals(date) &
          a.deletedAt.isNull());
    return query.watch().map(
          (rows) => {for (final row in rows) row.studentId: row},
        );
  }

  /// Records one student's attendance for one day.
  ///
  /// Idempotent on `(student_id, date)`: marking the same morning again
  /// UPDATES rather than inserting a second row. That constraint is what makes
  /// an offline retry safe (schema.sql §6) — the teacher marks 40 students,
  /// the connection drops mid-push, the outbox retries, and nothing doubles.
  Future<void> mark({
    required Student student,
    required String date,
    required AttendanceStatus status,
    required String markedBy,
    String? existingId,
  }) async {
    final now = nowTimestamp();
    final rowId = existingId ?? newId();

    await _writer.upsert(
      table: _db.attendance,
      rowId: rowId,
      // Without this target the upsert would collide on the primary key only,
      // and a re-mark with a fresh id would insert a duplicate day.
      conflictTarget: [_db.attendance.studentId, _db.attendance.date],
      row: AttendanceCompanion.insert(
        id: rowId,
        schoolId: student.schoolId,
        studentId: student.id,
        classId: student.classId!,
        date: date,
        status: status.wire,
        markedBy: markedBy,
        markedAt: now,
        updatedAt: now,
      ),
    );
  }

  /// Marks every student in [roster] with the same status.
  ///
  /// The morning shortcut: a class teacher marks everyone present, then
  /// changes the three who are not. Far fewer taps than marking 40 individually.
  ///
  /// Sequential rather than parallel on purpose — each call opens its own
  /// transaction, and the outbox must end up in a deterministic order so the
  /// push preserves causality.
  Future<void> markAll({
    required List<Student> roster,
    required Map<String, AttendanceRow> existing,
    required String date,
    required AttendanceStatus status,
    required String markedBy,
  }) async {
    for (final student in roster) {
      await mark(
        student: student,
        date: date,
        status: status,
        markedBy: markedBy,
        existingId: existing[student.id]?.id,
      );
    }
  }
}
