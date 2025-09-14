`timescale 1ns / 1ps
module tb;

//in a testbench you don't use input or output. They are only
//for synthesizable modules like DUT. In a tb you just declare
//signals as logic

logic [3:0] a, b;
logic s;
logic[3:0] y1,y2,y3,y4,y5,y6;
tri [3:0] y7;

//instantiate DUT and assign 
gates dut(
    .a(a), .b(b),
    .s(s),
    .y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),
    .y7(y7)
);

//then in the initial begin, we initialize inputs to known states. 
//Then we can assert/deassert variables
initial begin

    $dumpfile("wave.vcd");   // for waveform viewing
    $dumpvars(0, tb); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");

    a = 4'b0000;
    b = 4'b0000;
    s = 0;
    //apply inputs one at a time and self check
    //check the combinatorial logic

    #10;
    assert (y1 === (a & b))  else $error("AND fail");
    assert (y2 === (a | b))  else $error("OR fail");
    assert (y3 === (a ^ b))  else $error("XOR fail");
    assert (y4 === ~(a | b)) else $error("NOR fail");
    assert (y5 === ~(a & b)) else $error("NAND fail");

    //finish checking everything

    $finish;
end

endmodule
