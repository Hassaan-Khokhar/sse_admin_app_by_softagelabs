import 'package:drift/drift.dart';

import 'sync_columns.dart';

/// Mirrors `lost_items` in schema.sql §7.
///
/// Together with [ItemClaims], the ONLY tables students may write to. That is
/// deliberate: it removes conflict resolution from the mobile app entirely
/// (CLAUDE.md §8).
///
/// SAFETY — these are minors. Claims go to the OFFICE, never
/// student-to-student, and a student's contact details are never shown. The
/// app is a notice board; the office does the handover.
@DataClassName('LostItem')
class LostItems extends Table with SyncColumns {
  @override
  String get tableName => 'lost_items';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();

  /// `LostItemType.wire` — `'lost'` | `'found'`.
  TextColumn get type => text()();

  TextColumn get title => text()();
  TextColumn get description => text().nullable()();

  /// `LostItemCategory.wire`.
  TextColumn get category => text().nullable()();

  /// `'near canteen'`, `'ground'`.
  TextColumn get location => text().nullable()();

  TextColumn get incidentDate => text().named('incident_date').nullable()();
  TextColumn get reportedBy => text().named('reported_by')();

  /// `LostItemStatus.wire`, defaulting to `'open'`.
  TextColumn get status => text().withDefault(const Constant('open'))();

  /// `ModerationState.wire`, defaulting to `'pending'`.
  TextColumn get moderation =>
      text().withDefault(const Constant('pending'))();

  /// Auto-hides at `autoHideReportCount` (policy.dart).
  IntColumn get reportCount =>
      integer().named('report_count').withDefault(const Constant(0))();

  TextColumn get moderatedBy => text().named('moderated_by').nullable()();

  /// JSONB → TEXT: a json array of `{key, url, thumb_url}`.
  ///
  /// Photos NEVER travel through the sync log — separate pipeline, file first
  /// then row, or peers pull a row whose image 404s (CLAUDE.md §10).
  TextColumn get photos => text().withDefault(const Constant('[]'))();

  /// When the item auto-archives and its photos are deleted.
  TextColumn get expiresAt => text().named('expires_at').nullable()();

  /// When the item was posted.
  ///
  /// NOTE — this column is missing from schema.sql as committed: the index
  /// `idx_lost_items_feed` at schema.sql:482 already sorts on `created_at`, so
  /// that CREATE INDEX fails against a fresh Postgres. It is also required for
  /// the 30-day expiry sweep and for the weekly per-student post limit. Adding
  /// it to schema.sql is a contract change — tell the student-app dev.
  TextColumn get createdAt => text().named('created_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Mirrors `item_claims` in schema.sql §7.
///
/// A claim is a student saying "that's mine" to the OFFICE. It never puts two
/// students in contact.
@DataClassName('ItemClaim')
class ItemClaims extends Table with SyncColumns {
  @override
  String get tableName => 'item_claims';

  TextColumn get id => text()();
  TextColumn get schoolId => text().named('school_id')();
  TextColumn get itemId => text().named('item_id')();
  TextColumn get claimedBy => text().named('claimed_by')();
  TextColumn get message => text().nullable()();

  /// `ClaimStatus.wire`, defaulting to `'pending'`.
  TextColumn get status => text().withDefault(const Constant('pending'))();

  TextColumn get handledBy => text().named('handled_by').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
