module LFSR  #(parameter LENGTH = 8)(
    input logic clk,
    input logic rst,
    output logic [LENGTH-1:0] state
);

localparam logic [7:0] TAPS = 8'b10111000; 
// taps at bits 7,5,4,3

logic feedback;
assign feedback = ^(state & TAPS); //XOR all tapped bits

//first stage
DFlipFlopS ff0(.clk(clk), .rst(rst), .d(feedback), .q(state[0]));
//all of the other stages

genvar i;
generate
    for(i = 1; i < LENGTH; i = i +1) begin : sr_loop
        DFlipFlopS ff(
            .clk(clk),
            .rst(rst),
            .d(state[i-1]),
            .q(state[i])
        );
    end
endgenerate

endmodule