import 'dart:convert';

import 'package:drift/drift.dart';

import '../db/database.dart';
import '../enums.dart';
import '../ids.dart';
import '../time.dart';

/// Writes a row and queues it for sync, atomically.
///
/// CLAUDE.md §10: "Every local write is one transaction: update the row AND
/// insert into `outbox`."
///
/// If those two could come apart you get one of two silent failures — a change
/// applied locally that is never sent (the principal's edit vanishes on the
/// students' phones), or a change sent that was never applied (the desktop
/// disagrees with the server). Both are invisible until someone notices the
/// data is wrong, which at a school means a parent complaining about a grade.
///
/// So there is exactly one way to write in this app, and it is this class.
/// A bare `db.into(...).insert(...)` anywhere outside sync itself is a bug.
class OutboxWriter {
  const OutboxWriter(this._db);

  final AppDatabase _db;

  /// Upserts [row] into [table] and queues the result for push.
  ///
  /// [conflictTarget] matters for the idempotent tables. `attendance` is keyed
  /// `UNIQUE(student_id, date)` and `marks` is `UNIQUE(exam_id, student_id,
  /// subject_id)`, so marking the same morning twice must UPDATE rather than
  /// insert a second row — that is what makes an offline retry safe
  /// (schema.sql §6). Pass those columns here; omit for tables keyed only by
  /// `id`.
  Future<D> upsert<T extends Table, D extends DataClass>({
    required TableInfo<T, D> table,
    required Insertable<D> row,
    required String rowId,
    List<Column<Object>>? conflictTarget,
  }) async {
    return _db.transaction(() async {
      await _db.into(table).insert(
            row,
            onConflict: DoUpdate<T, D>(
              (_) => row,
              target: conflictTarget,
            ),
          );

      // Read back rather than serialising the Insertable: the stored row is
      // what the server must receive, including any column defaults the
      // caller left out. Serialising the companion would push a partial row.
      final saved = await _selectById(table, rowId);

      await _enqueue(
        tableName: table.actualTableName,
        rowId: rowId,
        op: SyncOp.upsert,
        payload: saved.toJson(),
      );

      return saved;
    });
  }

  /// Tombstones a row — sets `deleted_at` and queues a delete op.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a row that is simply gone is indistinguishable from one the peer
  /// has not seen yet, so peers would keep resurrecting it. It also destroys
  /// history a withdrawn student's file depends on.
  Future<void> tombstone<T extends Table, D extends DataClass>({
    required TableInfo<T, D> table,
    required String rowId,
  }) async {
    final deletedAt = table.columnsByName['deleted_at'];
    if (deletedAt == null) {
      throw ArgumentError(
        '${table.actualTableName} has no deleted_at column, so it cannot be '
        'tombstoned. Local-only tables are the only ones that may be deleted '
        'outright.',
      );
    }

    await _db.transaction(() async {
      final now = nowTimestamp();
      await _db.customUpdate(
        'UPDATE ${table.actualTableName} '
        'SET deleted_at = ?, updated_at = ?, version = version + 1 '
        'WHERE id = ?',
        variables: [Variable(now), Variable(now), Variable(rowId)],
        updates: {table},
      );

      final saved = await _selectById(table, rowId);
      await _enqueue(
        tableName: table.actualTableName,
        rowId: rowId,
        op: SyncOp.delete,
        payload: saved.toJson(),
      );
    });
  }

  Future<D> _selectById<T extends Table, D extends DataClass>(
    TableInfo<T, D> table,
    String rowId,
  ) {
    final idColumn = table.columnsByName['id'];
    if (idColumn == null) {
      throw ArgumentError('${table.actualTableName} has no id column');
    }
    final query = _db.select(table)
      ..where((_) => idColumn.equals(rowId))
      ..limit(1);
    return query.getSingle();
  }

  /// Appends one operation to the outbox.
  ///
  /// The `op_id` is generated here and never regenerated on retry — it is the
  /// idempotency key the server dedupes on via `sync_ops`. If a push commits
  /// server-side but the response is lost, the retry carries the same op_id
  /// and the server recognises the work as already done.
  Future<void> _enqueue({
    required String tableName,
    required String rowId,
    required SyncOp op,
    required Map<String, dynamic> payload,
  }) {
    return _db.into(_db.outbox).insert(
          OutboxCompanion.insert(
            opId: newOpId(),
            tableNameRef: tableName,
            rowId: rowId,
            op: op.wire,
            payload: jsonEncode(payload),
            createdAt: nowTimestamp(),
          ),
        );
  }
}
