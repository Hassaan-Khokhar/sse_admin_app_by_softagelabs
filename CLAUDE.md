# CLAUDE.md — SSE School Management System

> Project context for Claude Code. Read this before doing anything in this repo.
> Last updated: 2026-08-01

---

## 1. What this project is

A school management system for a real school in Pakistan (~800 students). **Two Flutter apps** sharing one cloud database:

| App | Platform | Built by | Repo |
|---|---|---|---|
| **Admin app** | Flutter **Desktop (Windows)** | Hassaan (this repo) | `sse_admin_app_by_softagelabs` |
| **Student app** | Flutter **mobile (Android + iOS)** | Teammate (separate repo) | — |

**Current phase: PROTOTYPE.** The goal is a **demo video** to send to the school — not a production release. Nothing is public yet, nothing is on the app stores.

The two devs work from **different cities**. They share data through one Supabase project and share the schema through git.

### Origin
The student app is a **customised university app** the team built at university (student dashboard with Notice Board, Lost & Found, Report Item, Timetable, GPA/CGPA Calc, GPA Planning). Roughly **60% is reusable**. See §11 for the university→school model differences — this is the biggest source of bugs in this project.

---

## 2. The core constraint — read this first

**The school's internet goes down for hours at a time.**

Therefore the system is **offline-first**:
- Both apps keep a **full local SQLite database** on the device
- All reads and writes hit **local SQLite first** — the UI never waits for the network
- The internet is a **sync channel**, not a dependency
- Changes queue in an **outbox** and flush whenever connectivity returns

**Never** write a feature that blocks the UI on a network call. If you catch yourself doing that, stop — it violates the whole premise of the system.

---

## 3. Architecture

**The PC and the phone never talk to each other directly. The cloud is the meeting point.**

```
  STUDENT PHONE (Flutter)              ADMIN PC (Flutter Desktop)
  ┌────────────────────────┐          ┌──────────────────────────┐
  │ Drift/SQLite           │          │ Drift/SQLite             │
  │  • own data (~2 MB)    │          │  • whole school (~30 MB) │
  │  • all lost items      │          │  • outbox queue          │
  │ 📥 PULL  📤 PUSH*      │          │ 📥 PULL  📤 PUSH         │
  └───────────┬────────────┘          └───────────┬──────────────┘
              │        (only when internet exists) │
              └──────────────┬─────────────────────┘
                             ▼
              ┌──────────────────────────────────┐
              │  SUPABASE                        │
              │  Postgres · Auth · Storage · RLS │
              └──────────────────────────────────┘
```

`*` The student app pushes **only** `lost_items` and `item_claims`. Everything else is read-only for students.

**A LAN / campus-hub mode was considered and rejected.** The internet is down for *hours*, not days, and students need access from home. Cloud-mediated sync is sufficient. Do not reintroduce this.

---

## 4. Tech stack (decided)

| Layer | Choice | Notes |
|---|---|---|
| Both apps | **Flutter / Dart** | Team already knows it; existing app is Flutter |
| Local DB | **SQLite via Drift** | Runs on Windows desktop AND mobile, same SQL as Postgres |
| Cloud DB | **Supabase Postgres** | Free tier for prototype |
| Auth | **Supabase Auth** | |
| File storage | **Supabase Storage** | Lost & Found photos |
| IDs | **UUIDv7**, client-generated | `package:uuid ^4.x` → `uuid.v7()` |
| Shared code | Dart package `school_core` | Schema + sync engine, used by **both** apps |

### Rejected, with reasons — don't re-propose these
- **Electron for desktop** — would add TypeScript as a second language. Flutter Desktop keeps it to one.
- **Postgres/MySQL locally on the school PC** — needs install + Windows service + admin rights, and cannot run on a phone.
- **Firebase Firestore** — NoSQL kills the reporting queries (class averages, defaulter lists), and per-read billing punishes the principal's dashboard.
- **Realm / Isar** — no shared schema with Postgres, no desktop story.
- **PowerSync / ElectricSQL** — good tools, but the conflict rules here are domain-specific and the dataset is tiny. Custom sync is the right call.

---

## 5. Repo layout

```
protoType/
├── CLAUDE.md          ← this file
├── schema.sql         ← THE CONTRACT between both apps (18 tables)
├── .env               ← real secrets, GITIGNORED
├── .env.example       ← committed template
└── .gitignore
```

Planned structure once code starts:

```
├── packages/school_core/   ← Drift schema + sync engine (shared with student app)
└── apps/admin_app/         ← Flutter Desktop
```

---

## 6. Database contract — non-negotiable rules

`schema.sql` is **owned by the admin app** (this repo) and **consumed** by the student app. The admin app creates the data; the student app reads it.

**Any schema change = a new numbered migration file + a message to the teammate.** Never edit tables in the Supabase dashboard silently — that is the #1 way this project breaks.

### The five rules both apps must follow

1. **UUIDv7 generated on the CLIENT** — never `DEFAULT gen_random_uuid()`. A teacher offline marking 40 students needs IDs immediately.
2. **Enums are TEXT + CHECK, exact strings.** `'present'`, `'absent'`, `'leave'`, `'late'`, `'holiday'`. Not `'P'`, not `'Present'`.
3. **NEVER DELETE A ROW.** Set `deleted_at`. A hard delete cannot sync (a missing row is invisible to peers), and a withdrawn student's history must survive.
4. **Every syncable table carries 4 sync columns:** `updated_at`, `deleted_at`, `server_seq`, `version`.
5. **PG → SQLite type mapping:** `UUID`→`TEXT`, `TIMESTAMPTZ`→`TEXT` (ISO-8601 UTC with `Z`), `DATE`→`TEXT` (`YYYY-MM-DD`), `JSONB`→`TEXT`, `BOOLEAN`→`INTEGER`, `NUMERIC`→`REAL`.

### Idempotency
`attendance` has `UNIQUE(student_id, date)` and `marks` has `UNIQUE(exam_id, student_id, subject_id)`. Marking the same thing twice **updates**, never duplicates. This is what makes offline retries safe. **Do not drop these constraints.**

---

## 7. 🚨 Security — non-negotiable

**The Supabase publishable key is compiled into both apps.** Anyone can extract it from the `.apk` or `.exe` in ~30 seconds. **RLS is the only thing protecting the database.**

- ✅ **Publishable key** (`sb_publishable_...`) → both apps
- 🚫 **Secret key** (`sb_secret_...`) → **nowhere**. It bypasses every RLS policy.

The temptation will be: *"the admin app needs full access, let me just use the secret key."* **No.** The principal gets full access through the `super_admin` RLS policies in `schema.sql` §9. The desktop `.exe` ships to a school PC that anyone can copy.

There is deliberately **no student INSERT/UPDATE policy** on `attendance`, `marks`, or `fee_challans`. RLS denies by default, so a student physically cannot write their own grades. **Verify this by hand before filming the demo.**

Legacy `anon`/`service_role` keys are deprecated by end of 2026 — use `sb_publishable_`/`sb_secret_`.

### Minors — safety rules
- **Never expose a student's phone number or contact details in the app.**
- Lost & Found claims go to the **office**, never student-to-student. The app is a notice board; the office does the handover.
- Lost & Found needs moderation: report button, auto-hide at 3 reports, admin removal, 5 posts/student/week.

---

## 8. Decisions log — with rationale

Do not re-litigate these without new information.

| Decision | Rationale |
|---|---|
| **Attendance is DAILY**, one row per student per day | Class teacher marks the whole class once each morning. Per-period would be 8× the rows and 8× the teacher's work, and isn't how the school operates. |
| **Prototype is PRINCIPAL-ONLY** (`super_admin`) | Matches the sketch. `roles` + `teacher_class_assignments` tables exist, so enabling the teacher role later is seeding rows, not a migration. |
| **Cloud-mediated sync, no LAN hub** | Internet is down for hours not days, and students need access from home. |
| **Students are read-mostly** | Only write path is Lost & Found. Removes conflict resolution from the mobile app entirely. |
| **No payment gateway** | Challans are **display only**. Payment recorded by the office in the admin app. Avoids financial compliance entirely. |
| **`exams.is_published` flag** | Principal enters marks over days, then flips one switch and all students see results at once. Prevents half-entered results leaking. Good demo beat. |
| **`admission_no` + `roll_no` separate** | Admission no is permanent and school-wide; roll no is per-class and resets yearly. The uni app's single `FA23-BCS-067` can't express both. |
| **`fee_challans.arrears` column** | Unpaid months carry forward. Without it the bulk generator produces wrong totals from month two and the school's books never balance. |
| **5 attendance states, not 2** | The sketch had red/green only. Real schools need present/absent/leave/late/holiday. Retrofitting a boolean into 5 states means migrating every device. |
| **Timetable belongs to the CLASS** | 40 students share one timetable. 40× less data than the uni per-student model. |

---

## 9. Scope

### In scope — v1
**Admin (principal):** dashboard · manage classes/sections · manage teachers · enroll students · **withdraw students** · **mark attendance** · enter marks · exams + publish results · per-class fee structures · **one-click bulk challan generation for the whole school** · defaulter/pending-dues list · post notices · Lost & Found moderation

**Student:** profile · attendance (monthly calendar) · marks/marksheet · fee challan (view only) · timetable · assignments (view only) · notices · Lost & Found + Report Item

### Explicitly OUT of scope — confirm before building
- ❌ Paying fees in the app
- ❌ Students submitting assignments
- ❌ Parent–teacher chat / messaging
- ❌ Separate parent login
- ❌ GPA / CGPA / GPA Planning — **removed** from the uni app (school uses percentage + grades)

### Student app dashboard (per the sketch)
- Grid tiles: Notice Board · Report Item · Lost & Found · Timetable · **Attendance** · **Marks** · **Fees**
- **Subject grid is dynamic per student** — `SELECT * FROM subjects WHERE class_id = my_class`. This is the entire "dynamic per student" requirement; no special logic needed.
- Subject tiles show **marks/grade** (not attendance % — attendance is daily, so it's its own tile)
- **If a fee challan is pending, the fee status pins to the top**; otherwise the subject grid is on top
- Attendance calendar: 🟢 present · 🔴 absent · 🟡 leave · 🟠 late · ⬜ holiday
- Attendance % = `(present + late) / (total - holiday)`

### Grade scale (both apps must use the same function — put it in `school_core`)
`>=90 A+` · `>=80 A` · `>=70 B` · `>=60 C` · `>=50 D` · `>=40 E` · else `F`

---

## 10. Sync design

**Two endpoints, both idempotent:**
- `POST /sync/push` — drain the outbox. Every op carries a client-generated `op_id` so retries after a dropped connection dedupe instead of duplicating.
- `GET /sync/pull?since=<cursor>` — changes since the cursor.

**Order matters: PUSH before PULL**, always. Otherwise you pull the server's stale copy of a row you just changed locally and overwrite yourself.

**Every local write is one transaction:** update the row **and** insert into `outbox`.

**Cursor is `server_seq` (a monotonic BIGINT), never a timestamp.** School PC clocks are wrong; a clock 2 days behind silently skips changes forever.

**Conflicts are resolved by ownership, not blanket last-write-wins:**
- Attendance/marks for a class → owned by that class's teacher → no conflict in practice
- Student status (active/withdrawn) → **principal always wins**
- Role precedence: `super_admin` > `teacher` > `student`
- Lost & Found → the poster owns their post; admin can always override

**Photos never go through the sync log.** Separate pipeline: compress to ~200 KB + a ~30 KB thumbnail → upload the **file first**, push the **row second** (otherwise peers see broken images). List views use thumbnails only. Max 3 photos/item. Auto-expire items after 30 days and delete their photos.

> Photos are the only thing that will drive the cloud bill. Everything else is tiny — the whole 800-student database is ~30 MB.

### Prototype shortcut
Full `change_log` + `seq` cursor can be deferred; pulling by `updated_at > last_sync` is fine for the demo. But **keep**: client UUIDs, `deleted_at` tombstones, the outbox, and the 4 sync columns. Those are impossible to retrofit later.

---

## 11. ⚠️ University → School model differences

The student app came from a university project. These are **data-model** differences, not label changes. Getting one wrong causes real bugs.

| University (old app) | School (this project) |
|---|---|
| Student enrolls in **courses individually** | Student belongs to **one class-section** (9-A) |
| Every student has a different timetable | Timetable belongs to the **class** |
| GPA / CGPA / credit hours | **Percentage / grades** |
| Semesters (Fall 23) | **Terms** (First/Mid/Final) + academic year |
| Department ("Management Sciences") | **Class + Section** ("Class 9-A") |
| `FA23-BCS-067` | `admission_no` + `roll_no` |
| Attendance per course session | Attendance per **day** |

---

## 12. Demo video plan

~3 minutes. The two moments that sell it are at 0:30 and 2:20.

```
0:00  Principal logs in → dashboard with real-looking charts
0:30  ⚡ TURN OFF WIFI ON CAMERA → mark 40 students' attendance, enter marks
0:55  Status bar: "⚠ 42 changes pending sync"
1:05  ⚡ TURN WIFI BACK ON → "✓ Synced just now"
1:15  📱 Phone: pull to refresh → attendance + marks are there
1:35  💰 One-click challan generation → appears on the phone
1:55  🔍 Student posts a lost item → lands in the admin moderation queue
2:20  🎬 CLOSER: principal withdraws the student → sync →
      phone shows "Your account is no longer active."
```

**Film the PC and the phone in ONE frame.** Use **scrcpy** to mirror the Android phone onto the PC screen, then record the whole desktop with OBS. An unbroken shot is proof; cutting between a screen recording and a phone camera looks edited.

**The sync status bar is the most important UI in the video** — `⚠ 40 pending` → `⚡ Syncing…` → `✓ Synced just now`. It's what makes an invisible technical achievement visible to a principal.

**Seed realistic data before filming:** ~50 students with real Pakistani names across 9-A/9-B/10-A, **2 months of back-dated attendance** (otherwise every chart is empty), realistic PKR fee amounts, 3–4 lost items. Use one shared `seed.sql` so the same student (same UUID) exists on both sides.

---

## 13. Team workflow

- **Different cities.** Shared through one Supabase project + git.
- **Hassaan owns `schema.sql`.** The teammate consumes it and requests changes rather than editing.
- Teammate's Supabase dashboard role: **Developer** (org-wide — project-scoped roles are a paid feature).
- Secrets go in `.env` (gitignored). `.env.example` is committed. Real values shared privately, never in a commit or a screenshot in the demo video.
- **Free-tier gotcha:** a Supabase project pauses after ~1 week of inactivity. Click Resume — no data loss. Don't discover this the morning you film.

---

## 14. Costs

**Prototype: $0.** Supabase free tier + direct install for demos. No store publishing needed to show the school.

**Production year 1: ~$436**
- Apple Developer **$99/year, recurring** (unavoidable for iOS; app is pulled if it lapses)
- Google Play $25 one-time
- Supabase Pro $25/month — **move to this at go-live.** Not for capacity (the DB is ~30 MB) but because the free tier has **no backups**, and this is a school's permanent academic record.
- Domain ~$12/year

---

## 15. Open questions

Unresolved. Ask before building anything that depends on them.

1. Fee challan — display only, confirmed? (assumed **yes**)
2. Assignments — view only, no submission? (assumed **yes**)
3. Do parents need their own login, or do they use the student's account?
4. UI language — English only, or Urdu too? (Urdu ⇒ RTL layout; cheap now, painful later)
5. Report card PDF format — need a photo of the school's current printed report card
6. Existing student data — is there an Excel/register to import? (hand-typing 800 students is a week)
7. Who owns the Supabase account and pays the Apple fee — the team or the school?

---

## 16. Working notes

- User writes in mixed Urdu/English; **prefers answers in English**.
- Don't start writing code unless asked — this phase is mostly design discussion.
- Don't commit or push unless asked.
