import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Standard frame for a section screen.
///
/// Exists so the eleven sections share one rhythm — same title size, same
/// gutter, same distance from the header to the content. Screens built
/// individually drift by a few pixels each and the app starts to feel assembled
/// rather than designed, which is the difference a principal notices without
/// being able to name it.
///
/// [toolbar] sits under the title for filters and pickers; [actions] sits on
/// the title line for the one primary verb.
class PageShell extends StatelessWidget {
  const PageShell({
    required this.title,
    required this.child,
    this.subtitle,
    this.actions,
    this.toolbar,
    this.tabs,
    this.padBody = false,
    super.key,
  });

  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? toolbar;
  final PreferredSizeWidget? tabs;
  final Widget child;

  /// Whether the body gets a gutter. False for full-bleed lists and tables,
  /// which read better running edge to edge under a divider.
  final bool padBody;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, 22, 28, toolbar == null ? 16 : 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.headlineSmall),
                    if (subtitle case final text?) ...[
                      const SizedBox(height: 2),
                      Text(text, style: theme.textTheme.bodySmall),
                    ],
                  ],
                ),
              ),
              if (actions case final widgets?) ...[
                const SizedBox(width: 16),
                Wrap(spacing: 10, children: widgets),
              ],
            ],
          ),
        ),
        if (toolbar case final widget?)
          Padding(
            padding: const EdgeInsets.fromLTRB(28, 0, 28, 14),
            child: widget,
          ),
        if (tabs case final widget?)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(alignment: Alignment.centerLeft, child: widget),
          ),
        const Divider(height: 1),
        Expanded(
          child: padBody
              ? Padding(padding: const EdgeInsets.all(28), child: child)
              : child,
        ),
      ],
    );
  }
}

/// A summary line above a list — "12 of 18 marked", "3 overdue".
///
/// Sits between the divider and the rows on a tinted strip, so the count reads
/// as a property of the list rather than as the first row of it.
class ListSummaryBar extends StatelessWidget {
  const ListSummaryBar({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 11),
      decoration: const BoxDecoration(
        color: AppTheme.canvas,
        border: Border(bottom: BorderSide(color: AppTheme.hairline)),
      ),
      child: Row(children: children),
    );
  }
}
