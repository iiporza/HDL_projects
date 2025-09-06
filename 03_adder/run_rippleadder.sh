#!/bin/bash

# Compile with Icarus Verilog
iverilog -g2012 -o sim src/full_adder.sv src/ripple_carry_adder.sv tb/ripple_carry_adder_tb.sv

# Run the simulation
vvp sim

