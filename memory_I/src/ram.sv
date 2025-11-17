//this is a simple ram module adapted from Harris, Harris RISC V
//this module describes a 2^N words * M-bit memory
module ram #(parameter N = 6, M = 32)(
    input logic clk,
    input logic wr,
    input logic [N-1:0] addr,
    input logic [M-1:0] din,
    output logic [M-1:0] dout
);

//memory array
logic [M-1:0] ram [2**N-1:0];

always_ff @(posedge clk) begin
    if (wr)
        ram[addr] <= din;
end

assign dout = ram[addr];

endmodule
