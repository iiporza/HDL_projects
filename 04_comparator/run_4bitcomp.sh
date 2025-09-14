#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/4bit_comparator.sv tb/4bit_comparator_tb.sv

# Run the simulation
vvp sim