import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';
import 'package:intl/intl.dart';

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
  List<SchoolClass>? _classes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = SchoolRepository(AppScope.databaseOf(context));
    _actor = AppScope.actorOf(context);
    _repo.watchClasses().listen((classes) {
      if (mounted) setState(() => _classes = classes);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PageShell(
      title: 'Noticeboard',
      subtitle: 'Post announcements and updates for students and faculty.',
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
              detail: 'Anything posted here appears on every student\'s phone at the next sync.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: notices.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final notice = notices[i];
              final priority = NoticePriority.tryFromWire(notice.priority);
              
              final isExpired = notice.expiresAt != null && 
                  DateTime.now().isAfter(DateTime.parse(notice.expiresAt!));

              Color priorityColor = theme.colorScheme.primary;
              IconData priorityIcon = Icons.article_outlined;
              if (priority == NoticePriority.urgent) {
                priorityColor = theme.colorScheme.error;
                priorityIcon = Icons.priority_high;
              } else if (priority == NoticePriority.important) {
                priorityColor = Colors.orange;
                priorityIcon = Icons.flag_outlined;
              }

              String audienceText = 'Whole School';
              if (notice.isFacultyOnly) {
                audienceText = 'Faculty Only';
              } else if (notice.classId != null && _classes != null) {
                final c = _classes!.where((c) => c.id == notice.classId).firstOrNull;
                if (c != null) {
                  audienceText = 'Class ${c.displayName}';
                }
              }

              return Opacity(
                opacity: isExpired ? 0.6 : 1.0,
                child: Card(
                  elevation: 2,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: Text(notice.title),
                          content: SizedBox(
                            width: 400,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(priorityIcon, color: priorityColor, size: 20),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Posted on ${DateFormat.yMMMd().format(DateTime.parse(notice.publishDate))}',
                                        style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    notice.body,
                                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, fontSize: 16),
                                  ),
                                  if (notice.expiresAt != null) ...[
                                    const SizedBox(height: 16),
                                    Text(
                                      'Expires on ${DateFormat.yMMMd().format(DateTime.parse(notice.expiresAt!))}',
                                      style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: priorityColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(priorityIcon, color: priorityColor, size: 24),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notice.title,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: isExpired ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        DateFormat.yMMMd().format(DateTime.parse(notice.publishDate)),
                                        style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: notice.isFacultyOnly 
                                            ? Colors.purple.withValues(alpha: 0.1) 
                                            : Colors.blue.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          audienceText,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: notice.isFacultyOnly ? Colors.purple : Colors.blue,
                                          ),
                                        ),
                                      ),
                                      if (isExpired) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            'EXPIRED',
                                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              tooltip: 'Delete Notice',
                              icon: const Icon(Icons.delete_outline),
                              color: theme.colorScheme.error,
                              onPressed: () => _repo.deleteNotice(notice.id),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          notice.body,
                          style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                        ),
                        if (notice.expiresAt != null) ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.event_busy, size: 14, color: theme.disabledColor),
                              const SizedBox(width: 4),
                              Text(
                                'Expires: ${DateFormat.yMMMd().format(DateTime.parse(notice.expiresAt!))}',
                                style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
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

    final classes = _classes ?? [];
    final title = TextEditingController();
    final body = TextEditingController();
    var priority = NoticePriority.normal.wire;
    String? audienceId = 'school'; // 'school', 'faculty', or classId
    DateTime? expiresAt;

    if (!mounted) return;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Post new notice'),
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
                const SizedBox(height: 16),
                TextField(
                  controller: body,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: audienceId,
                        decoration: const InputDecoration(
                          labelText: 'Audience',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem(value: 'school', child: Text('Whole school')),
                          const DropdownMenuItem(value: 'faculty', child: Text('Faculty Only')),
                          for (final c in classes)
                            DropdownMenuItem(value: c.id, child: Text('Class ${c.displayName}')),
                        ],
                        onChanged: (v) => setLocal(() => audienceId = v),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: priority,
                        decoration: const InputDecoration(
                          labelText: 'Priority',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          for (final p in NoticePriority.values)
                            DropdownMenuItem(value: p.wire, child: Text(p.wire.toUpperCase())),
                        ],
                        onChanged: (v) => setLocal(() => priority = v ?? priority),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: expiresAt ?? DateTime.now().add(const Duration(days: 7)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (date != null) {
                      setLocal(() => expiresAt = date);
                    }
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expiresAt == null 
                            ? 'No expiry set' 
                            : DateFormat.yMMMd().format(expiresAt!),
                          style: TextStyle(color: expiresAt == null ? Theme.of(context).disabledColor : null),
                        ),
                        if (expiresAt != null)
                          IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => setLocal(() => expiresAt = null),
                          )
                        else
                          const Icon(Icons.calendar_today, size: 18),
                      ],
                    ),
                  ),
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
        classId: (audienceId != 'school' && audienceId != 'faculty') ? audienceId : null,
        isFacultyOnly: audienceId == 'faculty',
        title: title.text.trim(),
        body: body.text.trim(),
        priority: priority,
        expiresAt: expiresAt != null ? encodeDate(expiresAt!) : null,
        createdBy: _actor,
      );
    }
    title.dispose();
    body.dispose();
  }
}
