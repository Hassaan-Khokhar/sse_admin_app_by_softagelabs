import 'package:school_core/school_core.dart';
import 'package:test/test.dart';

void main() {
  group('gradeForPercentage', () {
    test('hits each band exactly at its boundary', () {
      // The boundaries are where off-by-one errors live: 90 must be A+, and
      // 89.99 must be A. A student on exactly 80 has earned an A, not a B.
      expect(gradeForPercentage(100), 'A+');
      expect(gradeForPercentage(90), 'A+');
      expect(gradeForPercentage(89.99), 'A');
      expect(gradeForPercentage(80), 'A');
      expect(gradeForPercentage(79.99), 'B');
      expect(gradeForPercentage(70), 'B');
      expect(gradeForPercentage(69.99), 'C');
      expect(gradeForPercentage(60), 'C');
      expect(gradeForPercentage(59.99), 'D');
      expect(gradeForPercentage(50), 'D');
      expect(gradeForPercentage(49.99), 'E');
      expect(gradeForPercentage(40), 'E');
      expect(gradeForPercentage(39.99), 'F');
      expect(gradeForPercentage(0), 'F');
    });

    test('handles out-of-range values without returning null', () {
      expect(gradeForPercentage(120), 'A+');
      expect(gradeForPercentage(-5), 'F');
    });

    test('rejects NaN', () {
      expect(() => gradeForPercentage(double.nan), throwsA(isA<ArgumentError>()));
    });
  });

  group('percentageForMarks', () {
    test('computes a percentage', () {
      expect(percentageForMarks(obtained: 45, total: 50), 90);
      expect(percentageForMarks(obtained: 0, total: 100), 0);
      expect(percentageForMarks(obtained: 33, total: 100), 33);
    });

    test('rejects a non-positive total', () {
      // A subject worth zero marks is a data-entry error. Returning 0 here
      // would quietly grade the entire class F.
      expect(() => percentageForMarks(obtained: 10, total: 0),
          throwsA(isA<ArgumentError>()));
      expect(() => percentageForMarks(obtained: 10, total: -50),
          throwsA(isA<ArgumentError>()));
    });
  });

  group('gradeForMarks', () {
    test('grades a normal row', () {
      expect(gradeForMarks(obtained: 72, total: 100), 'B');
      expect(gradeForMarks(obtained: 36, total: 40), 'A+');
    });

    test('an absent student gets F', () {
      expect(gradeForMarks(obtained: 90, total: 100, isAbsent: true), 'F');
    });

    test('an unmarked paper gets F rather than crashing', () {
      expect(gradeForMarks(obtained: null, total: 100), 'F');
    });

    test('total is respected, not assumed to be 100', () {
      // subjects.total_marks defaults to 100 but is configurable per subject.
      expect(gradeForMarks(obtained: 40, total: 50), 'A');
    });
  });
}
