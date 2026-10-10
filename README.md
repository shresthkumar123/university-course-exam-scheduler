# Enterprise University Course & Exam Scheduler

An AI-assisted, enterprise-style scheduling engine written in **C++20** that
automatically generates conflict-free class timetables and exam schedules
from course, faculty, room, and student-batch data — using graph algorithms,
constraint satisfaction, priority scheduling, and greedy optimization instead
of hardcoded rules.

## Features

- **Course / Faculty / Room / Batch management** (CRUD via the console Admin Portal)
- **Prerequisite Graph Engine** — BFS traversal, Kahn's topological sort, DFS cycle detection
- **Timetable Generator** — priority-queue batch prioritization + greedy nearest-fit room allocation, respecting faculty availability, room capacity/lab requirements, and prerequisite ordering
- **Independent Conflict Detection Engine** — re-audits any timetable for faculty/room/student/prerequisite/capacity conflicts using hash-map lookups
- **Exam Scheduler** — backtracking-style placement enforcing a minimum one-day gap per semester, invigilator & room availability, holidays, and a max-exams-per-day cap
- **Reports** — faculty workload, room utilization, per-batch/per-faculty schedules
- **CSV export** for both the class timetable and the exam schedule
- **Holiday calendar** (Sundays + configurable holidays) and **faculty leave** handling
- **Role-based access** — Admin / Faculty / Student console portals with different permissions
- **Audit logging** (`reports/audit_log.csv`) and simulated **notifications** (console + `exports/notifications.log`)
- **JSON-backed persistence** (`database/*.json`) via the bundled [nlohmann/json](https://github.com/nlohmann/json) single-header library

## Tech Stack

| Category | Details |
|---|---|
| Language | C++20 |
| STL | `unordered_map`, `queue`, `priority_queue`, `vector`, `set`, `filesystem`, `chrono` |
| Algorithms | BFS, DFS, Kahn's Topological Sort, Greedy allocation, Priority Queue scheduling, Backtracking (exams), Hashing |
| Design Patterns | Singleton (`DataStore`), Factory-style construction, Strategy (pluggable conflict rules), MVC-ish separation (entities / engine / console UI) |
| Database | JSON files under `database/` |

## Folder Structure

```
UniversityScheduler/
├── include/            Header files (Course, Faculty, Room, Student, Graph,
│                        Scheduler, ExamScheduler, ConflictEngine, DataStore,
│                        AuditLog, Common, json.hpp)
├── src/                 Implementation files + main.cpp (console entry point)
├── database/            Sample JSON "database" (courses, faculty, rooms, batches)
├── reports/              Generated audit logs land here
├── exports/              Generated CSV exports + notification logs land here
├── tests/                Lightweight, dependency-free test suite
├── CMakeLists.txt
├── Makefile
└── README.md
```

## Building

### Option A — Makefile (simplest)

```bash
make            # builds ./scheduler
make test       # builds and runs ./scheduler_tests
make run        # builds and runs the app
make clean
```

### Option B — CMake

```bash
mkdir build && cd build
cmake ..
cmake --build .
./scheduler
./scheduler_tests
```

Requires a C++20-capable compiler (g++ 10+ / clang 12+).

## Running

```bash
./scheduler
```

You'll be asked to log in as **Admin**, **Faculty**, or **Student** (any
User ID is accepted — this is a demo of role-based menus, not real auth).

A typical Admin session:

1. `6` — Generate Class Timetable (validates the prerequisite graph first; refuses to proceed if a cycle is found)
2. `8` — View Timetable (all batches, or filter by Batch ID)
3. `9` — Audit Conflicts (independent re-verification pass)
4. `7` — Generate Exam Schedule (enter max exams/day, e.g. `3`)
5. `10` — View Reports (faculty workload, room utilization)
6. `11` — Export CSV (writes `exports/class_timetable.csv` and `exports/exam_schedule.csv`)

Every mutating admin action (add/edit/delete course, assign faculty, add
room, generate schedules, export) is appended to `reports/audit_log.csv`
with a timestamp and admin ID.

The bundled sample data reproduces the prerequisite chain from the spec
(`Data Structures → Operating Systems → Distributed Systems → Cloud
Computing`) plus DBMS and Computer Networks, across three sample batches,
three faculty members, and six rooms (including two labs and one room
under maintenance to demonstrate exclusion).

## Testing

`tests/test_main.cpp` is a small, dependency-free assertion-based suite
(no GoogleTest needed) that verifies:

- Topological sort keeps prerequisite courses before their dependents
- Cycle detection correctly flags an invalid prerequisite graph and
  `topologicalSort()` throws as a safety net
- The generated timetable has **zero** faculty/room/batch conflicts
- The exam scheduler enforces the minimum one-day gap between two exams
  in the same semester

```bash
make test
```

## Notes on Design Choices

- **Why JSON, not SQLite?** The spec allows either; JSON keeps the project
  dependency-light (single header, no linking against `libsqlite3`) while
  still demonstrating a real persistence layer (load/save round-trips,
  `std::filesystem` paths, exception handling on malformed files).
- **Why a console UI instead of a real REST API?** The spec's "REST API
  (C++)" box sits in front of the same Scheduling Engine implemented here;
  the console `main.cpp` exercises every engine feature end-to-end without
  requiring an HTTP framework dependency. The engine classes (`Scheduler`,
  `ExamScheduler`, `ConflictEngine`, `PrerequisiteGraph`) are fully
  decoupled from the console and could be wrapped by an HTTP layer
  (e.g. cpp-httplib) later with no changes to their public interfaces.
- **Result<T> / VoidResult** (`Common.h`) show a non-exception-based error
  channel for expected, recoverable outcomes, while `std::runtime_error`
  is still used (and unit-tested) for truly exceptional states like a
  cyclic prerequisite graph.

## Resume Description

> Enterprise University Course & Exam Scheduler — Designed and developed
> an enterprise-grade scheduling system in C++20 that generates
> conflict-free class and exam timetables using graph algorithms (BFS,
> DFS, Topological Sorting), priority queues, and greedy optimization.
> Implemented prerequisite validation, faculty workload balancing, room
> allocation, conflict detection, holiday management, role-based access,
> and comprehensive reporting with a modular OOP architecture.
