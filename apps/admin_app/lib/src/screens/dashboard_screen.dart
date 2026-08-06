import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import '../data/app_scope.dart';
import '../sync/backfill.dart';
import '../theme/app_theme.dart';
import '../widgets/attendance_trend.dart';

/// The principal's landing screen.
///
/// Every figure is a live Drift stream off local SQLite, so the page moves on
/// its own as sync brings rows in — nothing here needs refreshing.
///
/// Ordered by what a principal actually asks at 8am: is the school here today,
/// then how has the month gone, then how much money is outstanding. The dev
/// tools sit at the bottom because they are scaffolding, not the product.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
      children: [
        const _Greeting(),
        const SizedBox(height: 24),
        _MetricRow(db: db),
        const SizedBox(height: 24),
        const _TodayAndTrend(),
        const SizedBox(height: 24),
        const _DevTools(),
      ],
    );
  }
}

class _Greeting extends StatelessWidget {
  const _Greeting();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hour = now.hour;
    final greeting = hour < 12
        ? 'Good morning'
        : hour < 17
            ? 'Good afternoon'
            : 'Good evening';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greeting,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 2),
              Text(
                _longDate(now),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppTheme.surfaceMuted,
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            border: Border.all(color: AppTheme.hairline),
          ),
          child: Row(
            children: [
              const Icon(Icons.storage_outlined,
                  size: 14, color: AppTheme.inkMuted),
              const SizedBox(width: 6),
              Text('Local database',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  static String _longDate(DateTime d) {
    const days = [
      'Monday', 'Tuesday', 'Wednesday', 'Thursday',
      'Friday', 'Saturday', 'Sunday',
    ];
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December',
    ];
    return '${days[d.weekday - 1]}, ${d.day} ${months[d.month - 1]} ${d.year}';
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.db});

  final AppDatabase db;

  /// Fixed, not stretched to fill the row.
  ///
  /// Dividing the available width between five cards makes each one enormous
  /// on a wide monitor — a two-digit number floating in 450px of white, which
  /// reads as unfinished rather than spacious. A tile sized to its content
  /// stays legible at any window width and simply wraps.
  static const _cardWidth = 208.0;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _Metric(
              width: _cardWidth,
              label: 'Students',
              icon: Icons.groups_rounded,
              accent: AppTheme.accentBlue,
              stream: _liveCount(db, db.students),
            ),
            _Metric(
              width: _cardWidth,
              label: 'Classes',
              icon: Icons.meeting_room_rounded,
              accent: AppTheme.accentAmber,
              stream: _liveCount(db, db.classes),
            ),
            _Metric(
              width: _cardWidth,
              label: 'Faculty',
              icon: Icons.badge_rounded,
              accent: AppTheme.accentGreen,
              stream: _liveCount(db, db.teachers),
            ),
            _Metric(
              width: _cardWidth,
              label: 'Subjects',
              icon: Icons.menu_book_rounded,
              accent: AppTheme.accentPink,
              stream: _liveCount(db, db.subjects),
            ),
            _Metric(
              width: _cardWidth,
              label: 'Unpaid challans',
              icon: Icons.payments_rounded,
              accent: AppTheme.accentOrange,
              stream: _unpaidChallans(db),
            ),
          ],
        ),
    );
  }
}

/// Live count of rows that are not tombstoned.
///
/// `deleted_at IS NULL` is not optional — schema.sql convention 3 forbids hard
/// deletes, so without it every withdrawn student counts forever.
Stream<int> _liveCount(
  AppDatabase db,
  drift.ResultSetImplementation<drift.HasResultSet, dynamic> table,
) {
  final counter = drift.countAll();
  final query = db.selectOnly(table)
    ..addColumns([counter])
    ..where(table.columnsByName['deleted_at']!.isNull());
  return query.map((row) => row.read(counter) ?? 0).watchSingle();
}

Stream<int> _unpaidChallans(AppDatabase db) {
  final counter = drift.countAll();
  final query = db.selectOnly(db.feeChallans)
    ..addColumns([counter])
    ..where(db.feeChallans.deletedAt.isNull() &
        db.feeChallans.status.isIn([
          ChallanStatus.unpaid.wire,
          ChallanStatus.partial.wire,
        ]));
  return query.map((row) => row.read(counter) ?? 0).watchSingle();
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.width,
    required this.label,
    required this.icon,
    required this.accent,
    required this.stream,
  });

  final double width;
  final String label;
  final IconData icon;
  final Color accent;
  final Stream<int> stream;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The icon chip carries the colour; the number stays ink. Text
              // in a series colour is the classic mistake — it hurts contrast
              // and makes the value harder to read, for no gain.
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Icon(icon, size: 18, color: accent),
              ),
              const SizedBox(height: 14),
              StreamBuilder<int>(
                stream: stream,
                builder: (context, snapshot) => Text(
                  snapshot.hasData ? '${snapshot.data}' : '—',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.ink,
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Text(label, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodayAndTrend extends StatelessWidget {
  const _TodayAndTrend();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 980;
        const trend = AttendanceTrendCard();
        const today = TodaySnapshotCard();

        if (narrow) {
          return const Column(
            children: [trend, SizedBox(height: 16), today],
          );
        }
        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: trend),
            SizedBox(width: 16),
            Expanded(flex: 2, child: today),
          ],
        );
      },
    );
  }
}

/// Seeding and sync scaffolding.
///
/// Deliberately the plainest thing on the page — it is not a feature, and it
/// comes out before filming.
class _DevTools extends StatefulWidget {
  const _DevTools();

  @override
  State<_DevTools> createState() => _DevToolsState();
}

class _DevToolsState extends State<_DevTools> {
  bool _busy = false;
  bool _expanded = false;
  String? _message;

  @override
  Widget build(BuildContext context) {
    final db = AppScope.databaseOf(context);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 6, 18, 6),
        child: Theme(
          data: theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: _expanded,
            onExpansionChanged: (v) => setState(() => _expanded = v),
            tilePadding: EdgeInsets.zero,
            childrenPadding: const EdgeInsets.only(bottom: 16),
            leading: const Icon(Icons.science_outlined,
                size: 18, color: AppTheme.inkMuted),
            title: Text('Developer tools', style: theme.textTheme.titleSmall),
            subtitle: Text(
              'Seed data, upload to the server, reset this PC',
              style: theme.textTheme.bodySmall,
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: _busy ? null : () => _seed(db),
                      icon: _busy
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child:
                                  CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.auto_awesome, size: 16),
                      label: const Text('Seed demo data'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _busy ? null : () => _backfill(db),
                      icon: const Icon(Icons.cloud_upload_outlined, size: 16),
                      label: const Text('Queue all for push'),
                    ),
                    OutlinedButton(
                      onPressed:
                          _busy ? null : () => db.delete(db.outbox).go(),
                      child: const Text('Clear outbox'),
                    ),
                    OutlinedButton(
                      onPressed: _busy ? null : () => _wipe(db),
                      child: const Text('Wipe local data'),
                    ),
                  ],
                ),
              ),
              if (_message case final message?) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(message, style: theme.textTheme.bodySmall),
                ),
              ],
            ],
          ),
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
  /// The seeder writes straight to SQLite for speed, which leaves the server
  /// empty. Ordinary edits queue themselves as they are made.
  Future<void> _backfill(AppDatabase db) async {
    setState(() {
      _busy = true;
      _message = 'Queueing…';
    });
    try {
      final count = await SyncBackfill(db).enqueueEverything();
      if (mounted) {
        setState(() => _message = '$count rows queued — sync runs shortly');
      }
    } on Object catch (error) {
      if (mounted) setState(() => _message = 'Queue failed: $error');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// Clears this PC's database so seeding can be shown from scratch.
  ///
  /// Every syncable table is listed. Missing one leaves orphans that reappear
  /// on the next backfill and quietly repopulate a server you thought clear.
  Future<void> _wipe(AppDatabase db) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Wipe all local data?'),
        content: const Text(
          'Deletes everything in this PC\'s local database, including anything '
          'queued but not yet synced. The server is not touched.\n\n'
          'Demo data can be rebuilt with "Seed demo data".',
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Wipe')),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;

    setState(() => _busy = true);
    await db.transaction(() async {
      // Children first, mirroring SyncEngine.pushOrder reversed.
      await db.delete(db.itemClaims).go();
      await db.delete(db.lostItems).go();
      await db.delete(db.notices).go();
      await db.delete(db.assignments).go();
      await db.delete(db.timetableSlots).go();
      await db.delete(db.feeChallans).go();
      await db.delete(db.feeStructures).go();
      await db.delete(db.marks).go();
      await db.delete(db.exams).go();
      await db.delete(db.teacherAttendance).go();
      await db.delete(db.attendance).go();
      await db.delete(db.students).go();
      await db.delete(db.teacherClassAssignments).go();
      await db.delete(db.teachers).go();
      await db.delete(db.appUsers).go();
      await db.delete(db.subjects).go();
      await db.delete(db.classes).go();
      await db.delete(db.academicYears).go();
      await db.delete(db.schools).go();

      // The cursor has to go too — leaving it set means the next pull asks for
      // "changes since X" and skips everything older, so a wiped device never
      // refills from the server.
      await db.delete(db.outbox).go();
      await db.delete(db.attachmentOutbox).go();
      await db.delete(db.syncState).go();
    });
    if (mounted) {
      setState(() {
        _busy = false;
        _message = 'Local data wiped';
      });
    }
  }
}
