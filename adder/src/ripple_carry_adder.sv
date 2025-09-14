//this module implements an N-bit ripple carry adder
`timescale 1ns/1ps

module ripple_carry_adder
#(parameter n = 4)(
    input logic[n-1:0] a,b,
    output logic[n-1:0] sum,
    output logic cout
);


logic [n:0] c; //create an internal variable c (n+1 bits)
assign c[0] = 0; //the first carry is 0

genvar i;
generate
    for (i = 0; i < n; i = i + 1) begin : fa_loop //give a label to each generated block
        full_adder fa(
            .a(a[i]),
            .b(b[i]),
            .cin(c[i]),
            .cout(c[i+1]),
            .sum(sum[i])
            );
    end
endgenerate

assign cout = c[n]; //final carry out

endmodule