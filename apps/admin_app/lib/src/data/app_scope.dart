import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:school_core/school_core.dart';

import '../sync/sync_service.dart';

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
    required super.child,
    super.key,
  });

  final AppDatabase database;
  final SyncService sync;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in context');
    return scope!;
  }

  static AppDatabase databaseOf(BuildContext context) => of(context).database;
  static SyncService syncOf(BuildContext context) => of(context).sync;

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      database != oldWidget.database || sync != oldWidget.sync;
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
