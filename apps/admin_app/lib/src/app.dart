import 'package:flutter/material.dart';
import 'package:school_core/school_core.dart';

import 'data/app_scope.dart';
import 'data/auth_service.dart';
import 'sync/sync_service.dart';
import 'screens/assignments_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/classes_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/lost_found_screen.dart';
import 'screens/notices_screen.dart';
import 'screens/faculty_management_screen.dart';
import 'screens/fees_screen.dart';
import 'screens/login_screen.dart';
import 'screens/marks_screen.dart';
import 'screens/students_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_sidebar.dart';
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
      auth: _auth,
      child: MaterialApp(
        title: 'SSE School — Admin',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
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
  dashboard('Dashboard', Icons.dashboard_rounded, AppTheme.navDashboard),
  classes('Classes', Icons.meeting_room_rounded, AppTheme.navClasses),
  students('Students', Icons.groups_rounded, AppTheme.navStudents),
  faculty('Faculty', Icons.badge_rounded, AppTheme.navFaculty),
  attendance('Attendance', Icons.fact_check_rounded, AppTheme.navAttendance),
  marks('Marks', Icons.school_rounded, AppTheme.navMarks),
  fees('Fees', Icons.payments_rounded, AppTheme.navFees),
  timetable('Timetable', Icons.calendar_month_rounded, AppTheme.navTimetable),
  notices('Notices', Icons.campaign_rounded, AppTheme.navNotices),
  lostFound('Lost & Found', Icons.travel_explore_rounded, AppTheme.navLostFound);

  const AdminSection(this.label, this.icon, this.color);

  final String label;
  final IconData icon;

  /// Landmark colour for the rail. See AppTheme's note on why this set is
  /// wider than the validated metric palette.
  final Color color;
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
                AppSidebar(
                  items: [
                    for (final section in AdminSection.values)
                      (
                        label: section.label,
                        icon: section.icon,
                        color: section.color,
                      ),
                  ],
                  selectedIndex: _section.index,
                  onSelected: (index) =>
                      setState(() => _section = AdminSection.values[index]),
                  footer: IconButton(
                    tooltip: widget.auth.isSignedIn
                        ? 'Sign out (${widget.auth.user?.email})'
                        : 'Working offline — sign in',
                    icon: Icon(
                      widget.auth.isSignedIn
                          ? Icons.logout_rounded
                          : Icons.person_off_rounded,
                      size: 19,
                      color: AppTheme.inkMuted,
                    ),
                    onPressed: widget.auth.signOut,
                  ),
                ),
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
        AdminSection.students => const StudentsScreen(),
        AdminSection.faculty => const FacultyManagementScreen(),
        AdminSection.fees => const FeesScreen(),
        AdminSection.marks => const MarksScreen(),
        AdminSection.classes => const ClassesScreen(),
        AdminSection.timetable => const TimetableScreen(),
        AdminSection.notices => const NoticesScreen(),
        AdminSection.lostFound => const LostFoundScreen(),
      };
}

// Every section now has a real screen — the "Not built yet" placeholder that
// lived here is gone, and the switch above is exhaustive over AdminSection so
// the analyzer will flag any future section that forgets one.
