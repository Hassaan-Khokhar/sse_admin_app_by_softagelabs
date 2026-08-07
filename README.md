# 🏫 SSE School Management System — Admin App

> A Flutter Desktop (Windows) admin panel for managing a school of ~800 students in Pakistan. Built with an **offline-first** architecture — every read and write hits local SQLite, and the cloud is just a sync channel.

---

## 📸 Overview

The **SSE Admin App** is the principal/admin-facing desktop application of a two-app school management ecosystem:

| App | Platform | Purpose |
|---|---|---|
| **Admin App** (this repo) | Windows Desktop | Full school management for the principal |
| **Student App** (separate repo) | Android / iOS | Read-only dashboard for students & parents |

Both apps share data through **Supabase** and share their schema through the `school_core` Dart package.

---

## ✨ Features

### 📊 Dashboard
- Quick stats: total students, classes, faculty, subjects, unpaid challans
- 14-day attendance sparkline chart
- Today's attendance register at a glance
- Developer tools panel for seeding demo data

### 🏫 Class Management
- Create, edit, and manage classes (e.g. 9-A, 10-B)
- Assign class teachers from faculty
- Manage subjects per class with credit hours

### 👨‍🎓 Student Management
- Full student registry with CRUD operations
- Student profile cards with class assignment
- Document tracking per student

### 👨‍🏫 Faculty Management
- Teacher profiles and contact information
- Class-teacher assignment system
- Faculty attendance tracking

### 📝 Attendance
- Mark daily student attendance per class
- Teacher/staff attendance register
- Historical attendance records

### 📊 Marks & Report Cards
- View marks across Mid-Term, Final, and Assessment exams
- Per-student report card dialog with full breakdown
- Class-level percentage overview
- Grade calculation (A+ through F)

### 🕐 Timetable
- Weekly timetable grid (Monday–Saturday)
- Period management with subject and teacher assignment
- Add/delete rows dynamically
- Holiday declaration per day

### 📋 Noticeboard
- Rich notice cards with priority levels (Urgent, Important, General)
- Target audience options: Whole School, Faculty Only, or specific Class
- Optional expiry date — expired notices are greyed out
- Click any notice to view full details in a dialog

### 💰 Fee Management
- Fee structure setup per class
- Challan generation and tracking
- Payment status monitoring (Paid / Unpaid / Partial)

### 🔍 Lost & Found Manager
- **Pending → Active** moderation workflow
- Items default to `pending` until admin approves
- Tabbed UI: Pending requests vs Active listings
- Quick approve/delete actions on each card

---

## 🏗️ Architecture

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

### Key Principle
> **The school's internet goes down for hours at a time.** The UI never waits on a network call. Changes queue in an outbox and sync when connectivity returns.

---

## 🛠️ Tech Stack

| Layer | Technology | Notes |
|---|---|---|
| Framework | **Flutter / Dart** | Single codebase for desktop & mobile |
| Local Database | **SQLite via Drift** | Offline-first, same SQL as Postgres |
| Cloud Database | **Supabase Postgres** | Free tier for prototype |
| Authentication | **Supabase Auth** | |
| File Storage | **Supabase Storage** | Lost & Found photos |
| IDs | **UUIDv7** | Client-generated, `package:uuid` |
| Shared Code | `school_core` package | Schema + sync engine for both apps |

---

## 📁 Project Structure

```
protoType/
├── apps/
│   └── admin_app/              # Flutter Desktop (Windows) admin panel
│       └── lib/src/
│           ├── screens/        # All UI screens
│           ├── widgets/        # Reusable widgets
│           └── data/           # Repositories & data layer
├── packages/
│   └── school_core/            # Shared Dart package
│       └── lib/src/
│           ├── db/             # Drift database tables & generated code
│           ├── demo/           # Demo seed data
│           └── enums.dart      # Shared enumerations
├── migrations/                 # SQL migration scripts
├── seed/                       # Seed data
├── schema.sql                  # Full Postgres schema (source of truth)
└── CLAUDE.md                   # Project context & architecture docs
```

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK** (3.11+)
- **Dart SDK** (included with Flutter)
- **Visual Studio 2022** with C++ Desktop Development workload (for Windows builds)

### Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Hassaan-Khokhar/sse_admin_app_by_softagelabs.git
   cd sse_admin_app_by_softagelabs
   ```

2. **Install dependencies**
   ```bash
   cd packages/school_core
   dart pub get
   cd ../../apps/admin_app
   flutter pub get
   ```

3. **Generate Drift code** (required after schema changes)
   ```bash
   cd packages/school_core
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   cd apps/admin_app
   flutter run -d windows
   ```

5. **Build for release**
   ```bash
   flutter build windows --release
   ```
   The built executable will be at:
   `apps/admin_app/build/windows/x64/runner/Release/sse_admin_app.exe`

### Demo Data
Once the app is running, expand the **Developer Tools** panel on the Dashboard and click **"Seed demo data"** to populate the database with sample students, teachers, classes, marks, attendance, timetable, notices, and lost & found items.

---

## 🤝 Contributing

This is a private prototype. Contributions are managed internally by the development team at **SoftAge Labs**.

---

## 📄 License

This project is proprietary and not open-source. All rights reserved by SoftAge Labs.

---

<p align="center">
  Built with ❤️ by <strong>SoftAge Labs</strong>
</p>
