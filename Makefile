# Define directories
SRC_DIR := src
BUILD_DIR := build
BIN_DIR := bin

# Files
ASM_SRCS := $(wildcard $(SRC_DIR)/*.asm)
OBJS := $(patsubst $(SRC_DIR)/%.asm,$(BUILD_DIR)/%.o,$(ASM_SRCS))
TARGET := $(BIN_DIR)/main

NASM := nasm
NASMFLAGS := -f elf64

LD := ld
LDFLAGS :=

# Default target
all: $(TARGET)

# Link final executable
$(TARGET): $(OBJS) | $(BIN_DIR)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

# Compile .asm to .o
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

# Create necessary directories if they don't exist
$(BUILD_DIR) $(BIN_DIR):
	mkdir -p $@

# Clean up build artifacts
clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

.PHONY: all clean
