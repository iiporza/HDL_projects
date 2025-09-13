//this module implements a simple linear feedback shift register where the output bit is fed back into the input,
//there is a MUX which allows to select between d input or feedback input

module simpleLFSR #(parameter LENGTH = 8)(
    input logic clk,
    input logic d, fb,
    input logic rst,
    output logic [LENGTH-1:0] state
);

logic d_input;
assign d_input = fb ? state[LENGTH-1] : d;

//first stage
DFlipFlop ff0(.clk(clk), .rst(rst), .d(d_input), .q(state[0]));
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
