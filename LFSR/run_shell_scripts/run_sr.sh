#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/shiftRegister.sv src/DFlipFlop.sv tb/shiftRegister_tb.sv

# Run the simulation
vvp sim

