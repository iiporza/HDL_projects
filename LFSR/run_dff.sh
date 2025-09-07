#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/DFlipFlop.sv tb/DFlipFlop_tb.sv

# Run the simulation
vvp sim
