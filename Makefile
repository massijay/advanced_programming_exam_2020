# Name for final executable file
TARGET_EXEC = final_program.x

# Compile options
CXX = c++
CXX_FLAGS = -Wall -Wextra -g -std=c++17

# Define target directory
BUILD_DIR = bin

# Define source directories where to find source files
SOURCE_DIRS = ., ./src



# Find all C++ files we want to compile
SRCS = $(shell find $(SRC_DIRS) -name *.cpp)

# String substitution for every C++ file
OBJS = $(SRCS:%.cpp=$(BUILD_DIR)/%.o)

# String substitution for every object file
EXECS = $(OBJS:.o=.x)

# Every folder containing source files will need to be passed to GCC so that it can find header files
INC_DIRS = $(shell find $(SRC_DIRS) -type d -not -path "./.git/*" -not -path "./.git")
# Add a prefix to INC_DIRS. So moduleA would become -ImoduleA. GCC understands this -I flag
INC_FLAGS = $(addprefix -I,$(INC_DIRS))


# Final build step
$(BUILD_DIR)/$(TARGET_EXEC): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(CXX_FLAGS)

# Build step for C++ source
$(BUILD_DIR)/%.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(INC_FLAGS) $(CXX_FLAGS) -c $< -o $@


.PHONY: all
all: clean build run

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

.PHONY: build
build:
	make

.PHONY: run
run:
	$(BUILD_DIR)/$(TARGET_EXEC)