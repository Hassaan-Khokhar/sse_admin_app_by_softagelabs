import 'package:flutter/material.dart';

/// Placeholder for a screen with nothing to show yet.
///
/// Always says what to do next rather than just "no data" — an empty screen
/// with no instruction leaves the principal unsure whether it is broken.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.icon,
    required this.title,
    required this.detail,
    this.action,
    super.key,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: theme.disabledColor),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Text(
              detail,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          if (action case final widget?) ...[
            const SizedBox(height: 16),
            widget,
          ],
        ],
      ),
    );
  }
}
