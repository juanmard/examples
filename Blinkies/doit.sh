#!/bin/bash
# Simple concatenación de comandos a ejecutar.
#
# yosys -p "synth_ice40 -json hardware.json" -q SB_PLL40_CORE.v pxClkGen.v top.v
# nextpnr-ice40 --lp8k --package cm81 --json hardware.json --asc hardware.asc --pcf pins.pcf -q
# icepack hardware.asc hardware.bin
# tinyprog -p hardware.bin
