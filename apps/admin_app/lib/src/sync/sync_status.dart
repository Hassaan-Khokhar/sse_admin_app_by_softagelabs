/// What the sync status bar is currently showing.
///
/// CLAUDE.md §12 calls this the most important UI in the demo video: it is what
/// makes an invisible technical achievement legible to a principal. The whole
/// point of the film is
///
///     ⚠ 40 pending  →  ⚡ Syncing…  →  ✓ Synced just now
///
/// so these states exist to be *seen*, not merely to be correct.
enum SyncPhase {
  /// Nothing queued, nothing in flight. Everything the desktop knows, the
  /// server knows.
  idle,

  /// Local changes are waiting in the outbox. Either the connection is down or
  /// the next flush has not run yet.
  ///
  /// This is the normal state at the school, not an error state, and it must
  /// never be styled like a failure — the whole system is built on the
  /// assumption that the internet is out for hours at a time.
  pending,

  /// A push or pull is in flight right now.
  syncing,

  /// The last attempt failed. Changes are still queued and will retry; nothing
  /// has been lost.
  failed,
}

/// A snapshot of sync state for the UI.
class SyncStatus {
  const SyncStatus({
    required this.phase,
    this.pendingCount = 0,
    this.lastSyncedAt,
    this.lastError,
  });

  const SyncStatus.idle() : this._(SyncPhase.idle);

  const SyncStatus._(this.phase)
      : pendingCount = 0,
        lastSyncedAt = null,
        lastError = null;

  final SyncPhase phase;

  /// Rows sitting in the outbox.
  ///
  /// Marking a class of 40 puts 40 here at once, which is exactly the number
  /// the camera needs to see at 0:55 in the demo.
  final int pendingCount;

  /// When the last successful sync completed. Null if never.
  final DateTime? lastSyncedAt;

  /// Why the last attempt failed, if it did.
  final String? lastError;

  SyncStatus copyWith({
    SyncPhase? phase,
    int? pendingCount,
    DateTime? lastSyncedAt,
    String? lastError,
    bool clearError = false,
  }) =>
      SyncStatus(
        phase: phase ?? this.phase,
        pendingCount: pendingCount ?? this.pendingCount,
        lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
        lastError: clearError ? null : (lastError ?? this.lastError),
      );

  /// Human-readable summary for the status bar.
  String get label => switch (phase) {
        SyncPhase.syncing => 'Syncing…',
        SyncPhase.failed => 'Sync failed — will retry',
        SyncPhase.pending => pendingCount == 1
            ? '1 change pending'
            : '$pendingCount changes pending',
        SyncPhase.idle =>
          lastSyncedAt == null ? 'Not synced yet' : 'Synced ${_ago(lastSyncedAt!)}',
      };

  static String _ago(DateTime time) {
    final delta = DateTime.now().difference(time);
    if (delta.inSeconds < 60) return 'just now';
    if (delta.inMinutes < 60) return '${delta.inMinutes}m ago';
    if (delta.inHours < 24) return '${delta.inHours}h ago';
    return '${delta.inDays}d ago';
  }

  @override
  String toString() => 'SyncStatus($phase, pending: $pendingCount)';
}
