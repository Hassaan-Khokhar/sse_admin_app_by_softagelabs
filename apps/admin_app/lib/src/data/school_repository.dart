import 'package:drift/drift.dart';
import 'package:school_core/school_core.dart';

/// Classes, subjects, notices and lost & found moderation.
///
/// These four are grouped because each is a thin CRUD surface over one table —
/// splitting them into four repositories would be four files of ceremony
/// around a dozen queries.
class SchoolRepository {
  SchoolRepository(this._db) : _writer = OutboxWriter(_db);

  final AppDatabase _db;
  final OutboxWriter _writer;

  Future<School?> school() => _db.select(_db.schools).getSingleOrNull();

  Future<AcademicYear?> currentYear() => (_db.select(_db.academicYears)
        ..where((y) => y.isCurrent.equals(true)))
      .getSingleOrNull();

  // ── classes ───────────────────────────────────────────────────────────────

  Stream<List<SchoolClass>> watchClasses() {
    final query = _db.select(_db.classes)
      ..where((c) => c.deletedAt.isNull())
      ..orderBy([
        (c) => OrderingTerm.asc(c.grade),
        (c) => OrderingTerm.asc(c.section),
      ]);
    return query.watch();
  }

  /// Live student count per class, for the class list.
  Stream<Map<String, int>> watchClassSizes() {
    final query = _db.select(_db.students)
      ..where((s) =>
          s.deletedAt.isNull() & s.status.equals(StudentStatus.active.wire));
    return query.watch().map((rows) {
      final counts = <String, int>{};
      for (final row in rows) {
        if (row.classId case final id?) {
          counts[id] = (counts[id] ?? 0) + 1;
        }
      }
      return counts;
    });
  }

  Future<void> saveClass({
    required String schoolId,
    required String academicYearId,
    String? id,
    required int grade,
    required String section,
    String? room,
    String? classTeacherId,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.classes,
      rowId: rowId,
      row: ClassesCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        academicYearId: academicYearId,
        grade: grade,
        section: section,
        // Denormalised so list screens do not join just to render a label.
        displayName: '$grade-$section',
        classTeacherId: Value(classTeacherId),
        room: Value(room),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  Future<void> deleteClass(String id) =>
      _writer.tombstone(table: _db.classes, rowId: id);

  // ── subjects ──────────────────────────────────────────────────────────────

  Stream<List<Subject>> watchSubjects(String classId) {
    final query = _db.select(_db.subjects)
      ..where((s) => s.classId.equals(classId) & s.deletedAt.isNull())
      ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]);
    return query.watch();
  }

  Future<void> saveSubject({
    required String schoolId,
    required String classId,
    String? id,
    required String name,
    String? code,
    String? teacherId,
    int totalMarks = 100,
    int sortOrder = 0,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.subjects,
      rowId: rowId,
      row: SubjectsCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        classId: classId,
        name: name,
        code: Value(code),
        teacherId: Value(teacherId),
        totalMarks: Value(totalMarks),
        sortOrder: Value(sortOrder),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  Future<void> deleteSubject(String id) =>
      _writer.tombstone(table: _db.subjects, rowId: id);

  // ── timetable ─────────────────────────────────────────────────────────────
  //  The timetable belongs to the CLASS, not the student — 40 students share
  //  one, which is 40× less data than the university per-student model
  //  (CLAUDE.md §11).

  Stream<List<TimetableSlot>> watchTimetable(String classId) {
    final query = _db.select(_db.timetableSlots)
      ..where((t) => t.classId.equals(classId) & t.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm.asc(t.dayOfWeek),
        (t) => OrderingTerm.asc(t.periodNo),
      ]);
    return query.watch();
  }

  Stream<List<Teacher>> watchTeachers() {
    final query = _db.select(_db.teachers)
      ..where((t) => t.deletedAt.isNull() & t.isActive.equals(true))
      ..orderBy([(t) => OrderingTerm.asc(t.fullName)]);
    return query.watch();
  }

  Future<void> saveSlot({
    required String schoolId,
    required String classId,
    String? id,
    String? subjectId,
    String? teacherId,
    required int dayOfWeek,
    required int periodNo,
    required String startTime,
    required String endTime,
    String slotType = 'class',
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.timetableSlots,
      rowId: rowId,
      // UNIQUE(class_id, day_of_week, period_no) — editing period 3 on Monday
      // replaces it rather than stacking a second lesson in the same slot.
      conflictTarget: [
        _db.timetableSlots.classId,
        _db.timetableSlots.dayOfWeek,
        _db.timetableSlots.periodNo,
      ],
      row: TimetableSlotsCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        classId: classId,
        subjectId: Value(subjectId),
        teacherId: Value(teacherId),
        dayOfWeek: dayOfWeek,
        periodNo: periodNo,
        startTime: startTime,
        endTime: endTime,
        slotType: Value(slotType),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  Future<void> deleteSlot(String id) =>
      _writer.tombstone(table: _db.timetableSlots, rowId: id);

  // ── assignments ───────────────────────────────────────────────────────────
  //  View only on the student side — students do not submit through the app
  //  in v1 (CLAUDE.md §9).

  Stream<List<Assignment>> watchAssignments({String? classId}) {
    final query = _db.select(_db.assignments)
      ..where((a) {
        var predicate = a.deletedAt.isNull();
        if (classId != null) predicate = predicate & a.classId.equals(classId);
        return predicate;
      })
      ..orderBy([(a) => OrderingTerm.desc(a.assignedDate)]);
    return query.watch();
  }

  Future<void> saveAssignment({
    required String schoolId,
    required String classId,
    String? id,
    String? subjectId,
    required String title,
    String? description,
    String? dueDate,
    required String createdBy,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.assignments,
      rowId: rowId,
      row: AssignmentsCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        classId: classId,
        subjectId: Value(subjectId),
        title: title,
        description: Value(description),
        assignedDate: encodeDate(DateTime.now()),
        dueDate: Value(dueDate),
        createdBy: Value(createdBy),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  Future<void> deleteAssignment(String id) =>
      _writer.tombstone(table: _db.assignments, rowId: id);

  // ── notices ───────────────────────────────────────────────────────────────

  Stream<List<Notice>> watchNotices() {
    final query = _db.select(_db.notices)
      ..where((n) => n.deletedAt.isNull())
      ..orderBy([(n) => OrderingTerm.desc(n.publishDate)]);
    return query.watch();
  }

  Future<void> saveNotice({
    required String schoolId,
    String? id,
    String? classId,
    required String title,
    required String body,
    String priority = 'normal',
    String? expiresAt,
    required String createdBy,
  }) async {
    final rowId = id ?? newId();
    await _writer.upsert(
      table: _db.notices,
      rowId: rowId,
      row: NoticesCompanion.insert(
        id: rowId,
        schoolId: schoolId,
        classId: Value(classId),
        title: title,
        body: body,
        priority: Value(priority),
        publishDate: encodeDate(DateTime.now()),
        expiresAt: Value(expiresAt),
        createdBy: Value(createdBy),
        updatedAt: nowTimestamp(),
      ),
    );
  }

  Future<void> deleteNotice(String id) =>
      _writer.tombstone(table: _db.notices, rowId: id);

  // ── lost & found ──────────────────────────────────────────────────────────

  Stream<List<LostItem>> watchLostItems() {
    final query = _db.select(_db.lostItems)
      ..where((i) => i.deletedAt.isNull())
      ..orderBy([(i) => OrderingTerm.desc(i.createdAt)]);
    return query.watch();
  }

  /// Sets an item's moderation state.
  ///
  /// The admin can always override the poster (CLAUDE.md §10). Items
  /// auto-hide at [autoHideReportCount] reports, but only a human makes
  /// removal permanent.
  Future<void> moderate({
    required LostItem item,
    required ModerationState state,
    required String moderatedBy,
  }) async {
    await _writer.upsert(
      table: _db.lostItems,
      rowId: item.id,
      row: LostItemsCompanion.insert(
        id: item.id,
        schoolId: item.schoolId,
        type: item.type,
        title: item.title,
        description: Value(item.description),
        category: Value(item.category),
        location: Value(item.location),
        incidentDate: Value(item.incidentDate),
        reportedBy: item.reportedBy,
        status: Value(item.status),
        moderation: Value(state.wire),
        reportCount: Value(item.reportCount),
        moderatedBy: Value(moderatedBy),
        photos: Value(item.photos),
        expiresAt: Value(item.expiresAt),
        createdAt: item.createdAt,
        updatedAt: nowTimestamp(),
      ),
    );
  }
}
