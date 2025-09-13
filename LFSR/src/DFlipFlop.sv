//this module implements a simple D flip flop with reset
`timescale 1ns/1ps

module DFlipFlop #(parameter n = 1)(
    input logic clk,
    input logic [n-1:0] d,
    input logic rst,
    output logic [n-1:0] q
);

//asynchronous reset
    always_ff @(posedge clk, posedge rst)
        if (rst) q <= '0;
        else q <= d;

endmodule

//synchronous reset
//    always_ff @(posedge clk)
//        if (reset) q <= '0;
//        else q <= d;

module DFlipFlopS #(parameter n = 1)(
    input logic clk,
    input logic [n-1:0] d,
    input logic rst,
    output logic [n-1:0] q
);

//asynchronous reset
    always_ff @(posedge clk, posedge rst)
        if (rst) q <= '1;
        else q <= d;

endmodule