import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';

/// Lost & Found moderation queue.
///
/// Students post from their phones; this is where the office reviews them.
/// The moderation rules are not optional — 800 teenagers, free text and photos
/// (CLAUDE.md §7).
///
/// Two safety rules shape this screen. Claims go to the OFFICE, never
/// student-to-student, so there is no "message the finder" anywhere here. And
/// no student's contact details are ever shown: the app is a notice board, the
/// office does the handover in person.
class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> {
  late final SchoolRepository _repo;
  bool _flaggedOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = SchoolRepository(AppScope.databaseOf(context));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
          child: Row(
            children: [
              Text('Lost & Found', style: theme.textTheme.headlineSmall),
              const SizedBox(width: 24),
              FilterChip(
                label: Text('Needs review (≥$autoHideReportCount reports)'),
                selected: _flaggedOnly,
                onSelected: (v) => setState(() => _flaggedOnly = v),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: StreamBuilder<List<LostItem>>(
            stream: _repo.watchLostItems(),
            builder: (context, snapshot) {
              var items = snapshot.data ?? const <LostItem>[];
              if (_flaggedOnly) {
                items = items
                    .where((i) => i.reportCount >= autoHideReportCount)
                    .toList();
              }

              if (items.isEmpty) {
                return EmptyState(
                  icon: Icons.search_outlined,
                  title: _flaggedOnly ? 'Nothing flagged' : 'No items posted',
                  detail: _flaggedOnly
                      ? 'No post has reached $autoHideReportCount reports.'
                      : 'Items posted by students from the mobile app appear '
                          'here for review.',
                );
              }

              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) => _ItemTile(
                  item: items[i],
                  onModerate: (state) => _repo.moderate(
                    item: items[i],
                    state: state,
                    moderatedBy: DemoSeeder.principalUserId,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({required this.item, required this.onModerate});

  final LostItem item;
  final ValueChanged<ModerationState> onModerate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moderation = ModerationState.tryFromWire(item.moderation);
    final type = LostItemType.tryFromWire(item.type);
    final flagged = item.reportCount >= autoHideReportCount;

    return ListTile(
      isThreeLine: true,
      leading: Icon(
        type == LostItemType.found
            ? Icons.inventory_2_outlined
            : Icons.help_outline,
        color: flagged ? theme.colorScheme.error : null,
      ),
      title: Row(
        children: [
          Flexible(child: Text(item.title)),
          const SizedBox(width: 8),
          if (moderation != ModerationState.visible)
            Chip(
              label: Text(moderation?.wire ?? '?',
                  style: const TextStyle(fontSize: 11)),
              visualDensity: VisualDensity.compact,
              backgroundColor: theme.colorScheme.errorContainer
                  .withValues(alpha: 0.4),
            ),
          if (item.reportCount > 0) ...[
            const SizedBox(width: 6),
            Chip(
              avatar: const Icon(Icons.flag_outlined, size: 14),
              label: Text('${item.reportCount}',
                  style: const TextStyle(fontSize: 11)),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.description case final d?) Text(d, maxLines: 2, overflow: TextOverflow.ellipsis),
          Text(
            [
              type?.wire ?? '',
              ?item.category,
              ?item.location,
            ].where((s) => s.isNotEmpty).join(' · '),
            style: theme.textTheme.bodySmall,
          ),
          // Deliberately no poster name or contact. Claims are handled at the
          // office; the app never puts two students in touch.
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (moderation == ModerationState.visible)
            TextButton(
              onPressed: () => onModerate(ModerationState.hidden),
              child: const Text('Hide'),
            )
          else if (moderation == ModerationState.hidden)
            TextButton(
              onPressed: () => onModerate(ModerationState.visible),
              child: const Text('Restore'),
            ),
          const SizedBox(width: 4),
          if (moderation != ModerationState.removed)
            OutlinedButton(
              onPressed: () => onModerate(ModerationState.removed),
              child: const Text('Remove'),
            ),
        ],
      ),
    );
  }
}
