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

  /// Drains one batch of the outbox to Supabase.
  ///
  /// Rows are removed only once the server has accepted them — a dropped
  /// connection leaves them queued, which is the entire reason the outbox
  /// exists.
  ///
  /// **A failing table does not stop the others.** An earlier version aborted
  /// the whole push on the first error, which meant one unpushable row — an
  /// attendance record whose student was deleted server-side, say — failed on
  /// every attempt and permanently blocked everything queued behind it. Sync
  /// then appeared broken forever, and the only cure was clearing the outbox
  /// by hand.
  ///
  /// Now each table is attempted independently, failures are recorded on the
  /// offending rows, and the rest of the batch still goes.
  Future<PushResult> push() async {
    final pending = await (_db.select(_db.outbox)
          ..orderBy([(o) => OrderingTerm.asc(o.seq)])
          ..limit(syncPushBatchSize))
        .get();

    if (pending.isEmpty) return const PushResult(confirmed: 0, failures: []);

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
    final failures = <PushFailure>[];
    final client = SupabaseBootstrap.client;

    for (final table in pushOrder) {
      final ops = byTable[table];
      if (ops == null || ops.isEmpty) continue;

      try {
        // Deduplicate: if the same row was edited multiple times between
        // pushes the outbox holds several entries with the same id. Postgres
        // rejects a batch upsert that touches the same PK twice ("ON CONFLICT
        // DO UPDATE command cannot affect row a second time"). Keep only the
        // latest payload per rowId (highest seq); still delete ALL seqs on
        // success so the older entries don't retry forever.
        final allSeqs = ops.map((op) => op.seq).toList();
        final deduped = <String, _PendingOp>{};
        for (final op in ops) {
          final existing = deduped[op.rowId];
          if (existing == null || op.seq > existing.seq) {
            deduped[op.rowId] = op;
          }
        }

        await client.from(table).upsert(
              deduped.values.map((op) => op.payload).toList(),
              onConflict: 'id',
            );

        await (_db.delete(_db.outbox)
              ..where((o) => o.seq.isIn(allSeqs)))
            .go();

        confirmed += ops.length;
      } on Object catch (error) {
        await _recordFailure(ops, error);
        failures.add(PushFailure(table: table, error: error));
        // Deliberately no rethrow — the next table may be perfectly fine.
      }
    }

    // Rows queued for a table missing from pushOrder can never drain. Record
    // them so they surface instead of looping silently.
    final unknown = byTable.keys.where((t) => !pushOrder.contains(t));
    for (final table in unknown) {
      final error = StateError(
        'No push order for table "$table". Add it to SyncEngine.pushOrder in '
        'dependency order.',
      );
      await _recordFailure(byTable[table]!, error);
      failures.add(PushFailure(table: table, error: error));
    }

    return PushResult(confirmed: confirmed, failures: failures);
  }

  /// Stamps the attempt count and the reason onto rows that would not push.
  ///
  /// The rows stay queued — nothing is ever dropped. `attempts` is what lets
  /// the UI eventually say "this one is stuck" rather than reporting "pending"
  /// forever about a row that will never succeed.
  Future<void> _recordFailure(List<_PendingOp> ops, Object error) async {
    final message = error.toString();
    await (_db.update(_db.outbox)
          ..where((o) => o.seq.isIn(ops.map((op) => op.seq))))
        .write(
      OutboxCompanion(
        lastError: Value(message.length > 500
            ? '${message.substring(0, 500)}…'
            : message),
      ),
    );

    // Increment rather than overwrite: a raw SQL bump avoids reading every
    // row back just to add one.
    await _db.customUpdate(
      'UPDATE outbox SET attempts = attempts + 1 WHERE seq IN '
      '(${ops.map((_) => '?').join(', ')})',
      variables: [for (final op in ops) Variable(op.seq)],
      updates: {_db.outbox},
    );
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

/// Outcome of one push batch.
class PushResult {
  const PushResult({required this.confirmed, required this.failures});

  /// Rows the server accepted and that have left the outbox.
  final int confirmed;

  final List<PushFailure> failures;

  bool get isClean => failures.isEmpty;

  /// True when something failed because the server lacks a row this one
  /// points at — the signal that a backfill would fix it.
  ///
  /// Postgres 23503 is `foreign_key_violation`.
  bool get hasMissingParents => failures.any((f) {
        final text = f.error.toString();
        return text.contains('foreign key constraint') ||
            text.contains('23503');
      });
}

class PushFailure {
  const PushFailure({required this.table, required this.error});

  final String table;
  final Object error;
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
