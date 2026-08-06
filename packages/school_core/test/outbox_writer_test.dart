import 'dart:convert';

// drift exports SQL helpers named `isNull` / `isNotNull` that shadow the
// matchers of the same name. The matchers are what a test file wants.
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:school_core/school_core.dart';
import 'package:test/test.dart';

void main() {
  late AppDatabase db;
  late OutboxWriter writer;

  const schoolId = 'school-1';
  const classId = 'class-1';
  const studentId = 'student-1';
  const markedBy = 'user-1';

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    writer = OutboxWriter(db);
  });

  tearDown(() async => db.close());

  Future<int> outboxCount() async {
    final rows = await db.select(db.outbox).get();
    return rows.length;
  }

  AttendanceCompanion attendanceRow({
    required String id,
    required String date,
    required AttendanceStatus status,
  }) =>
      AttendanceCompanion.insert(
        id: id,
        schoolId: schoolId,
        studentId: studentId,
        classId: classId,
        date: date,
        status: status.wire,
        markedBy: markedBy,
        markedAt: nowTimestamp(),
        updatedAt: nowTimestamp(),
      );

  group('upsert', () {
    test('writes the row and queues it in one transaction', () async {
      await writer.upsert(
        table: db.attendance,
        row: attendanceRow(
          id: 'att-1',
          date: '2026-08-03',
          status: AttendanceStatus.present,
        ),
        rowId: 'att-1',
      );

      final saved = await db.select(db.attendance).getSingle();
      expect(saved.status, 'present');
      expect(await outboxCount(), 1);
    });

    test('the queued payload is the STORED row, including defaults', () async {
      await writer.upsert(
        table: db.attendance,
        row: attendanceRow(
          id: 'att-1',
          date: '2026-08-03',
          status: AttendanceStatus.present,
        ),
        rowId: 'att-1',
      );

      final entry = await db.select(db.outbox).getSingle();
      final payload = jsonDecode(entry.payload) as Map<String, dynamic>;

      // `version` was never passed by the caller — it comes from the column
      // default. Serialising the companion instead of reading back would have
      // pushed a row without it.
      expect(payload['version'], 1);
      expect(payload['status'], 'present');
      expect(payload['student_id'], studentId);
      expect(entry.op, SyncOp.upsert.wire);
      expect(entry.tableNameRef, 'attendance');
      expect(entry.rowId, 'att-1');
    });

    test('marking the same student and day twice UPDATES, never duplicates',
        () async {
      // The idempotency guarantee behind offline retries. A teacher marks 40
      // students, the connection drops mid-push, the outbox retries — and
      // nothing doubles. schema.sql §6: UNIQUE(student_id, date).
      await writer.upsert(
        table: db.attendance,
        row: attendanceRow(
          id: 'att-1',
          date: '2026-08-03',
          status: AttendanceStatus.absent,
        ),
        rowId: 'att-1',
        conflictTarget: [db.attendance.studentId, db.attendance.date],
      );

      await writer.upsert(
        table: db.attendance,
        row: attendanceRow(
          id: 'att-1',
          date: '2026-08-03',
          status: AttendanceStatus.present,
        ),
        rowId: 'att-1',
        conflictTarget: [db.attendance.studentId, db.attendance.date],
      );

      final rows = await db.select(db.attendance).get();
      expect(rows, hasLength(1), reason: 'must update, not insert a second row');
      expect(rows.single.status, 'present', reason: 'correction should win');

      // Two writes, two ops. The server dedupes on op_id; the client does not
      // collapse them, because each was a real user action.
      expect(await outboxCount(), 2);
    });

    test('every operation gets a distinct op_id', () async {
      for (var i = 0; i < 5; i++) {
        await writer.upsert(
          table: db.attendance,
          row: attendanceRow(
            id: 'att-$i',
            date: '2026-08-0${i + 1}',
            status: AttendanceStatus.present,
          ),
          rowId: 'att-$i',
        );
      }

      final ops = await db.select(db.outbox).get();
      final ids = ops.map((o) => o.opId).toSet();
      expect(ids, hasLength(5), reason: 'op_id is the server dedupe key');
    });

    test('outbox drains in insertion order', () async {
      for (var i = 0; i < 3; i++) {
        await writer.upsert(
          table: db.attendance,
          row: attendanceRow(
            id: 'att-$i',
            date: '2026-08-0${i + 1}',
            status: AttendanceStatus.present,
          ),
          rowId: 'att-$i',
        );
      }

      final ops = await (db.select(db.outbox)
            ..orderBy([(o) => OrderingTerm.asc(o.seq)]))
          .get();
      expect(ops.map((o) => o.rowId), ['att-0', 'att-1', 'att-2']);
    });
  });

  group('tombstone', () {
    test('sets deleted_at and queues a delete op — never removes the row',
        () async {
      await writer.upsert(
        table: db.attendance,
        row: attendanceRow(
          id: 'att-1',
          date: '2026-08-03',
          status: AttendanceStatus.present,
        ),
        rowId: 'att-1',
      );

      await writer.tombstone(table: db.attendance, rowId: 'att-1');

      final rows = await db.select(db.attendance).get();
      expect(rows, hasLength(1), reason: 'schema.sql convention 3: never DELETE');
      expect(rows.single.deletedAt, isNotNull);
      expect(rows.single.version, greaterThan(1));

      final ops = await (db.select(db.outbox)
            ..orderBy([(o) => OrderingTerm.asc(o.seq)]))
          .get();
      expect(ops.last.op, SyncOp.delete.wire);
    });

    test('refuses on a table with no deleted_at', () async {
      // The local-only tables are the only ones that may be truly deleted.
      expect(
        () => writer.tombstone(table: db.outbox, rowId: 'anything'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
