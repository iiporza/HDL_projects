//testbench for simple single D flip flop with reset
`timescale 1ns/1ps

module DFF_tb;

//declare signals
parameter n = 1;
logic clk;
logic rst;
logic [n-1:0] d;
logic [n-1:0] q;

//instantiate dut
DFlipFlop dut(
    .d(d), .q(q), .clk(clk), .rst(rst)
);

always begin
    clk = ~clk;
    #(10);
end

initial begin

    $dumpfile("dff.vcd");   // for waveform viewing
    $dumpvars(0, DFF_tb); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");
    d = '0;
    rst = '0;
    clk = '0;

    #(10)
    d = 1;
    #(15);
    d = 0;
    #(15)
    d = 1;
    #(15);

    $display("======== RESET MODULE ======== ");
    rst = 1;
    #(5)
    rst = 0;

    apply_input(1,15);
    apply_input(0,10);
    apply_input(1,10);
    apply_input(0,15);

    $finish;

end

task apply_input(input logic val, input int delay);
    d = val;
    #(delay);
endtask

endmodule