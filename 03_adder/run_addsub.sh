#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/full_adder.sv src/adder_subtractor.sv tb/adder_sub_tb.sv

# Run the simulation
vvp sim

