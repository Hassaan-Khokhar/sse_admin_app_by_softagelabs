import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:school_core/school_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show PostgrestException;

import '../data/supabase_bootstrap.dart';
import 'sync_engine.dart';
import 'sync_status.dart';

/// Drives sync and publishes what the status bar shows.
///
/// Two rules from CLAUDE.md that shape everything here:
///
///   * **The UI never waits on this.** Every read and write in the app hits
///     local SQLite. This class only moves data between that database and the
///     server, in the background, whenever the network happens to be there.
///
///   * **Push before pull, always.** Pulling first would fetch the server's
///     stale copy of a row just changed locally and overwrite it.
class SyncService {
  SyncService(this._db) {
    _pendingSubscription = _watchPendingCount().listen(
      _onPendingCountChanged,
      onError: (Object error) => _fail(error.toString()),
    );
    _startAutoSync();
  }

  /// Sync runs on its own; the status bar is a readout, not a button.
  ///
  /// The demo beat at CLAUDE.md §12 1:05 is "turn the wifi back on → ✓ Synced
  /// just now". Nobody presses anything. If a principal had to remember to
  /// click sync, half a morning of attendance would sit unpushed and the first
  /// anyone would know is a parent asking why the app shows nothing.
  ///
  /// The interval is short because the connection is the unreliable part: when
  /// it returns, we want to be inside a minute of noticing.
  static const _autoSyncInterval = Duration(seconds: 30);

  void _startAutoSync() {
    _autoSyncTimer?.cancel();
    _autoSyncTimer = Timer.periodic(_autoSyncInterval, (_) => _autoSync());
    // Also try once at startup — the app may be opening after hours offline
    // with a full outbox.
    Future<void>.delayed(const Duration(seconds: 3), _autoSync);
  }

  Future<void> _autoSync() async {
    if (_status.phase == SyncPhase.syncing) return;
    // Nothing queued and we have synced recently: pull anyway, but not on
    // every tick — the server is the only source of student-app changes
    // (lost & found posts), and those should appear without a restart.
    await syncNow(silent: true);
  }

  final AppDatabase _db;
  final _controller = StreamController<SyncStatus>.broadcast();

  StreamSubscription<int>? _pendingSubscription;
  SyncStatus _status = const SyncStatus.idle();
  Timer? _relabelTimer;
  Timer? _autoSyncTimer;

  /// Current status. Safe to read synchronously for the first frame.
  SyncStatus get status => _status;

  /// Status updates for the status bar.
  Stream<SyncStatus> get statusStream => _controller.stream;

  /// Number of un-pushed local writes, straight from the outbox.
  ///
  /// This is a real Drift stream, so it updates the moment a row is queued —
  /// no polling, and no chance of the badge disagreeing with the database.
  /// Marking a class of 40 makes this jump to 40 in one frame.
  Stream<int> _watchPendingCount() {
    final pending = _db.outbox.seq.count();
    final query = _db.selectOnly(_db.outbox)..addColumns([pending]);
    return query.map((row) => row.read(pending) ?? 0).watchSingle();
  }

  void _onPendingCountChanged(int count) {
    // A flush in progress keeps saying "Syncing…" even as the count drops;
    // otherwise the bar would flicker between states mid-push.
    if (_status.phase == SyncPhase.syncing) {
      _emit(_status.copyWith(pendingCount: count));
      return;
    }

    _emit(_status.copyWith(
      phase: count > 0 ? SyncPhase.pending : SyncPhase.idle,
      pendingCount: count,
    ));
  }

  void _emit(SyncStatus status) {
    _status = status;
    if (!_controller.isClosed) _controller.add(status);
    _scheduleRelabel();
  }

  /// "Synced just now" silently becomes wrong after a minute.
  ///
  /// Nothing else would ever rebuild the bar while the app sits idle, so it
  /// would keep claiming "just now" indefinitely — which is precisely the
  /// state the demo lingers on.
  void _scheduleRelabel() {
    _relabelTimer?.cancel();
    if (_status.phase != SyncPhase.idle || _status.lastSyncedAt == null) return;
    _relabelTimer = Timer(const Duration(seconds: 45), () {
      if (!_controller.isClosed) _controller.add(_status);
      _scheduleRelabel();
    });
  }

  void _fail(String error) {
    _emit(_status.copyWith(phase: SyncPhase.failed, lastError: error));
  }

  /// Pushes the outbox, then pulls changes.
  ///
  /// **Push before pull, always** (CLAUDE.md §10). Pulling first would fetch
  /// the server's stale copy of a row that was just changed locally and
  /// overwrite the local edit — the principal's change would silently vanish.
  ///
  /// [silent] suppresses the error state for background attempts. A timer tick
  /// that finds no internet should not paint the bar red — being offline is
  /// the expected condition here, and a bar that cries wolf every 30 seconds
  /// is a bar nobody reads. Manual attempts always report.
  Future<void> syncNow({bool silent = false}) async {
    if (_status.phase == SyncPhase.syncing) return;

    if (!await SupabaseBootstrap.ready) {
      if (!silent) _fail('No connection — changes stay queued.');
      return;
    }

    // Not signed in means every write is denied by RLS. Say so rather than
    // letting the request fail with a 401 the principal cannot interpret.
    //
    // Reported even on a silent run, unlike being offline. Offline is a
    // transient condition that fixes itself; being signed out never does, and
    // staying quiet about it means the outbox grows all week while the bar
    // cheerfully shows nothing wrong.
    if (SupabaseBootstrap.client.auth.currentUser == null) {
      _fail('Sign in to sync. Changes are safe and stay queued.');
      return;
    }

    _emit(_status.copyWith(phase: SyncPhase.syncing, clearError: true));
    final engine = SyncEngine(_db);

    try {
      // Drain in batches until empty. Bulk challan generation puts one row per
      // student in the outbox — 800 at a real school — and pushing those as a
      // single request over this connection would never complete.
      var guard = 0;
      while (await engine.hasPending()) {
        await engine.push();
        if (++guard > 100) {
          throw StateError('Outbox did not drain after 100 batches');
        }
      }

      await engine.pull(since: await _readCursor());

      final now = DateTime.now();
      await _writeCursor(encodeTimestamp(now));
      _emit(SyncStatus(
        phase: SyncPhase.idle,
        pendingCount: 0,
        lastSyncedAt: now,
      ));
    } on Object catch (error) {
      // Nothing is lost on failure: un-pushed rows are still in the outbox and
      // the cursor is not advanced, so the next attempt repeats the work.
      //
      // Errors are surfaced even on a silent run. A silent attempt hides
      // "you're offline", which is routine; it must not hide "the server
      // rejected your data", which is a bug someone needs to see.
      _fail(_readable(error));
    }
  }

  /// Turns transport noise into something a principal can act on.
  ///
  /// The raw error is always logged first. A friendly message is right for the
  /// status bar, but it must never be the ONLY record — a mapped string like
  /// "session expired" is a guess about a cause, and debugging it without the
  /// original text is guesswork on top of guesswork.
  String _readable(Object error) {
    final text = error.toString();
    debugPrint('SYNC FAILED — raw error: $text');
    if (error is PostgrestException) {
      debugPrint(
        '  code=${error.code} details=${error.details} hint=${error.hint}',
      );
    }
    if (text.contains('SocketException') || text.contains('Failed host')) {
      return 'No internet — changes stay queued.';
    }
    // Checked BEFORE the JWT case: a revoked or wrong publishable key also
    // returns 401, and reporting it as "session expired" sends whoever is
    // debugging to the login screen instead of to the key in the config.
    if (text.contains('Unregistered API key') || text.contains('Invalid API key')) {
      return 'App key rejected by the server — it may have been rotated.';
    }
    if (text.contains('JWT') || text.contains('401')) {
      return 'Session expired — sign in again.';
    }
    if (text.contains('row-level security') || text.contains('42501')) {
      return 'Not permitted. Is this account a super_admin?';
    }
    // Happens when the server was cleared but this PC still holds the data:
    // an attendance row is pushed for a student the server has never seen.
    // The row is not lost — it stays queued — but the outbox cannot drain
    // until the parent rows are uploaded first.
    if (text.contains('foreign key constraint') || text.contains('23503')) {
      return 'Server is missing related records. '
          'Use Dashboard → "Queue all for push" to upload everything.';
    }
    return text;
  }

  Future<String?> _readCursor() async {
    final query = _db.select(_db.syncState)
      ..where((s) => s.key.equals(SyncStateKeys.lastSyncedAt));
    final row = await query.getSingleOrNull();
    return row?.value;
  }

  Future<void> _writeCursor(String value) async {
    await _db.into(_db.syncState).insertOnConflictUpdate(
          SyncStateEntry(key: SyncStateKeys.lastSyncedAt, value: value),
        );
  }

  Future<void> dispose() async {
    _autoSyncTimer?.cancel();
    _relabelTimer?.cancel();
    await _pendingSubscription?.cancel();
    await _controller.close();
  }
}
