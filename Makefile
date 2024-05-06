MAKEFLAGS += --no-builtin-rules

SHELL = /bin/bash
.SHELLFLAGS = -o pipefail -c

# ----- Defaults ------

COMPARE ?= 1
FULL_DISASM ?= 0

# Whether to colorize build messages
COLOR ?= 1
# Whether to hide commands or not
VERBOSE ?= 0
# Command for printing messages during the make.
PRINT ?= printf

UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)
ifeq ($(OS),Windows_NT)
$(error Native Windows is currently unsupported for building this repository, use WSL instead c:)
else ifeq ($(UNAME_S),Linux)
    DETECTED_OS := linux
    #Detect aarch64 devices (Like Raspberry Pi OS 64-bit)
    #If it's found, then change the compiler to a version that can compile in 32 bit mode.
    ifeq ($(UNAME_M),aarch64)
        CC_CHECK_COMP := arm-linux-gnueabihf-gcc
    endif
else ifeq ($(UNAME_S),Darwin)
    DETECTED_OS := macos
    MAKE := gmake
    CPPFLAGS += -xc++
endif

# ----- Common flags -----

MIPS_BINUTILS_PREFIX := mips-linux-gnu-
TOOLS	  := tools
PYTHON	  := python3
INCLUDES := -Iinclude -Isrc
DEFINES := -DF3DEX_GBI_2 -D_MIPS_SZLONG=32

# ----- Output ------

GAME_NAME := smashbrothers
BUILD_DIR := bin
ROM       := $(BUILD_DIR)/builtRom.z64
ELF       := /tmp/smashbrothers.elf
LD_SCRIPT := ./splat/$(GAME_NAME).ld

# ----- Tools ------

ifneq ($(shell type $(MIPS_BINUTILS_PREFIX)ld >/dev/null 2>/dev/null; echo $$?), 0)
$(error Unable to find $(MIPS_BINUTILS_PREFIX)ld. Please install or build MIPS binutils, commonly mips-linux-gnu. (or set MIPS_BINUTILS_PREFIX if your MIPS binutils install uses another prefix))
endif

CC              := $(TOOLS)/ido-recomp/$(DETECTED_OS)/cc
AS              := $(MIPS_BINUTILS_PREFIX)as
LD              := $(MIPS_BINUTILS_PREFIX)ld
OBJCOPY         := $(MIPS_BINUTILS_PREFIX)objcopy
OBJDUMP         := $(MIPS_BINUTILS_PREFIX)objdump
ASM_PROC        := $(PYTHON) $(TOOLS)/asm-processor/build.py
CCFLAGS         := -- $(AS) -32 -- -c -G 0 -non_shared -Xfullwarn -Xcpluscomm $(INCLUDES) $(DEFINES) -Wab,-r4300_mul -woff 649,838,712,568,624,709 -mips2 -O2
ASFLAGS         := -EB -I include -march=vr4300 -mabi=32
LDFLAGS         := -T .splat/undefined_funcs_auto.txt -T .splat/undefined_syms_auto.txt -T symbols/not_found.txt -T symbols/linker_constants.txt -T .splat/smashbrothers.ld
OBJCOPYFLAGS    := --pad-to=0xC00000 --gap-fill=0xFF

ASM_PROC_FLAGS  := --input-enc=utf-8 --output-enc=euc-jp --convert-statics=global-with-filename

SPLAT             ?= $(PYTHON) $(TOOLS)/splat/split.py
SPLAT_YAML        ?= $(GAME_NAME).yaml
SPLAT_FLAGS       ?=
ifneq ($(FULL_DISASM),0)
    SPLAT_FLAGS       += --disassemble-all
endif

# ----- Files ------
CC := $(ASM_PROC) $(ASM_PROC_FLAGS) $(CC) -- $(AS) $(ASFLAGS) --

C_FILES        := $(shell find src -type f | grep \\.c$)
S_TEXT_FILES   := $(shell find asm -type f | grep \\.s$ | grep -v nonmatchings | grep -v \\.rodata\\.s | grep -v \\.data\\.s | grep -v \\.bss\\.s)
S_DATA_FILES   := $(shell find asm -type f | grep \\.data\\.s$)
S_RODATA_FILES := $(shell find asm -type f | grep \\.rodata\\.s$)
S_BSS_FILES    := $(shell find asm -type f | grep \\.bss\\.s$)
PNG_FILES      := $(shell find assets -type f | grep \\.png$)
BIN_FILES      := $(shell find assets -type f | grep \\.bin$) \
                  $(foreach f,$(PNG_FILES:.png=.bin),$f)

O_FILES        := $(foreach f,$(C_FILES:.c=.o),$(BUILD_DIR)/$f) \
                  $(foreach f,$(S_TEXT_FILES:.s=.o),$(BUILD_DIR)/$f) \
                  $(foreach f,$(S_DATA_FILES:.s=.o),$(BUILD_DIR)/$f) \
                  $(foreach f,$(S_RODATA_FILES:.s=.o),$(BUILD_DIR)/$f) \
                  $(foreach f,$(S_BSS_FILES:.s=.o),$(BUILD_DIR)/$f) \
                  $(foreach f,$(BIN_FILES:.bin=.o),$(BUILD_DIR)/$f)

TEXT_SECTION_FILES := $(foreach f,$(C_FILES:.c=.text),$(BUILD_DIR)/$f) \
                      $(foreach f,$(S_TEXT_FILES:.s=.text),$(BUILD_DIR)/$f)

DATA_SECTION_FILES := $(foreach f,$(C_FILES:.c=.data),$(BUILD_DIR)/$f) \
                      $(foreach f,$(S_DATA_FILES:.s=.data),$(BUILD_DIR)/$f)

RODATA_SECTION_FILES := $(foreach f,$(C_FILES:.c=.rodata),$(BUILD_DIR)/$f) \
                        $(foreach f,$(S_RODATA_FILES:.s=.rodata),$(BUILD_DIR)/$f)


# Automatic dependency files
DEP_FILES := $(O_FILES:.o=.d)

# create build directories
$(shell mkdir -p bin/asm)
$(shell mkdir -p bin/src)
$(shell mkdir -p bin/assets)

# ----- Targets ------

all: rom

toolchain:
	@$(MAKE) -s -C tools

rom: $(ROM)
ifneq ($(COMPARE),0)
	bash $(TOOLS)/compareHashes.sh $(ROM) baserom.z64
endif

nolink: $(TEXT_SECTION_FILES) $(DATA_SECTION_FILES) $(RODATA_SECTION_FILES)
	bash $(TOOLS)/compareObjects.sh

clean:
	rm -r -f $(BUILD_DIR) $(ROM) $(ELF)

extract:
	rm -r -f assets
	$(SPLAT) $(SPLAT_YAML) $(SPLAT_FLAGS)

init:
	make extract
	make all

format:
	$(PYTHON) $(TOOLS)/formatHelper.py -e
	find include -type f | rg "\.h" | xargs clang-format -i
	find src -type f | rg "\.(c|h)" | xargs clang-format -i
	$(PYTHON) $(TOOLS)/formatHelper.py -s

# ----- Rules ------

$(ROM): $(ELF)
	$(OBJCOPY) $(OBJCOPYFLAGS) $< $@ -O binary

$(ELF): $(O_FILES) symbols/not_found.txt
	$(LD) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.text: $(BUILD_DIR)/%.o
	$(OBJCOPY) -O binary --only-section=.text $< $@

$(BUILD_DIR)/%.data: $(BUILD_DIR)/%.o
	$(OBJCOPY) -O binary --only-section=.data $< $@

$(BUILD_DIR)/%.rodata: $(BUILD_DIR)/%.o
	$(OBJCOPY) -O binary --only-section=.rodata $< $@

$(BUILD_DIR)/%.o: %.s
	@mkdir -p $(@D)
	$(AS) $(ASFLAGS) -o $@ $<

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(@D)
	clang -MMD -MP -fno-builtin -funsigned-char -fdiagnostics-color -std=gnu89 -m32 $(INCLUDES) $(DEFINES) -E -o $@ $< # d file generation
	$(CC) $(CCFLAGS) -o $@ $<

$(BUILD_DIR)/%.o: %.bin
	@mkdir -p $(@D)
	$(OBJCOPY) -I binary -O elf32-tradbigmips -B mips $< $@
	@bash $(TOOLS)/createPaletteObjectIfNeeded.sh $(OBJCOPY) -I binary -O elf32-tradbigmips -B mips $< $@

.PRECIOUS: assets/%.bin
assets/%.bin: assets/%.png
	$(PYTHON) $(TOOLS)/image_converter.py $< $@

-include $(DEP_FILES)
