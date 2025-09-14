#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/full_adder.sv tb/full_adder_tb.sv

# Run the simulation
vvp sim

# Optional: open the waveform in Surfer
if [ -f wave.vcd ]; then
    surfer wave.vcd
fi