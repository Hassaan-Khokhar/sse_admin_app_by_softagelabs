import 'dart:async';

import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

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
  }

  final AppDatabase _db;
  final _controller = StreamController<SyncStatus>.broadcast();

  StreamSubscription<int>? _pendingSubscription;
  SyncStatus _status = const SyncStatus.idle();
  Timer? _relabelTimer;

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
  /// NOT IMPLEMENTED YET — the transport is the next piece of work. The status
  /// plumbing above is real and driven by the actual outbox table; this method
  /// is the only stub, and it is deliberately obvious rather than quietly
  /// pretending to succeed.
  Future<void> syncNow() async {
    if (_status.phase == SyncPhase.syncing) return;

    _emit(_status.copyWith(phase: SyncPhase.syncing, clearError: true));
    try {
      // TODO(sync): push the outbox in batches of `syncPushBatchSize`, each op
      //   carrying its `op_id` so a retry after a dropped connection dedupes
      //   server-side instead of duplicating. Then pull. Push before pull.
      throw UnimplementedError('Sync transport not built yet');
    } on Object catch (error) {
      _fail(error.toString());
    }
  }

  Future<void> dispose() async {
    _relabelTimer?.cancel();
    await _pendingSubscription?.cancel();
    await _controller.close();
  }
}
