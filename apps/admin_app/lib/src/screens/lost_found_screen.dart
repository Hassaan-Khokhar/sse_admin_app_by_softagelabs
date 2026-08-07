import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';
import 'package:intl/intl.dart';

import '../data/app_scope.dart';
import '../data/school_repository.dart';
import '../widgets/empty_state.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> with SingleTickerProviderStateMixin {
  late final SchoolRepository _repo;
  late String _actor;
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _repo = SchoolRepository(AppScope.databaseOf(context));
    _actor = AppScope.actorOf(context);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<LostItem>>(
      stream: _repo.watchPendingLostItems(),
      builder: (context, pendingSnapshot) {
        final pendingItems = pendingSnapshot.data ?? [];
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () {}, // Can hook up if there's a back navigation needed, but in admin app sidebar this is standard. 
                    // Wait, usually the page shell doesn't have a back button. I will remove the icon button and just use text.
                  ),
                  Text('Lost & Found Manager', style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, spreadRadius: 0)
                  ]
                ),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.deepPurple,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Pending (${pendingItems.length})'),
                    const Tab(text: 'Active Listings'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildList(pendingItems, true),
                  StreamBuilder<List<LostItem>>(
                    stream: _repo.watchActiveLostItems(),
                    builder: (context, activeSnapshot) {
                      return _buildList(activeSnapshot.data ?? [], false);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _buildList(List<LostItem> items, bool isPending) {
    if (items.isEmpty) {
      return EmptyState(
        icon: Icons.inbox_outlined,
        title: isPending ? 'No pending requests' : 'No active listings',
        detail: '',
      );
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, i) => _ItemCard(
        item: items[i],
        isPending: isPending,
        onApprove: isPending 
          ? () => _repo.moderate(item: items[i], state: ModerationState.visible, moderatedBy: _actor)
          : null,
        onDelete: () => _repo.deleteLostItem(items[i].id),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    required this.item,
    required this.isPending,
    this.onApprove,
    required this.onDelete,
  });

  final LostItem item;
  final bool isPending;
  final VoidCallback? onApprove;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLost = item.type == 'lost';

    // Image placeholder block. In a real app we'd load `item.photos`, but here we use an icon or placeholder.
    final hasPhotos = item.photos.length > 5; // JSON string check, '[]' is length 2.
    
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey.withValues(alpha: 0.1),
                    child: hasPhotos 
                      ? const Icon(Icons.image, size: 40, color: Colors.grey)
                      : const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: isLost ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: isLost ? Colors.red.withValues(alpha: 0.3) : Colors.green.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              isLost ? 'LOST' : 'FOUND',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isLost ? Colors.red : Colors.green,
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('d/M/yyyy').format(DateTime.parse(item.createdAt)),
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 14, color: theme.disabledColor),
                          const SizedBox(width: 4),
                          Text(
                            item.location ?? 'Unknown',
                            style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.description ?? '',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          IntrinsicHeight(
            child: Row(
              children: [
                if (isPending) ...[
                  Expanded(
                    child: InkWell(
                      onTap: onApprove,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check, color: Colors.green, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Approve Post',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                ],
                Expanded(
                  child: InkWell(
                    onTap: onDelete,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Delete Post',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
