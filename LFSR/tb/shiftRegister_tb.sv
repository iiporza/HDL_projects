//this module is a test bench for a shift register with parallel output serial input
module shiftRegister_tb;

logic clk;
logic d;
logic rst;
localparam LENGTH = 8;
logic [LENGTH-1:0] state;

shiftRegister #(.LENGTH(LENGTH)) dut(
    .clk(clk), .rst(rst), .d(d), .state(state) 
);

//clock
always begin
    clk = ~clk;
    #(10);
end

initial begin
    
    $dumpfile("sr.vcd");   // for waveform viewing
    $dumpvars(0, shiftRegister_tb); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");
    d = '0;
    rst = '0;
    clk = '0;
    
    $monitor("register content = %b, clk = %b",state,clk);

    $display("======== RESET MODULE ======== ");
    rst = 1;
    #(5)
    rst = 0;

    apply_input(1,15);
    apply_input(0,85);
    apply_input(1,15);
    apply_input(0,85);
    $finish;
end

task apply_input(input logic val, input int delay);
    d = val;
    #(delay);
endtask

endmodule
