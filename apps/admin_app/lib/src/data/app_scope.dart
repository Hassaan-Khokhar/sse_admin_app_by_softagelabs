import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:school_core/school_core.dart';

import '../sync/sync_service.dart';
import 'auth_service.dart';

/// Holds the long-lived objects the whole app shares: the local database and
/// the sync service.
///
/// Deliberately an InheritedWidget rather than a state-management package.
/// Drift already exposes reactive `.watch()` streams, so the data layer needs
/// no extra machinery, and CLAUDE.md doesn't mandate a choice. If the app
/// later grows state that isn't database-backed, that's the moment to pick
/// one — not before.
class AppScope extends InheritedWidget {
  const AppScope({
    required this.database,
    required this.sync,
    required this.auth,
    required super.child,
    super.key,
  });

  final AppDatabase database;
  final SyncService sync;
  final AuthService auth;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!;
  }

  static AppDatabase databaseOf(BuildContext context) => of(context).database;
  static SyncService syncOf(BuildContext context) => of(context).sync;

  /// Who to record as the author of a write — `marked_by`, `entered_by`,
  /// `created_by`, `received_by`.
  ///
  /// The signed-in principal when there is one. Working offline without an
  /// account falls back to the seeded principal, because those columns are
  /// NOT NULL and REFERENCE app_users: there is no "anonymous" option the
  /// database would accept, and refusing the write instead would mean the
  /// register cannot be marked at 8am on a morning the internet is down —
  /// exactly the case this whole system exists for.
  ///
  /// The fallback is a real row on the server, so the foreign key holds when
  /// the change is eventually pushed.
  static String actorOf(BuildContext context) =>
      of(context).auth.user?.id ?? DemoSeeder.principalUserId;

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      database != oldWidget.database ||
      sync != oldWidget.sync ||
      auth != oldWidget.auth;
}

/// Opens the local SQLite database.
///
/// `school_core` stays pure Dart and takes a QueryExecutor, so this is where
/// the platform-specific part lives. drift_flutter puts the file in the app's
/// documents directory and bundles the sqlite3 native library.
///
/// The whole school is roughly 30 MB, so this is a small file by any measure —
/// and it is the ONLY thing the UI ever reads from. The network is a sync
/// channel, not a dependency (CLAUDE.md §2).
AppDatabase openLocalDatabase() =>
    AppDatabase(driftDatabase(name: 'sse_school'));
