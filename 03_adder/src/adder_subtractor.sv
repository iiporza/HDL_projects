//this module implements a ripple carry adder, 
//with a control signal enabling subtraction of the inputs
`timescale 1ns/1ps

module adder_subtractor 
#(parameter n = 4) (
    input logic[n-1:0] a,b,
    input logic sub, //ctrl = 0/1 : sum/sub
    output logic[n-1:0] sum,
    output logic cout
);
    
//define internal carry variable and subtraction
logic [n:0] c;
logic [n-1:0] b_sub;

assign c[0] = sub;
assign b_sub = sub ? ~b : b;

genvar i;
generate
    for (i = 0; i < n; i = i +1) begin : fa_loop
        full_adder fa(
            .a(a[i]),
            .b(b_sub[i]),
            .cin(c[i]),
            .cout(c[i+1]),
            .sum(sum[i])
        );
    end
endgenerate

assign cout = c[n];

endmodule
