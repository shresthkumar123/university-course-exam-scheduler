# Enterprise University Course & Exam Scheduler 🎓

An AI-assisted, enterprise-style scheduling system developed in **C++20** that automatically generates conflict-free university class timetables and examination schedules. The project uses graph algorithms, constraint satisfaction, greedy optimization, and priority-based scheduling to manage courses, faculty, classrooms, student batches, and exams efficiently.

### Key Features
- **Timetable Generation:** Automatically allocates classrooms, faculty, and student batches while minimizing scheduling conflicts.
- **Exam Scheduling:** Generates examination schedules with minimum one-day gaps between exams in the same semester.
- **Graph Algorithms:** Implements BFS, DFS, cycle detection, and topological sorting for prerequisite validation.
- **Conflict Detection:** Identifies faculty, classroom, student-batch, capacity, and prerequisite conflicts.
- **Resource Management:** Manages courses, faculty, classrooms, student batches, and faculty availability.
- **Role-Based Access:** Provides separate Admin, Faculty, and Student console portals.
- **Reports & Analytics:** Generates faculty workload and classroom utilization reports.
- **Data Export:** Exports class timetables and exam schedules to CSV files.
- **Persistent Storage:** Uses JSON files to store and retrieve application data.
- **Audit Logging:** Records administrative activities and simulated notifications.

### Tech Stack
- **Language:** C++20
- **Core Concepts:** Object-Oriented Programming (OOP), Data Structures and Algorithms
- **Algorithms:** BFS, DFS, Topological Sorting, Greedy Algorithms, Priority Queues, Backtracking, and Hashing
- **Data Storage:** JSON
- **Build Tools:** Makefile and CMake

### Learning Outcomes
This project demonstrates practical applications of data structures, graph theory, scheduling algorithms, modular software design, data persistence, and automated conflict validation in a real-world university management scenario.
