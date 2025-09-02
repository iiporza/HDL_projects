# systemVerilog-learning
Various projects to learn HDL and implementations

systemverilog-learning/
│
├── 01_logic_gates/
│   ├── src/                # SystemVerilog source files
│   │   └── gates.sv
│   ├── tb/                 # Testbenches
│   │   └── gates_tb.sv
│   ├── sim/                # (optional) simulation scripts, waveforms
│   │   └── gates_tb_behav.wcfg   # waveform config
│   ├── doc/                # Diagrams, notes, screenshots
│   │   └── waveform.png
│   └── README.md           # Short explanation of project
│
├── 02_adder/
│   ├── src/
│   ├── tb/
│   ├── README.md
│
├── .gitignore
└── README.md               # Top-level portfolio description

I am using icarus verilog to simulate quickly on vscode for macOS

brew install icarus-verilog gtkwave

iverilog -g2012 -o sim src/and_gate.sv tb/and_gate_tb.sv

vvp sim

surfer wave.vcd