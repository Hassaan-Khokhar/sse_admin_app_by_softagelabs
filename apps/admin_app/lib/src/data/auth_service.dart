import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_bootstrap.dart';

/// Sign-in state for the admin app.
///
/// Offline behaviour is the interesting part. Supabase persists the session to
/// disk, so a principal who logged in yesterday is still logged in this
/// morning with the internet down — [restore] reads that stored session
/// without a network round trip.
///
/// What cannot work offline is the FIRST login on a fresh install: there is no
/// stored session and no way to verify a password locally. The UI says so
/// plainly rather than spinning.
class AuthService extends ChangeNotifier {
  AuthState _state = AuthState.checking;
  String? _error;
  User? _user;

  AuthState get state => _state;
  String? get error => _error;
  User? get user => _user;
  bool get isSignedIn => _user != null;

  /// Looks for a stored session. Called once at startup.
  Future<void> restore() async {
    final available = await SupabaseBootstrap.ready;

    if (!available) {
      // Supabase never came up. Without it there is no way to read even a
      // stored session, so the app can only offer local-only mode.
      _set(AuthState.unavailable);
      return;
    }

    SupabaseBootstrap.client.auth.onAuthStateChange.listen((data) {
      _user = data.session?.user;
      _set(_user == null ? AuthState.signedOut : AuthState.signedIn);
    });

    _user = SupabaseBootstrap.client.auth.currentUser;
    _set(_user == null ? AuthState.signedOut : AuthState.signedIn);
  }

  Future<bool> signIn({required String email, required String password}) async {
    _error = null;
    _set(AuthState.signingIn);

    if (!await SupabaseBootstrap.ready) {
      _error = 'No connection. The first sign-in on this PC needs internet — '
          'after that the app works offline.';
      _set(AuthState.signedOut);
      return false;
    }

    try {
      final response = await SupabaseBootstrap.client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      _user = response.user;
      _set(_user == null ? AuthState.signedOut : AuthState.signedIn);
      return _user != null;
    } on AuthException catch (failure) {
      _error = failure.message;
      _set(AuthState.signedOut);
      return false;
    } on Object catch (failure) {
      _error = 'Could not reach the server. $failure';
      _set(AuthState.signedOut);
      return false;
    }
  }

  Future<void> signOut() async {
    if (SupabaseBootstrap.isReady) {
      try {
        await SupabaseBootstrap.client.auth.signOut();
      } on Object catch (failure) {
        // Signing out locally matters more than telling the server about it.
        debugPrint('Sign-out did not reach the server: $failure');
      }
    }
    _user = null;
    _set(AuthState.signedOut);
  }

  /// Continue without an account.
  ///
  /// Everything the app does reads and writes local SQLite, so it is fully
  /// usable offline — the outbox simply keeps growing until someone signs in
  /// and it can be pushed. Better than a login wall the principal cannot pass
  /// when the internet is down.
  void continueOffline() => _set(AuthState.localOnly);

  void _set(AuthState next) {
    _state = next;
    notifyListeners();
  }
}

enum AuthState {
  /// Startup — looking for a stored session.
  checking,

  /// Supabase could not start. Local-only is the only option.
  unavailable,

  signedOut,
  signingIn,
  signedIn,

  /// Explicitly working offline without an account.
  localOnly,
}
