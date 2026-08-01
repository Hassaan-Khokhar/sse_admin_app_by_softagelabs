import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import 'data/app_scope.dart';
import 'data/auth_service.dart';
import 'sync/sync_service.dart';
import 'screens/attendance_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/faculty_screen.dart';
import 'screens/login_screen.dart';
import 'widgets/sync_status_bar.dart';

class AdminApp extends StatefulWidget {
  const AdminApp({required this.database, required this.sync, super.key});

  final AppDatabase database;
  final SyncService sync;

  @override
  State<AdminApp> createState() => _AdminAppState();
}

class _AdminAppState extends State<AdminApp> {
  final _auth = AuthService();

  @override
  void initState() {
    super.initState();
    // Not awaited: this waits on Supabase coming up, which may involve the
    // network. The window is already on screen by then.
    _auth.restore();
  }

  @override
  void dispose() {
    _auth.dispose();
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
        home: AnimatedBuilder(
          animation: _auth,
          builder: (context, _) => switch (_auth.state) {
            AuthState.checking => const _Splash(),
            AuthState.signedIn || AuthState.localOnly => AdminShell(auth: _auth),
            _ => LoginScreen(auth: _auth),
          },
        ),
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

/// Sections of the admin app, per CLAUDE.md §9.
enum AdminSection {
  dashboard('Dashboard', Icons.dashboard_outlined),
  classes('Classes', Icons.meeting_room_outlined),
  students('Students', Icons.people_outline),
  faculty('Faculty', Icons.badge_outlined),
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
  const AdminShell({required this.auth, super.key});

  final AuthService auth;

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
                // NavigationRail does not scroll on its own, so nine
                // destinations plus the trailing button overflow a short
                // window. This makes the rail scroll only when it has to:
                // IntrinsicHeight lets it keep its natural size, and the
                // ConstrainedBox stretches it to fill a tall window so the
                // trailing sign-out button still sits at the bottom.
                //
                // Sections will keep being added, so a fixed layout would just
                // break again at the next one.
                LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          selectedIndex: _section.index,
                          onDestinationSelected: (index) => setState(
                              () => _section = AdminSection.values[index]),
                          labelType: NavigationRailLabelType.all,
                          leading: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Icon(Icons.account_balance, size: 28),
                          ),
                          trailing: Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: IconButton(
                                  tooltip: widget.auth.isSignedIn
                                      ? 'Sign out (${widget.auth.user?.email})'
                                      : 'Working offline — sign in',
                                  icon: Icon(
                                    widget.auth.isSignedIn
                                        ? Icons.logout
                                        : Icons.person_off_outlined,
                                  ),
                                  onPressed: widget.auth.signOut,
                                ),
                              ),
                            ),
                          ),
                          destinations: [
                            for (final section in AdminSection.values)
                              NavigationRailDestination(
                                icon: Icon(section.icon),
                                label: Text(section.label),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
        AdminSection.faculty => const FacultyAttendanceView(),
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
