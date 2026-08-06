import 'package:flutter_test/flutter_test.dart';
import 'package:sse_admin_app/src/sync/sync_status.dart';

/// The status bar's wording is the only part of the sync engine a principal
/// ever sees (CLAUDE.md §12), so it is worth pinning down.
void main() {
  group('label', () {
    test('pending count is spelled out, not just a number', () {
      const status = SyncStatus(phase: SyncPhase.pending, pendingCount: 40);
      expect(status.label, '40 changes pending');
    });

    test('singular reads correctly', () {
      const status = SyncStatus(phase: SyncPhase.pending, pendingCount: 1);
      expect(status.label, '1 change pending');
    });

    test('syncing', () {
      const status = SyncStatus(phase: SyncPhase.syncing, pendingCount: 40);
      expect(status.label, 'Syncing…');
    });

    test('a fresh install has not synced yet, rather than claiming success', () {
      const status = SyncStatus(phase: SyncPhase.idle);
      expect(status.label, 'Not synced yet');
    });

    test('just-synced reads "just now" — the payoff shot in the demo', () {
      final status = SyncStatus(
        phase: SyncPhase.idle,
        lastSyncedAt: DateTime.now(),
      );
      expect(status.label, 'Synced just now');
    });

    test('older syncs degrade to minutes, hours, days', () {
      final now = DateTime.now();
      expect(
        SyncStatus(phase: SyncPhase.idle, lastSyncedAt: now.subtract(const Duration(minutes: 5))).label,
        'Synced 5m ago',
      );
      expect(
        SyncStatus(phase: SyncPhase.idle, lastSyncedAt: now.subtract(const Duration(hours: 3))).label,
        'Synced 3h ago',
      );
      expect(
        SyncStatus(phase: SyncPhase.idle, lastSyncedAt: now.subtract(const Duration(days: 2))).label,
        'Synced 2d ago',
      );
    });

    test('failure says it will retry — nothing is lost', () {
      // Queued work is never dropped. The wording has to say so, or the
      // principal will assume the attendance they just marked is gone.
      const status = SyncStatus(phase: SyncPhase.failed, pendingCount: 40);
      expect(status.label, contains('retry'));
    });
  });

  group('copyWith', () {
    test('clearError wins over an inherited error', () {
      const failed = SyncStatus(phase: SyncPhase.failed, lastError: 'boom');
      final retrying = failed.copyWith(phase: SyncPhase.syncing, clearError: true);
      expect(retrying.lastError, isNull);
      expect(retrying.phase, SyncPhase.syncing);
    });

    test('preserves fields that are not passed', () {
      final original = SyncStatus(
        phase: SyncPhase.pending,
        pendingCount: 12,
        lastSyncedAt: DateTime(2026, 8, 2),
      );
      final updated = original.copyWith(phase: SyncPhase.syncing);
      expect(updated.pendingCount, 12);
      expect(updated.lastSyncedAt, DateTime(2026, 8, 2));
    });
  });
}
