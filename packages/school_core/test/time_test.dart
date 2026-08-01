import 'package:school_core/school_core.dart';
import 'package:test/test.dart';

void main() {
  group('encodeTimestamp', () {
    test('always ends in Z', () {
      // Postgres will parse a string without the Z in the server's timezone
      // and hand back a value hours off.
      final local = DateTime(2026, 8, 2, 9, 30);
      expect(encodeTimestamp(local), endsWith('Z'));
      expect(encodeTimestamp(DateTime.utc(2026, 8, 2, 4, 30)),
          '2026-08-02T04:30:00.000Z');
    });

    test('converts local time to UTC before encoding', () {
      final utc = DateTime.utc(2026, 8, 2, 4, 30);
      expect(encodeTimestamp(utc.toLocal()), encodeTimestamp(utc));
    });

    test('round-trips', () {
      final original = DateTime.utc(2026, 8, 2, 4, 30, 15, 250);
      expect(decodeTimestamp(encodeTimestamp(original)), original);
    });
  });

  group('encodeDate', () {
    test('formats as YYYY-MM-DD with zero padding', () {
      expect(encodeDate(DateTime(2026, 8, 2)), '2026-08-02');
      expect(encodeDate(DateTime(2026, 12, 31)), '2026-12-31');
      expect(encodeDate(DateTime(2026, 1, 1)), '2026-01-01');
    });

    test('uses LOCAL date components, never UTC', () {
      // Pakistan is UTC+05:00. Attendance marked at 08:00 local on 2 August is
      // 03:00Z on 2 August — same day either way here, but the test below is
      // the one that matters.
      final earlyMorning = DateTime(2026, 8, 2, 2, 0);
      expect(encodeDate(earlyMorning), '2026-08-02');

      // If this went through UTC it would file as 2026-08-01, and
      // UNIQUE(student_id, date) would then let the same morning be marked
      // twice — once under each date.
      final beforeDawn = DateTime(2026, 8, 2, 4, 59);
      expect(encodeDate(beforeDawn), '2026-08-02');
    });

    test('discards time of day', () {
      expect(encodeDate(DateTime(2026, 8, 2, 23, 59, 59)), '2026-08-02');
    });

    test('round-trips', () {
      expect(decodeDate('2026-08-02'), DateTime(2026, 8, 2));
    });

    test('rejects a malformed date', () {
      expect(() => decodeDate('02-08-2026'), throwsA(isA<FormatException>()));
      expect(() => decodeDate('2026/08/02'), throwsA(isA<FormatException>()));
    });
  });

  group('dateOnly', () {
    test('strips the time', () {
      expect(dateOnly(DateTime(2026, 8, 2, 14, 35, 12)), DateTime(2026, 8, 2));
    });
  });
}
