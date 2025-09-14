# LFSR

this projects implements a linear feedback shift register for generation of pseudo-random bit sequences.

The modules in the src folder are the following:

DFlipFlop.sv
implements a positive edge D flipflop with reset. Another module inside has a "set"

shiftRegister.sv
implements a shift register with a generate loop of DFlipFlop

LFSR_simple.sv
implements a shift register where the output bit is fed back in the input. A mux at the imput allows for programming before closing the feedback.

LFSR.sv
implements an 8 bit LFSR with XOR taps at bits 7,5,4,3

LSFR_nBit.sv
implements a parametric nBit XNOR LFSR up to 32 bits
