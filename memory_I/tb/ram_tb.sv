// test bench for ram module
module ram_tb();

//declare signals
logic clk;
logic wr;
logic [N-1:0] addr;
logic [M-1:0] din;
logic [M-1:0] dout;

//instantiate dut
ram dut(
    .clk(clk),
    .wr(wr),
    .addr(addr)
    .din(din)
    .dout(dout)
    );

always begin
    #5;
    clk = ~clk;
end

initial begin
    $dumpfile("ram.vcd");   // for waveform viewing
    $dumpvars(0, ram_tb); //with the same name of the module

end

//


endmodule