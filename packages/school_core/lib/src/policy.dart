/// Domain limits both apps must enforce identically.
///
/// These are policy, not schema — Postgres cannot express "5 posts per student
/// per week", so if the two apps disagree the rule simply does not exist. They
/// live here so there is exactly one number to change.
library;

// ============================================================================
//  LOST & FOUND MODERATION
// ============================================================================
//  800 teenagers, free text and photos. CLAUDE.md §7 treats moderation as
//  non-optional, and these are minors — see [claimsGoToOffice] below.

/// Reports at which an item auto-hides pending admin review.
///
/// Auto-hide sets `lost_items.moderation` to `hidden`, it does not remove the
/// item. Three students should be able to take something out of the feed
/// immediately; only an admin makes that permanent.
const int autoHideReportCount = 3;

/// Photos per lost/found item.
const int maxPhotosPerItem = 3;

/// Posts one student may create per rolling week.
///
/// Rate limit against spam. Enforced client-side in the student app; the admin
/// moderation queue is the backstop when someone works around it.
const int maxPostsPerStudentPerWeek = 5;

/// Days after which an item auto-expires and its photos are deleted.
///
/// Photos are the only part of this system that will meaningfully cost money —
/// the entire 800-student database is about 30 MB. Expiry is what stops
/// storage growing forever.
const int lostItemExpiryDays = 30;

/// Claims are handled by the office, never student-to-student.
///
/// A named constant so the rule is greppable. The app is a notice board: a
/// student says "that's mine", the office does the handover in person. A
/// student's phone number or contact details are NEVER shown in either app.
const bool claimsGoToOffice = true;

// ============================================================================
//  PHOTO PIPELINE
// ============================================================================
//  CLAUDE.md §10: photos never travel through the sync log. Separate pipeline,
//  file uploaded BEFORE the row is pushed — otherwise peers pull a row whose
//  image 404s.

/// Longest edge, in pixels, before upload.
const int maxPhotoDimension = 1200;

/// Target size of a compressed full-size photo, in bytes (~200 KB).
const int targetPhotoBytes = 200 * 1024;

/// Target size of a generated thumbnail, in bytes (~30 KB).
///
/// List views load thumbnails ONLY. A feed of 50 full-size photos over the
/// school's connection is the difference between a screen that loads and one
/// that does not.
const int targetThumbnailBytes = 30 * 1024;

// ============================================================================
//  FEES
// ============================================================================

/// Currency for all money in the system. Stored as NUMERIC(10,2) / REAL.
const String currencyCode = 'PKR';

/// Symbol for display.
const String currencySymbol = 'Rs';

// ============================================================================
//  ATTENDANCE
// ============================================================================

/// Percentage below which a student is flagged as short of attendance.
///
/// A reporting threshold only — nothing in the system blocks a student over
/// this. Confirm the real figure with the school before the demo; 75% is the
/// common default in Pakistani schools but it is a guess until they say so.
const double attendanceShortageThreshold = 75.0;

// ============================================================================
//  SYNC
// ============================================================================

/// Outbox operations per push request.
///
/// Bulk challan generation creates one row per active student — 800 rows in a
/// single local transaction. Pushing those as one request over a connection
/// that drops every few minutes would never complete, so the outbox drains in
/// batches and each batch is independently idempotent via its `op_id`.
const int syncPushBatchSize = 200;

/// Rows per pull page.
const int syncPullPageSize = 500;

/// Attempts before an outbox entry is surfaced to the user as stuck.
///
/// The entry is never dropped — it stays queued and keeps retrying. This only
/// controls when the UI stops saying "pending" and starts saying "failed", so
/// a permanently broken row cannot sit invisible forever.
const int maxSyncAttemptsBeforeSurfacing = 5;
