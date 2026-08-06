/// LOCAL-ONLY tables. These exist in SQLite on each device and must NEVER be
/// created in Postgres — see the block at the end of schema.sql §8.
///
/// They carry no sync columns, because they are the machinery that does the
/// syncing.
library;

import 'package:drift/drift.dart';

/// The outbox: every local write that has not yet reached the server.
///
/// CLAUDE.md §10 — every local write is ONE transaction that both updates the
/// row and inserts here. If those two could come apart, a change would either
/// be applied locally and never sent, or sent and never applied.
@DataClassName('OutboxEntry')
class Outbox extends Table {
  @override
  String get tableName => 'outbox';

  /// Strict FIFO drain order.
  ///
  /// Ordering matters for causality: the student row must be pushed before the
  /// attendance row that references it. [opId] is a UUIDv7 and so is *roughly*
  /// chronological, but it only has millisecond resolution — marking 40
  /// students lands many ops in the same millisecond, and their relative order
  /// would be undefined. An autoincrement integer is exact.
  IntColumn get seq => integer().autoIncrement()();

  /// Client-generated, echoed to the server as `sync_ops.op_id`.
  ///
  /// The idempotency key. If the connection drops after the server commits but
  /// before the client sees the response, the retry carries the same op_id and
  /// the server recognises the work as already done instead of duplicating it.
  TextColumn get opId => text().named('op_id').unique()();

  TextColumn get tableNameRef => text().named('table_name')();
  TextColumn get rowId => text().named('row_id')();

  /// `SyncOp.wire` — `'upsert'` | `'delete'`.
  ///
  /// `delete` means a tombstone was written, never that a row was removed.
  TextColumn get op => text()();

  /// The full row, json-encoded.
  TextColumn get payload => text()();

  TextColumn get createdAt => text().named('created_at')();

  IntColumn get attempts =>
      integer().withDefault(const Constant(0))();

  TextColumn get lastError => text().named('last_error').nullable()();
}

/// Queued photo uploads.
///
/// A SEPARATE pipeline from [Outbox] on purpose. Photos are large and slow;
/// putting them in the same queue would let one 200 KB image block 40
/// attendance rows behind it. The file uploads FIRST, then the row referencing
/// it is pushed — the other order makes peers pull rows whose images 404
/// (CLAUDE.md §10).
@DataClassName('AttachmentOutboxEntry')
class AttachmentOutbox extends Table {
  @override
  String get tableName => 'attachment_outbox';

  TextColumn get id => text()();

  /// Absolute path on this device. Meaningless to any peer.
  TextColumn get localPath => text().named('local_path')();

  /// Destination key in Supabase Storage.
  TextColumn get storageKey => text().named('storage_key')();

  /// Table and row this attachment belongs to, so the row can be pushed once
  /// the upload lands.
  TextColumn get ownerTable => text().named('owner_table')();
  TextColumn get ownerRowId => text().named('owner_row_id')();

  /// `AttachmentStatus.wire`.
  TextColumn get status => text().withDefault(const Constant('pending'))();

  IntColumn get attempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().named('last_error').nullable()();
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Key/value scratch space for the sync engine.
///
/// Known keys are in `SyncStateKeys`.
@DataClassName('SyncStateEntry')
class SyncState extends Table {
  @override
  String get tableName => 'sync_state';

  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

/// The keys stored in [SyncState].
abstract final class SyncStateKeys {
  /// Highest `server_seq` this device has pulled. The sync cursor.
  ///
  /// A monotonic BIGINT, never a timestamp — a school PC whose clock is two
  /// days behind would silently skip changes forever (CLAUDE.md §10).
  static const String cursor = 'cursor';

  /// When the last successful sync completed, for the "✓ Synced just now"
  /// status bar. Display only.
  static const String lastSyncedAt = 'last_synced_at';

  /// Stable per-install identifier, sent with every push.
  static const String deviceId = 'device_id';

  /// School this install is bound to.
  static const String schoolId = 'school_id';
}
