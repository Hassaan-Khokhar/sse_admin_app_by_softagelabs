import 'dart:async';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/data/app_scope.dart';
import 'src/data/supabase_bootstrap.dart';
import 'src/sync/sync_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local first, and local only. Opening SQLite is fast and cannot fail for
  // want of a network, so it is the one thing worth awaiting before the first
  // frame — everything the UI shows comes from here.
  final database = openLocalDatabase();
  final sync = SyncService(database);

  runApp(AdminApp(database: database, sync: sync));

  // Supabase comes up AFTER the first frame, and is deliberately not awaited.
  //
  // Initialising restores the stored session, which can touch the network to
  // refresh a token. Awaiting it before runApp would mean that at a school
  // whose internet is down for hours, the app hangs on a blank window until
  // that request times out — the exact failure the whole offline-first design
  // exists to prevent (CLAUDE.md §2).
  unawaited(SupabaseBootstrap.start());
}
