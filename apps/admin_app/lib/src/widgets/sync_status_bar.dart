import 'package:flutter/material.dart';

import '../data/app_scope.dart';
import '../sync/sync_status.dart';
import '../theme/app_theme.dart';

/// The sync status bar.
///
/// CLAUDE.md §12: "The sync status bar is the most important UI in the video —
/// it's what makes an invisible technical achievement visible to a principal."
///
/// Three things follow from being filmed rather than merely used:
///
///   * it is oversized for a status bar, because it has to be legible in a
///     screen recording played on a phone;
///   * `pending` is amber, never red. Queued work at this school is the normal
///     condition, not a fault — the internet is out for hours at a time and
///     the app is designed for exactly that;
///   * the count is spelled out ("40 changes pending"), because "40" alone
///     means nothing to a principal watching.
class SyncStatusBar extends StatelessWidget {
  const SyncStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    final sync = AppScope.syncOf(context);

    return StreamBuilder<SyncStatus>(
      stream: sync.statusStream,
      initialData: sync.status,
      builder: (context, snapshot) {
        final status = snapshot.data ?? const SyncStatus.idle();
        final palette = _paletteFor(status.phase, Theme.of(context));

        return Material(
          color: palette.background,
          child: InkWell(
            // Manual sync. During the demo the principal does not touch this —
            // reconnecting is enough — but it matters when the connection is
            // technically up yet flaky, which is the school's usual state.
            onTap: status.phase == SyncPhase.syncing ? null : sync.syncNow,
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppTheme.hairline)),
              ),
              child: Row(
                children: [
                  _StatusIcon(phase: status.phase, color: palette.foreground),
                  const SizedBox(width: 10),
                  Text(
                    status.label,
                    style: TextStyle(
                      color: palette.foreground,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  if (status.lastError case final error?)
                    Flexible(
                      child: Text(
                        error,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: palette.foreground.withValues(alpha: 0.75),
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ({Color background, Color foreground}) _paletteFor(
    SyncPhase phase,
    ThemeData theme,
  ) {
    final dark = theme.brightness == Brightness.dark;
    return switch (phase) {
      SyncPhase.idle => (
          background: dark ? const Color(0xFF14532D) : const Color(0xFFDCFCE7),
          foreground: dark ? const Color(0xFFBBF7D0) : const Color(0xFF166534),
        ),
      // Amber, not red — see the class doc.
      SyncPhase.pending => (
          background: dark ? const Color(0xFF713F12) : const Color(0xFFFEF3C7),
          foreground: dark ? const Color(0xFFFDE68A) : const Color(0xFF854D0E),
        ),
      SyncPhase.syncing => (
          background: dark ? const Color(0xFF1E3A5F) : const Color(0xFFDBEAFE),
          foreground: dark ? const Color(0xFFBFDBFE) : const Color(0xFF1E40AF),
        ),
      SyncPhase.failed => (
          background: dark ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2),
          foreground: dark ? const Color(0xFFFECACA) : const Color(0xFF991B1B),
        ),
    };
  }
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.phase, required this.color});

  final SyncPhase phase;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (phase == SyncPhase.syncing) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    return Icon(
      switch (phase) {
        SyncPhase.idle => Icons.cloud_done_outlined,
        SyncPhase.pending => Icons.cloud_upload_outlined,
        SyncPhase.failed => Icons.cloud_off_outlined,
        SyncPhase.syncing => Icons.sync, // unreachable, handled above
      },
      size: 18,
      color: color,
    );
  }
}
