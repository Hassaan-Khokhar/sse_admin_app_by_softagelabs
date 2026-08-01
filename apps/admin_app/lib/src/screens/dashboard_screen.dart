import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';

/// Principal's landing screen.
///
/// Every number here is a live Drift stream off the local database, not a
/// one-shot read — so when sync pulls new rows in, the tiles move without
/// anyone refreshing anything.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dashboard', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            'Reading from local SQLite — no network involved.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _CountTile(
                label: 'Students',
                icon: Icons.people_outline,
                stream: _watchLiveCount(db, db.students),
              ),
              _CountTile(
                label: 'Classes',
                icon: Icons.meeting_room_outlined,
                stream: _watchLiveCount(db, db.classes),
              ),
              _CountTile(
                label: 'Subjects',
                icon: Icons.menu_book_outlined,
                stream: _watchLiveCount(db, db.subjects),
              ),
              _CountTile(
                label: 'Attendance rows',
                icon: Icons.fact_check_outlined,
                stream: _watchLiveCount(db, db.attendance),
              ),
              _CountTile(
                label: 'Unpaid challans',
                icon: Icons.receipt_long_outlined,
                stream: _watchLiveCount(db, db.feeChallans),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const _OutboxProbe(),
        ],
      ),
    );
  }
}

/// Live count of non-tombstoned rows in [table].
///
/// `deleted_at IS NULL` is not optional: schema.sql convention 3 forbids hard
/// deletes, so without the filter every withdrawn student and removed notice
/// would keep counting forever.
Stream<int> _watchLiveCount(
  AppDatabase db,
  drift.ResultSetImplementation<drift.HasResultSet, dynamic> table,
) {
  final counter = drift.countAll();
  final query = db.selectOnly(table)
    ..addColumns([counter])
    ..where(table.columnsByName['deleted_at']!.isNull());
  return query.map((row) => row.read(counter) ?? 0).watchSingle();
}

class _CountTile extends StatelessWidget {
  const _CountTile({
    required this.label,
    required this.icon,
    required this.stream,
  });

  final String label;
  final IconData icon;
  final Stream<int> stream;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Container(
        width: 190,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(height: 12),
            StreamBuilder<int>(
              stream: stream,
              builder: (context, snapshot) => Text(
                snapshot.hasData ? '${snapshot.data}' : '—',
                style: theme.textTheme.headlineMedium,
              ),
            ),
            Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

/// DEV TOOL — queues and clears outbox rows so the sync status bar can be
/// exercised before the real sync transport exists.
///
/// Remove this before filming. It writes to the real outbox table, which is
/// harmless while nothing drains it, but it is not a feature.
class _OutboxProbe extends StatelessWidget {
  const _OutboxProbe();

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.science_outlined, size: 18),
                const SizedBox(width: 8),
                Text('Dev tool — exercise the sync bar',
                    style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Real sync is not built yet. These buttons queue and clear '
              'outbox rows so the status bar can be verified. Delete before '
              'filming.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                FilledButton.tonal(
                  onPressed: () => _queue(db, 1),
                  child: const Text('Queue 1'),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  // 40 is the number from the demo script: a class of 40
                  // students marked with the wifi off (CLAUDE.md §12, 0:30).
                  onPressed: () => _queue(db, 40),
                  child: const Text('Queue 40'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => db.delete(db.outbox).go(),
                  child: const Text('Clear outbox'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _queue(AppDatabase db, int count) async {
    // One transaction, as every real local write will be: the row and its
    // outbox entry must land together or not at all (CLAUDE.md §10).
    await db.transaction(() async {
      for (var i = 0; i < count; i++) {
        await db.into(db.outbox).insert(
              OutboxCompanion.insert(
                opId: newOpId(),
                tableNameRef: 'attendance',
                rowId: newId(),
                op: SyncOp.upsert.wire,
                payload: '{"probe":true}',
                createdAt: nowTimestamp(),
              ),
            );
      }
    });
  }
}
