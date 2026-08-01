import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../sync/backfill.dart';

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

/// DEV TOOLS — seeding and sync-bar probes.
///
/// Remove the outbox probes before filming. The seeder stays: CLAUDE.md §12
/// requires realistic data on screen, and it is how the demo database gets
/// built in the first place.
class _OutboxProbe extends StatefulWidget {
  const _OutboxProbe();

  @override
  State<_OutboxProbe> createState() => _OutboxProbeState();
}

class _OutboxProbeState extends State<_OutboxProbe> {
  bool _busy = false;
  String? _message;

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
                Text('Dev tools', style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Seed builds ~50 students across 9-A, 9-B and 10-A with two '
              'months of back-dated attendance, locally. "Queue all for push" '
              'then uploads that whole school to Supabase once — after which '
              'ordinary edits queue themselves.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: _busy ? null : () => _seed(db),
                  icon: _busy
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_awesome, size: 18),
                  label: const Text('Seed demo data'),
                ),
                FilledButton.tonal(
                  onPressed: _busy ? null : () => _backfill(db),
                  child: const Text('Queue all for push'),
                ),
                OutlinedButton(
                  onPressed: _busy ? null : () => db.delete(db.outbox).go(),
                  child: const Text('Clear outbox'),
                ),
                OutlinedButton(
                  onPressed: _busy ? null : () => _wipe(db),
                  child: const Text('Wipe local data'),
                ),
              ],
            ),
            if (_message case final message?) ...[
              const SizedBox(height: 10),
              Text(message, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _seed(AppDatabase db) async {
    setState(() {
      _busy = true;
      _message = 'Seeding…';
    });
    final watch = Stopwatch()..start();
    try {
      await DemoSeeder(db).seed();
      if (mounted) {
        setState(() => _message = 'Seeded in ${watch.elapsedMilliseconds} ms');
      }
    } on Object catch (error) {
      if (mounted) setState(() => _message = 'Seed failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// One-time upload of the whole seeded school.
  ///
  /// Needed because the seeder writes straight to SQLite for speed, leaving
  /// the server empty. Real edits queue themselves as they are made.
  Future<void> _backfill(AppDatabase db) async {
    setState(() {
      _busy = true;
      _message = 'Queueing…';
    });
    try {
      final count = await SyncBackfill(db).enqueueEverything();
      if (mounted) {
        setState(() => _message = '$count rows queued — press the sync bar');
      }
    } on Object catch (error) {
      if (mounted) setState(() => _message = 'Queue failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Clears local data so seeding can be demonstrated from scratch.
  ///
  /// Local only — this is a dev tool, not the withdraw flow. Real removals are
  /// tombstones (schema.sql convention 3), never deletes.
  Future<void> _wipe(AppDatabase db) async {
    setState(() => _busy = true);
    await db.transaction(() async {
      await db.delete(db.attendance).go();
      await db.delete(db.students).go();
      await db.delete(db.subjects).go();
      await db.delete(db.classes).go();
      await db.delete(db.academicYears).go();
      await db.delete(db.appUsers).go();
      await db.delete(db.schools).go();
      await db.delete(db.outbox).go();
    });
    if (mounted) {
      setState(() {
        _busy = false;
        _message = 'Local data wiped';
      });
    }
  }
}
