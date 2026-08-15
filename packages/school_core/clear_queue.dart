import 'package:sqlite3/sqlite3.dart';

void main() {
  print('Opening database...');
  final db = sqlite3.open('C:/Users/PMLS/Documents/sse_school.sqlite');
  
  print('Clearing stuck students sync items...');
  db.execute("DELETE FROM outbox WHERE table_name = 'students'");
  
  print('Done!');
  db.dispose();
}
