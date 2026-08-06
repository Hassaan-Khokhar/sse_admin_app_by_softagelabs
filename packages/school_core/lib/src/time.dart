/// Time encoding for the wire and for SQLite.
///
/// schema.sql convention 5 maps TIMESTAMPTZ to TEXT as ISO-8601 UTC *always
/// with a trailing Z*, and DATE to TEXT as `YYYY-MM-DD`. Postgres will happily
/// parse a string without the Z, interpret it in the server's timezone, and
/// hand you back a value hours off. So encoding goes through here, nowhere
/// else.
library;

/// Encodes a timestamp for a TIMESTAMPTZ column.
///
/// Always converts to UTC first, so the trailing `Z` is truthful.
String encodeTimestamp(DateTime value) => value.toUtc().toIso8601String();

/// Decodes a TIMESTAMPTZ column into a UTC [DateTime].
DateTime decodeTimestamp(String value) => DateTime.parse(value).toUtc();

/// Encodes a calendar date for a DATE column as `YYYY-MM-DD`.
///
/// Deliberately uses the LOCAL date components, not UTC. An attendance row is
/// keyed to the school day the teacher is standing in. Pakistan is UTC+05:00,
/// so converting to UTC first would file everything marked before 05:00 local
/// under the previous day — and `UNIQUE(student_id, date)` would then let the
/// same morning be marked twice.
String encodeDate(DateTime value) {
  final y = value.year.toString().padLeft(4, '0');
  final m = value.month.toString().padLeft(2, '0');
  final d = value.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

final _datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

/// Decodes a `YYYY-MM-DD` DATE column into a local midnight [DateTime].
///
/// Strict on purpose. [DateTime] silently NORMALISES out-of-range components —
/// `DateTime(2, 8, 2026)` becomes year 8, and `DateTime(2026, 2, 30)` becomes
/// 2 March. So a malformed date would not throw, it would quietly become a
/// different, entirely plausible date. On a row arriving from a peer that
/// means a corrupted attendance record rather than a visible error, which is
/// far worse.
///
/// Both the shape and the round-trip are therefore checked.
DateTime decodeDate(String value) {
  if (!_datePattern.hasMatch(value)) {
    throw FormatException('Expected YYYY-MM-DD', value);
  }

  final year = int.parse(value.substring(0, 4));
  final month = int.parse(value.substring(5, 7));
  final day = int.parse(value.substring(8, 10));
  final result = DateTime(year, month, day);

  // Catches month 13, day 32, and 30 February — all of which DateTime would
  // otherwise roll forward without complaint.
  if (result.year != year || result.month != month || result.day != day) {
    throw FormatException('Not a real calendar date', value);
  }
  return result;
}

/// The calendar date [value] falls on, with any time-of-day discarded.
DateTime dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

/// Current wall-clock time as a TIMESTAMPTZ string.
///
/// Note this is the *device* clock, which on a school PC is routinely wrong.
/// That is fine for `updated_at`, which is only ever displayed. It is NOT fine
/// as a sync cursor — the cursor is `server_seq`, a monotonic BIGINT the
/// server stamps. See CLAUDE.md §10.
String nowTimestamp() => encodeTimestamp(DateTime.now());
