#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/LFSR.sv src/DFlipFlop.sv tb/LFSR_tb.sv

# Run the simulation
vvp sim
