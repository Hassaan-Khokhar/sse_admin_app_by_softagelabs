import 'dart:convert';

import 'package:school_core/school_core.dart';

import 'sync_engine.dart';

/// Queues every local row for push.
///
/// The demo seeder writes straight to SQLite rather than through
/// [OutboxWriter], deliberately: routing 2,600 back-dated attendance rows
/// through the normal write path would enqueue them one transaction at a time
/// and take minutes. But it leaves the server empty, and the phone can only
/// show what the server has.
///
/// This closes that gap — a one-time "upload the whole school" for the demo.
/// It is NOT part of normal operation: real edits queue themselves as they
/// happen, which is the entire point of the outbox.
class SyncBackfill {
  const SyncBackfill(this._db);

  final AppDatabase _db;

  /// Enqueues every live row in dependency order. Returns the row count.
  ///
  /// Existing outbox entries are cleared first. Anything already queued is
  /// necessarily a subset of what is about to be queued — the row is in the
  /// database either way — so keeping both would just push twice.
  Future<int> enqueueEverything() async {
    var total = 0;

    await _db.transaction(() async {
      await _db.delete(_db.outbox).go();

      // Same order as SyncEngine.pushOrder: parents before children, because
      // Postgres enforces the foreign keys that local SQLite does not.
      for (final table in SyncEngine.pushOrder) {
        total += await _enqueueTable(table);
      }
    });

    return total;
  }

  Future<int> _enqueueTable(String tableName) async {
    final table = _db.allTables.firstWhere(
      (t) => t.actualTableName == tableName,
      orElse: () => throw StateError('Unknown table: $tableName'),
    );

    // Tombstoned rows are included on purpose. A delete that never reached the
    // server is exactly the kind of change that must not be dropped — the
    // peer would otherwise keep showing a withdrawn student.
    final rows = await _db.customSelect(
      'SELECT * FROM $tableName',
      readsFrom: {table},
    ).get();

    for (final row in rows) {
      final data = row.data;
      final isDeleted = data['deleted_at'] != null;

      await _db.into(_db.outbox).insert(
            OutboxCompanion.insert(
              opId: newOpId(),
              tableNameRef: tableName,
              rowId: data['id']! as String,
              op: (isDeleted ? SyncOp.delete : SyncOp.upsert).wire,
              payload: jsonEncode(_toJson(data)),
              createdAt: nowTimestamp(),
            ),
          );
    }

    return rows.length;
  }

  /// SQLite values back to what PostgREST expects.
  ///
  /// The reverse of SyncEngine._toSqlite. SQLite stores booleans as 0/1 and
  /// JSON as text; Postgres wants real booleans and real JSON, and rejects the
  /// integer form on a BOOLEAN column.
  Map<String, Object?> _toJson(Map<String, Object?> row) {
    return {
      for (final entry in row.entries)
        entry.key: switch (entry.key) {
          // BOOLEAN columns, per schema.sql.
          'is_current' ||
          'is_active' ||
          'is_published' ||
          'is_absent' ||
          'can_mark_attendance' =>
            entry.value == 1 || entry.value == true,
          // JSONB column.
          'photos' => entry.value is String
              ? jsonDecode(entry.value! as String)
              : entry.value,
          _ => entry.value,
        },
    };
  }
}
