import 'package:drift/drift.dart';

/// The four sync columns every syncable table carries.
///
/// schema.sql convention 4 — these are identical on every table by design, so
/// the sync engine can treat any table generically instead of special-casing
/// twenty of them.
///
/// CLAUDE.md §10 lists these among the things that are "impossible to retrofit
/// later". The prototype may skip the full change_log, but not these.
mixin SyncColumns on Table {
  /// ISO-8601 UTC, set by the CLIENT on every write.
  ///
  /// Display and coarse ordering only. Never the sync cursor — school PC clocks
  /// are routinely wrong, and a clock two days behind would silently skip
  /// changes forever. The cursor is [serverSeq].
  TextColumn get updatedAt => text().named('updated_at')();

  /// Tombstone. Null means alive.
  ///
  /// schema.sql convention 3: NEVER DELETE A ROW. A hard delete cannot sync,
  /// because a missing row is indistinguishable from a row the peer has not
  /// seen yet. Every query against live data must filter `deletedAt IS NULL`.
  TextColumn get deletedAt => text().named('deleted_at').nullable()();

  /// Monotonic sequence stamped by the SERVER. The sync cursor.
  ///
  /// Null on a row created locally that has not yet been pushed — which is
  /// also the cheapest way to spot un-synced rows.
  IntColumn get serverSeq => integer().named('server_seq').nullable()();

  /// Optimistic concurrency counter, incremented on every local write.
  IntColumn get version =>
      integer().named('version').withDefault(const Constant(1))();
}
