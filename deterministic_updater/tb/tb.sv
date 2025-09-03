`timescale 1ns / 1ps

module tb();
reg unsigned [7:0] x_0, x_1, delta_0, delta_1;
reg start;
reg clk;
reg rst;
reg done; 


initial begin 
    $display("======== START SIMULATION ======== ");
    $display("======== INITIALIZING INPUT ======== ");
    start = 0;
    clk =0;
    rst = 0;
    x_0 = 0;
    x_1 = 0; 
    delta_0 = 0; 
    delta_1 = 0;
    
    
    #(100)
    $display("======== RESET MODULE ======== ");
    rst = 1;
    #(20);
    rst = 0;
    
    $display("======== RESET MODULE ======== ");
    x_0 = 25;  // 0.4
    delta_0 = 50; // 0.6
    x_1 = 43; // 0.1
    delta_1= 25; // 0.39 
    #(100);
    
    start = 1;
    #(15);
    start = 0;
    #5;

   #(1000) 
    $display("======== RESET MODULE ======== ");
    $finish;
end

always begin
    clk = ~clk;
    #(5);
end

top DUT(
    .x_0(x_0),
    .x_1(x_1),
    .delta_0(delta_0),
    .delta_1(delta_1),
    .start(start),
    .clk(clk),
    .rst(rst),
    .done(done)
);

endmodule