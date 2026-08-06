import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:school_core/school_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Brings Supabase up without ever blocking the UI.
///
/// `Supabase.instance` throws if it is read before `initialize` completes, and
/// initialize itself can touch the network to refresh a stored token. Since
/// the app deliberately starts before Supabase is ready (CLAUDE.md §2), any
/// code that wants the client has to wait for [ready] rather than assume.
///
/// [ready] completes with `false` rather than throwing when the network is
/// down. That is not an error state here — it is Tuesday at this school.
class SupabaseBootstrap {
  SupabaseBootstrap._();

  static final _readyCompleter = Completer<bool>();

  /// Resolves true once the client is usable, false if it could not start.
  ///
  /// Never throws, and never hangs forever — see the timeout in [start].
  static Future<bool> get ready => _readyCompleter.future;

  /// True if initialize has already succeeded, for synchronous checks.
  static bool get isReady => _isReady;
  static bool _isReady = false;

  /// The client. Only valid once [ready] has completed true.
  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> start() async {
    if (_readyCompleter.isCompleted) return;

    if (!SupabaseConfig.isConfigured) {
      debugPrint('Supabase not configured — running local-only.');
      _readyCompleter.complete(false);
      return;
    }

    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        publishableKey: SupabaseConfig.publishableKey,
      ).timeout(
        // A hard ceiling matters more than it looks. Without it, a connection
        // that is technically up but not passing traffic — a captive portal, a
        // school router that accepts packets and drops them — leaves this
        // hanging indefinitely, and anything awaiting `ready` hangs with it.
        const Duration(seconds: 20),
      );
      _isReady = true;
      if (!_readyCompleter.isCompleted) _readyCompleter.complete(true);
      debugPrint('Supabase ready: ${SupabaseConfig.url}');
    } on Object catch (error) {
      debugPrint('Supabase unavailable (offline?): $error');
      if (!_readyCompleter.isCompleted) _readyCompleter.complete(false);
    }
  }
}
