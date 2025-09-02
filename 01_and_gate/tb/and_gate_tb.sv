`timescale 1ns/1ps
module and_gate_tb;

    logic a, b;
    logic y;

    // DUT instantiation
    and_gate dut(
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        

        $dumpfile("wave.vcd");   // for waveform viewing
        $dumpvars(0, and_gate_tb);

        // Header
        $display(" a | b | y ");
        $display("-----------");

        // Try all combinations
       a = 0; b = 0; #1 $display(" %0d | %0d | %0d ", a, b, y);
       a = 0; b = 1; #1 $display(" %0d | %0d | %0d ", a, b, y);
       a = 1; b = 0; #1 $display(" %0d | %0d | %0d ", a, b, y);
       a = 1; b = 1; #1 $display(" %0d | %0d | %0d ", a, b, y);

        $finish;
    end
    
endmodule 
