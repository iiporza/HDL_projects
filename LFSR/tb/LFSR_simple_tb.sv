module LFSR_simple_tb;

//declare signals
logic clk;
logic d;
logic fb;
logic rst;
localparam LENGTH = 8;
logic [LENGTH-1:0] state;

simpleLFSR #(.LENGTH(LENGTH)) dut(
    .clk(clk), .rst(rst), .d(d), .fb(fb), .state(state)
);

//clock
always begin
    clk = ~clk;
    #(10);
end

initial begin

    $dumpfile("LFSRsimple.vcd");   // for waveform viewing
    $dumpvars(0, LFSR_simple_tb); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");
    d = '0;
    rst = '0;
    clk = '0;
    fb = '0;

    $monitor("register content = %b",state);

    $display("======== RESET MODULE ======== ");
    rst = 1;
    #(5)
    rst = 0;
    apply_input(1,5);

    fb = '1;

    #(200)

    $finish;

end

task apply_input(input logic val, input int delay);
    d = val;
    #(delay);
endtask


endmodule