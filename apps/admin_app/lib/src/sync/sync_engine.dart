import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

import '../data/supabase_bootstrap.dart';

/// Moves rows between local SQLite and Supabase.
///
/// Prototype transport, per the shortcut CLAUDE.md §10 explicitly allows:
/// instead of custom `/sync/push` and `/sync/pull` endpoints backed by
/// `change_log`, this talks to PostgREST directly and pulls by
/// `updated_at > last_sync`.
///
/// What is NOT deferred, because none of it can be retrofitted: client-side
/// UUIDs, `deleted_at` tombstones, the outbox, and the four sync columns.
///
/// The switch to a real `server_seq` cursor later is additive — migration 002
/// already stamps every syncable table, so the column is populated and waiting.
class SyncEngine {
  SyncEngine(this._db);

  final AppDatabase _db;

  /// Push order. Parents before children.
  ///
  /// This matters far more on the server than locally. SQLite here runs with
  /// foreign keys OFF on purpose (see AppDatabase.migration), because pulled
  /// rows arrive in write order rather than dependency order. Postgres has no
  /// such leniency: pushing an attendance row before its student exists is a
  /// foreign key violation and the whole batch fails.
  static const pushOrder = <String>[
    'schools',
    'academic_years',
    'classes',
    'subjects',
    'app_users',
    'teachers',
    'teacher_class_assignments',
    'students',
    'attendance',
    // Depends on teachers, which is already above it.
    'teacher_attendance',
    'exams',
    'marks',
    'fee_structures',
    'fee_challans',
    'timetable_slots',
    'assignments',
    'notices',
    'lost_items',
    'item_claims',
  ];

  /// Drains the outbox to Supabase.
  ///
  /// Returns the number of operations confirmed. Rows are only removed from
  /// the outbox once the server has accepted them — a dropped connection
  /// leaves them queued for the next attempt, which is the entire reason the
  /// outbox exists.
  Future<int> push() async {
    final pending = await (_db.select(_db.outbox)
          ..orderBy([(o) => OrderingTerm.asc(o.seq)])
          ..limit(syncPushBatchSize))
        .get();

    if (pending.isEmpty) return 0;

    // Group by table so each table becomes one request rather than one per
    // row. Marking 40 students is then a single upsert, not 40 round trips
    // over a connection that may not survive 40 round trips.
    final byTable = <String, List<_PendingOp>>{};
    for (final entry in pending) {
      byTable.putIfAbsent(entry.tableNameRef, () => []).add(
            _PendingOp(
              seq: entry.seq,
              rowId: entry.rowId,
              payload: jsonDecode(entry.payload) as Map<String, dynamic>,
            ),
          );
    }

    var confirmed = 0;
    final client = SupabaseBootstrap.client;

    for (final table in pushOrder) {
      final ops = byTable[table];
      if (ops == null || ops.isEmpty) continue;

      // Upsert is idempotent on the primary key, so a retry after a lost
      // response is harmless — it rewrites the same row with the same values.
      // That is what stands in for the `sync_ops` ledger in the prototype.
      await client.from(table).upsert(
            ops.map((op) => op.payload).toList(),
            onConflict: 'id',
          );

      await (_db.delete(_db.outbox)
            ..where((o) => o.seq.isIn(ops.map((op) => op.seq))))
          .go();

      confirmed += ops.length;
    }

    // Anything left is queued for a table missing from pushOrder — a schema
    // change that nobody added here. Surface it rather than silently looping
    // forever on rows that can never drain.
    final unknown = byTable.keys.where((t) => !pushOrder.contains(t)).toList();
    if (unknown.isNotEmpty) {
      throw StateError(
        'Outbox holds rows for unknown tables: ${unknown.join(', ')}. '
        'Add them to SyncEngine.pushOrder in dependency order.',
      );
    }

    return confirmed;
  }

  /// True while the outbox still holds work, so the caller can loop.
  Future<bool> hasPending() async {
    final remaining = await (_db.select(_db.outbox)..limit(1)).get();
    return remaining.isNotEmpty;
  }

  /// Pulls rows changed since [since] into local SQLite.
  ///
  /// Writes here deliberately bypass [OutboxWriter]: a row that arrived FROM
  /// the server must not be queued to be pushed back TO it. That loop would
  /// never terminate — each push would bump `updated_at`, which the next pull
  /// would see as a change, forever.
  Future<int> pull({required String? since}) async {
    final client = SupabaseBootstrap.client;
    var received = 0;

    for (final table in pushOrder) {
      var query = client.from(table).select();
      if (since != null) query = query.gt('updated_at', since);

      final rows = await query
          .order('updated_at', ascending: true)
          .limit(syncPullPageSize);

      if (rows.isEmpty) continue;

      await _applyRows(table, rows);
      received += rows.length;
    }

    return received;
  }

  /// Writes pulled rows into the local mirror of [table].
  ///
  /// Uses raw SQL keyed on the column names in the payload, so a column added
  /// to the schema flows through without this method needing to know about it.
  Future<void> _applyRows(String table, List<Map<String, dynamic>> rows) async {
    await _db.transaction(() async {
      for (final row in rows) {
        final columns = row.keys.toList();
        final placeholders = List.filled(columns.length, '?').join(', ');
        final assignments =
            columns.where((c) => c != 'id').map((c) => '$c = excluded.$c');

        await _db.customStatement(
          'INSERT INTO $table (${columns.join(', ')}) '
          'VALUES ($placeholders) '
          'ON CONFLICT(id) DO UPDATE SET ${assignments.join(', ')}',
          columns.map((c) => _toSqlite(row[c])).toList(),
        );
      }
    });
  }

  /// Postgres JSON to SQLite values, per schema.sql convention 5.
  Object? _toSqlite(Object? value) => switch (value) {
        null => null,
        // BOOLEAN → INTEGER (0/1). SQLite has no boolean type, and drift's
        // generated readers expect the integer form.
        final bool flag => flag ? 1 : 0,
        // JSONB → TEXT. `photos` arrives as a decoded List and has to go back
        // to a json string.
        final List<Object?> list => jsonEncode(list),
        final Map<String, Object?> map => jsonEncode(map),
        _ => value,
      };
}

class _PendingOp {
  const _PendingOp({
    required this.seq,
    required this.rowId,
    required this.payload,
  });

  final int seq;
  final String rowId;
  final Map<String, dynamic> payload;
}
