//this module implements a simple linear feedback shift register 

module simpleLFSR #(parameter LENGTH = 8)(
    input logic clk,
    input logic d,
    input logic rst,
    output logic [LENGTH-1:0] state
);

//first stage
DFlipFlop ff0(.clk(clk), .rst(rst), .d(state[LENGTH-1]), .q(state[0]));
//all of the other stages

genvar i;
generate
    for(i = 1; i < LENGTH; i = i +1) begin : sr_loop
        DFlipFlop ff(
            .clk(clk),
            .rst(rst),
            .d(state[i-1]),
            .q(state[i])
        );
    end
endgenerate


endmodule
