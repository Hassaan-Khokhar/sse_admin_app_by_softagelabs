import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// A section of the admin app.
typedef SidebarItem = ({String label, IconData icon, Color color});

/// The left navigation rail.
///
/// Custom rather than Flutter's [NavigationRail] because that widget paints
/// every icon one colour by theme, and the whole point here is that each
/// section has its own. Eleven grey glyphs are a list you have to read; eleven
/// coloured ones are a place you learn.
///
/// Each item carries a distinct icon AND its name in words, so the colour is a
/// landmark rather than the identity — nothing is lost if two hues look alike.
class AppSidebar extends StatelessWidget {
  const AppSidebar({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    required this.footer,
    super.key,
  });

  final List<SidebarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Widget footer;

  static const width = 96.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: AppTheme.surface,
        border: Border(right: BorderSide(color: AppTheme.hairline)),
      ),
      child: Column(
        children: [
          const _Crest(),
          Expanded(
            // Scrolls only when it must. Sections keep being added, and a rail
            // that overflows by nine pixels is how that shows up.
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 6),
              itemCount: items.length,
              itemBuilder: (context, i) => _SidebarTile(
                item: items[i],
                selected: i == selectedIndex,
                onTap: () => onSelected(i),
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: footer,
          ),
        ],
      ),
    );
  }
}

class _Crest extends StatelessWidget {
  const _Crest();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppTheme.hairline)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppTheme.navyLight, AppTheme.navyDark],
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.account_balance,
                size: 21, color: Colors.white),
          ),
          const SizedBox(height: 7),
          const Text(
            'IGS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
              color: AppTheme.navy,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatefulWidget {
  const _SidebarTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final SidebarItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<_SidebarTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.item.color;
    final selected = widget.selected;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          margin: const EdgeInsets.fromLTRB(8, 3, 8, 3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            // The selected tile is tinted with its OWN colour, not a global
            // highlight — so the eye lands on the same hue it just clicked.
            color: selected
                ? color.withValues(alpha: 0.12)
                : _hovered
                    ? AppTheme.surfaceMuted
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall + 2),
          ),
          child: Column(
            children: [
              // Unselected icons keep their hue at reduced opacity rather than
              // going grey: the rail stays legible as a set of places, and
              // selection reads as "brighter", not "the only coloured one".
              Icon(
                widget.item.icon,
                size: 21,
                color: selected ? color : color.withValues(alpha: 0.62),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Text(
                  widget.item.label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10.5,
                    height: 1.15,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected ? color : AppTheme.inkSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
