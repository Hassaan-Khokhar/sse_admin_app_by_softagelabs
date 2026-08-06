import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

/// Faculty list and the staff attendance register.
///
/// Same shape as [AttendanceRepository] on the student side, and deliberately
/// so — the two registers behave identically from the principal's point of
/// view, and reusing the pattern means reusing its correctness.
class FacultyRepository {
  FacultyRepository(this._db) : _writer = OutboxWriter(_db);

  final AppDatabase _db;
  final OutboxWriter _writer;

  /// Active faculty, alphabetical.
  Stream<List<Teacher>> watchTeachers() {
    final query = _db.select(_db.teachers)
      ..where((t) => t.deletedAt.isNull() & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.fullName)]);
    return query.watch();
  }

  Future<void> saveTeacher({
    required String schoolId,
    String? id,
    String? employeeNo,
    required String fullName,
    String? phone,
    String? qualification,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.teachers,
      rowId: rowId,
      row: TeachersCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        employeeNo: Value(employeeNo),
        fullName: fullName,
        phone: Value(phone),
        qualification: Value(qualification),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  /// Today's (or any day's) staff register, keyed by teacher id.
  ///
  /// A teacher absent from the map has not been marked — which is not the same
  /// as being marked absent, and the UI has to show the difference or a
  /// half-filled register looks finished.
  Stream<Map<String, TeacherAttendanceRow>> watchRegister(String date) {
    final query = _db.select(_db.teacherAttendance)
      ..where((a) => a.date.equals(date) & a.deletedAt.isNull());
    return query.watch().map(
          (rows) => {for (final row in rows) row.teacherId: row},
        );
  }

  /// Attendance summary per teacher over the last [days] days.
  ///
  /// Aggregated in Dart rather than SQL on purpose: it reuses
  /// [AttendanceSummary] from school_core, which is the single definition of
  /// the `(present + late) / (total - holiday)` rule. A hand-written SQL
  /// aggregate here would be a second implementation of that formula, free to
  /// drift from the one the student app uses.
  ///
  /// The data volume makes this free — ten teachers over two months is a few
  /// hundred rows.
  Stream<Map<String, AttendanceSummary>> watchSummaries({int days = 60}) {
    final cutoff = encodeDate(
      dateOnly(DateTime.now()).subtract(Duration(days: days)),
    );

    final query = _db.select(_db.teacherAttendance)
      ..where((a) => a.deletedAt.isNull() & a.date.isBiggerOrEqualValue(cutoff));

    return query.watch().map((rows) {
      final byTeacher = <String, List<AttendanceStatus>>{};
      for (final row in rows) {
        final status = AttendanceStatus.tryFromWire(row.status);
        if (status == null) continue; // unknown value from a newer peer
        byTeacher.putIfAbsent(row.teacherId, () => []).add(status);
      }
      return {
        for (final entry in byTeacher.entries)
          entry.key: AttendanceSummary.count(entry.value),
      };
    });
  }

  /// Records one teacher's attendance for one day.
  ///
  /// Idempotent on `(teacher_id, date)` — marking twice UPDATES.
  Future<void> mark({
    required Teacher teacher,
    required String date,
    required AttendanceStatus status,
    required String markedBy,
    String? existingId,
    String? checkInTime,
    String? remarks,
  }) async {
    final now = nowTimestamp();
    final rowId = existingId ?? newId();

    await _writer.upsert(
      table: _db.teacherAttendance,
      rowId: rowId,
      conflictTarget: [_db.teacherAttendance.teacherId, _db.teacherAttendance.date],
      row: TeacherAttendanceCompanion.insert(
        id: rowId,
        schoolId: teacher.schoolId,
        teacherId: teacher.id,
        date: date,
        status: status.wire,
        checkInTime: Value(checkInTime),
        remarks: Value(remarks),
        markedBy: markedBy,
        markedAt: now,
        updatedAt: now,
      ),
    );
  }

  /// Marks every teacher the same. The morning shortcut, as for students.
  Future<void> markAll({
    required List<Teacher> teachers,
    required Map<String, TeacherAttendanceRow> existing,
    required String date,
    required AttendanceStatus status,
    required String markedBy,
  }) async {
    for (final teacher in teachers) {
      await mark(
        teacher: teacher,
        date: date,
        status: status,
        markedBy: markedBy,
        existingId: existing[teacher.id]?.id,
        checkInTime: existing[teacher.id]?.checkInTime,
      );
    }
  }
}
