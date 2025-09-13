module LFSR_tb;

//declare signals
logic clk,rst;
localparam LENGTH = 8;
logic [LENGTH-1:0] state; 

//instantiate dut

LFSR #(.LENGTH(LENGTH)) dut(
    .clk(clk), .rst(rst), .state(state)
);

//clock
always begin
    clk = ~clk;
    #(5);
end

initial begin


    $dumpfile("lfsr.vcd");   // for waveform viewing
    $dumpvars(0, LFSR_tb); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");
    rst = '0;
    clk = '0;

    $monitor("state = %b",state);

    $display("======== RESET MODULE ======== ");
    rst = 1;
    #(5)
    rst = 0;

    #(5*260);

    $finish;

end

endmodule