`timescale 1ns/1ps

module gates(
        input logic[3:0] a, b,
        input logic s,
        output logic[3:0] y1,y2,y3,y4,y5,y6,
        output tri [3:0] y7
        );

    /* an assignment like this is a continuous assignment, it means
    that whenever the input on the right side changes, the output
    is recomputed. This describes combinational logic*/

    assign y1 = a & b; //and
    assign y2 = a | b; //or
    assign y3 = a ^ b; //xor
    assign y4 = ~(a | b); //nor
    assign y5 = ~(a & b); //nand

    assign y6 = s ? a : b; //ternary operator mux

    assign y7 = s ? a :4'bz; //tristate buffer

endmodule

