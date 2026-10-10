CXX := g++
CXXFLAGS := -std=c++20 -Wall -Wextra -O2 -Iinclude
SRC := src/main.cpp src/Graph.cpp src/Scheduler.cpp src/ConflictEngine.cpp src/ExamScheduler.cpp src/DataStore.cpp
TEST_SRC := tests/test_main.cpp src/Graph.cpp src/Scheduler.cpp src/ConflictEngine.cpp src/ExamScheduler.cpp src/DataStore.cpp

.PHONY: all clean run test

all: scheduler

scheduler: $(SRC)
	$(CXX) $(CXXFLAGS) -o scheduler $(SRC)

scheduler_tests: $(TEST_SRC)
	$(CXX) $(CXXFLAGS) -o scheduler_tests $(TEST_SRC)

run: scheduler
	./scheduler

test: scheduler_tests
	./scheduler_tests

clean:
	rm -f scheduler scheduler_tests
