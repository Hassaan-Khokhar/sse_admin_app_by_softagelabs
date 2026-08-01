import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import 'data/app_scope.dart';
import 'sync/sync_service.dart';
import 'screens/attendance_screen.dart';
import 'screens/dashboard_screen.dart';
import 'widgets/sync_status_bar.dart';

class AdminApp extends StatefulWidget {
  const AdminApp({required this.database, required this.sync, super.key});

  final AppDatabase database;
  final SyncService sync;

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  @override
  void dispose() {
    widget.sync.dispose();
    widget.database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      database: widget.database,
      sync: widget.sync,
      child: MaterialApp(
        title: 'SSE School — Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF1E40AF),
          useMaterial3: true,
        ),
        home: const AdminShell(),
      ),
    );
  }
}

/// Sections of the admin app, per CLAUDE.md §9.
enum AdminSection {
  dashboard('Dashboard', Icons.dashboard_outlined),
  classes('Classes', Icons.meeting_room_outlined),
  students('Students', Icons.people_outline),
  attendance('Attendance', Icons.fact_check_outlined),
  marks('Marks', Icons.school_outlined),
  fees('Fees', Icons.receipt_long_outlined),
  notices('Notices', Icons.campaign_outlined),
  lostFound('Lost & Found', Icons.search_outlined);

  const AdminSection(this.label, this.icon);

  final String label;
  final IconData icon;
}

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  AdminSection _section = AdminSection.dashboard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: _section.index,
                  onDestinationSelected: (index) =>
                      setState(() => _section = AdminSection.values[index]),
                  labelType: NavigationRailLabelType.all,
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Icon(Icons.account_balance, size: 28),
                  ),
                  destinations: [
                    for (final section in AdminSection.values)
                      NavigationRailDestination(
                        icon: Icon(section.icon),
                        label: Text(section.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: _buildSection()),
              ],
            ),
          ),
          // Pinned to the bottom, visible on every screen. It has to be on
          // camera continuously through the wifi-off / wifi-on sequence
          // (CLAUDE.md §12), so it cannot live inside any one page.
          const SyncStatusBar(),
        ],
      ),
    );
  }

  Widget _buildSection() => switch (_section) {
        AdminSection.dashboard => const DashboardScreen(),
        AdminSection.attendance => const AttendanceScreen(),
        _ => _NotBuiltYet(section: _section),
      };
}

/// Honest placeholder. Says what belongs here rather than pretending to work.
class _NotBuiltYet extends StatelessWidget {
  const _NotBuiltYet({required this.section});

  final AdminSection section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(section.icon, size: 48, color: theme.disabledColor),
          const SizedBox(height: 12),
          Text(section.label, style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text('Not built yet', style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
