import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';
import '../widgets/page_shell.dart';

/// Notice board. A notice with no class goes to the whole school.
class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class _NoticesScreenState extends State<NoticesScreen> {
  late final SchoolRepository _repo;
  late String _actor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = SchoolRepository(AppScope.databaseOf(context));
    _actor = AppScope.actorOf(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageShell(
      title: 'Notices',
      subtitle: 'Posted here, on every phone at the next sync.',
      actions: [
        FilledButton.icon(
          onPressed: _compose,
          icon: const Icon(Icons.campaign_rounded, size: 17),
          label: const Text('Post notice'),
        ),
      ],
      child: StreamBuilder<List<Notice>>(
            stream: _repo.watchNotices(),
            builder: (context, snapshot) {
              final notices = snapshot.data ?? const [];
              if (notices.isEmpty) {
                return const EmptyState(
                  icon: Icons.campaign_outlined,
                  title: 'No notices',
                  detail: 'Anything posted here appears on every student\'s '
                      'phone at the next sync.',
                );
              }
              return ListView.separated(
                itemCount: notices.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final notice = notices[i];
                  final priority = NoticePriority.tryFromWire(notice.priority);
                  return ListTile(
                    leading: Icon(
                      switch (priority) {
                        NoticePriority.urgent => Icons.priority_high,
                        NoticePriority.important => Icons.flag_outlined,
                        _ => Icons.article_outlined,
                      },
                      color: switch (priority) {
                        NoticePriority.urgent => theme.colorScheme.error,
                        NoticePriority.important => Colors.orange,
                        _ => null,
                      },
                    ),
                    title: Text(notice.title),
                    subtitle: Text(
                      notice.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(notice.publishDate,
                            style: theme.textTheme.bodySmall),
                        IconButton(
                          tooltip: 'Remove',
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: () => _repo.deleteNotice(notice.id),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
      ),
    );
  }

  Future<void> _compose() async {
    final school = await _repo.school();
    if (school == null || !mounted) return;

    final classes = await _repo.watchClasses().first;
    final title = TextEditingController();
    final body = TextEditingController();
    var priority = NoticePriority.normal.wire;
    String? classId;

    if (!mounted) return;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          title: const Text('Post notice'),
          content: SizedBox(
            width: 480,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: title,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: body,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String?>(
                        initialValue: classId,
                        decoration: const InputDecoration(
                          labelText: 'Audience',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(
                              value: null, child: Text('Whole school')),
                          for (final c in classes)
                            DropdownMenuItem(
                                value: c.id, child: Text('Class ${c.displayName}')),
                        ],
                        onChanged: (v) => setLocal(() => classId = v),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: priority,
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          for (final p in NoticePriority.values)
                            DropdownMenuItem(value: p.wire, child: Text(p.wire)),
                        ],
                        onChanged: (v) => setLocal(() => priority = v ?? priority),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Post')),
          ],
        ),
      ),
    );

    if ((saved ?? false) && title.text.trim().isNotEmpty) {
      await _repo.saveNotice(
        schoolId: school.id,
        classId: classId,
        title: title.text.trim(),
        body: body.text.trim(),
        priority: priority,
        createdBy: _actor,
      );
    }
    title.dispose();
    body.dispose();
  }
}
