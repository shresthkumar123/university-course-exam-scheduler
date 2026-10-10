cmake_minimum_required(VERSION 3.16)
project(UniversityScheduler CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

add_compile_options(-Wall -Wextra -O2)

include_directories(include)

add_executable(scheduler
    src/main.cpp
    src/Graph.cpp
    src/Scheduler.cpp
    src/ConflictEngine.cpp
    src/ExamScheduler.cpp
    src/DataStore.cpp
)

# Simple standalone test runner (no external test framework dependency).
add_executable(scheduler_tests
    tests/test_main.cpp
    src/Graph.cpp
    src/Scheduler.cpp
    src/ConflictEngine.cpp
    src/ExamScheduler.cpp
    src/DataStore.cpp
)

set_target_properties(scheduler scheduler_tests
    PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}
)
