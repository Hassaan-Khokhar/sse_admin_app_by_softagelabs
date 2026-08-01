/// The grade scale, shared by both apps.
///
/// CLAUDE.md §9 is explicit that this must live in school_core and that both
/// apps must use the same function. If the admin app and the student app ever
/// compute a grade differently, the student sees one letter on their phone and
/// the principal sees another on the report card — a bug nobody notices until
/// a parent is standing in the office.
///
/// Percentages and grades, not GPA/CGPA: those were removed with the rest of
/// the university model (CLAUDE.md §11).
library;

/// A band in the grade scale: [grade] applies at or above [minPercentage].
typedef GradeBand = ({num minPercentage, String grade});

/// The scale, highest band first.
///
/// `>=90 A+ · >=80 A · >=70 B · >=60 C · >=50 D · >=40 E · else F`
const List<GradeBand> gradeScale = [
  (minPercentage: 90, grade: 'A+'),
  (minPercentage: 80, grade: 'A'),
  (minPercentage: 70, grade: 'B'),
  (minPercentage: 60, grade: 'C'),
  (minPercentage: 50, grade: 'D'),
  (minPercentage: 40, grade: 'E'),
];

/// The grade below every band in [gradeScale].
const String failingGrade = 'F';

/// The letter grade for a percentage in the range 0..100.
///
/// Anything below the lowest band — including negatives, which should never
/// occur but must not produce a null — is [failingGrade].
String gradeForPercentage(num percentage) {
  if (percentage.isNaN) {
    throw ArgumentError.value(percentage, 'percentage', 'must be a number');
  }
  for (final band in gradeScale) {
    if (percentage >= band.minPercentage) return band.grade;
  }
  return failingGrade;
}

/// [obtained] as a percentage of [total].
///
/// Throws if [total] is not positive: a subject worth zero marks is a data
/// entry error, and silently returning 0 would quietly grade the whole class F.
double percentageForMarks({required num obtained, required num total}) {
  if (total <= 0) {
    throw ArgumentError.value(total, 'total', 'must be greater than zero');
  }
  return obtained / total * 100;
}

/// The letter grade for a `marks` row.
///
/// A student marked absent scores [failingGrade], as does a row whose
/// [obtained] is still null (marks not yet entered) when [isAbsent] is set.
///
/// ASSUMPTION worth confirming with the school before the demo: that an absent
/// student is graded F rather than shown a dash. It is a one-line change here
/// and nowhere else, which is the point of keeping this function in one place.
String gradeForMarks({
  required num? obtained,
  required num total,
  bool isAbsent = false,
}) {
  if (isAbsent || obtained == null) return failingGrade;
  return gradeForPercentage(percentageForMarks(obtained: obtained, total: total));
}
