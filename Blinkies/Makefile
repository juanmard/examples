# Fomu
#PNRFLAGS  ?= --up5k --package uwg30 --pcf pins.pcf
#YOSYSFLAGS ?= -D PVT=1

# TinyFPGA-BX
PNRFLAGS  ?= --lp8k --package cm81 --pcf pins.pcf

GHDL ?= ghdl
GHDL_FLAGS += --std=08

VHDL_SYN_FILES = pong.vhd
VERILOG_SYN_FILES = pxClkGen.v

GHDLSYNTH ?= ghdl
YOSYS     ?= yosys
NEXTPNR   ?= nextpnr-ice40
ICEPACK   ?= icepack

# Default target: run all required targets to build the DFU image.
all: pong.bin
	@true

.DEFAULT: all

pong.json: $(VHDL_SYN_FILES) $(VERILOG_SYN_FILES)
	$(YOSYS) $(YOSYSFLAGS) \
		-p \
		"$(GHDLSYNTH) $(GHDL_FLAGS) $(VHDL_SYN_FILES) -e $(TOPLEVEL); \
		synth_ice40 \
		-top Pong \
		-json $@" -q $(VERILOG_SYN_FILES) 2>&1 | tee yosys-report.txt

pong.asc: pong.json
	$(NEXTPNR) \
		$(PNRFLAGS) \
		--json $< \
		--asc $@

# Use icepack to convert the FPGA configuration into a "bitstream" loadable onto the FPGA.
# This is called the bitstream generation step.
pong.bin: pong.asc
	$(ICEPACK) $< $@

# Use tinyprog to load the image onto the TinyFPGA-BX.
load: pong.bin
	tinyprog -p $<

.PHONY: load

clean:
	rm -fr *.cf *.json *-report.txt *.asc *.bin

.PHONY: clean
