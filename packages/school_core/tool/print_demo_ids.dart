// Prints the deterministic ids the demo seeder produces.
//
// These are stable across every machine and every run (UUIDv5 over a fixed
// namespace), which is what lets the desktop and the phone seed the same
// school. Run with:
//
//   dart run tool/print_demo_ids.dart
//
// Use the output when bootstrapping the principal account in Supabase — the
// app_users row has to carry the same school_id the seeder uses locally, or
// the principal ends up in a different school to their own students.
import 'package:school_core/school_core.dart';

void main() {
  print('school_id          : ${DemoSeeder.schoolId}');
  print('academic_year_id   : ${DemoSeeder.academicYearId}');
  print('principal_user_id  : ${DemoSeeder.principalUserId}');
  print('');
  for (final spec in const [(9, 'A'), (9, 'B'), (10, 'A')]) {
    final id = DemoSeeder.demoId('class/${spec.$1}-${spec.$2}');
    print('class ${spec.$1}-${spec.$2}         : $id');
  }
}
