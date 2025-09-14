# systemVerilog-learning
Various HDL projects and implementations for didactive purpose. It is a progressive series of digital design modules.

# simulate on icarus
I am using icarus verilog to simulate quickly on vscode for macOS

brew install icarus-verilog gtkwave

iverilog -g2012 -o sim src/name.sv tb/name_tb.sv

vvp sim

surfer wave.vcd

you can make a shell script .sh with these UNIX commands inside

once written make it executable by going to the desired folder and running

"chmod +x name.sh"

finally you can run 

./run.sh
