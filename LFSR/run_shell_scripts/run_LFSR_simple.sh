#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/LFSR_simple.sv src/DFlipFlop.sv tb/LFSR_simple_tb.sv

# Run the simulation
vvp sim
