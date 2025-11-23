`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2025 04:01:17 PM
// Design Name: 
// Module Name: LFSR_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module LFSR_nbit_tb ();
 
localparam NUM_BITS = 8;
 

  // DUT signals
  logic clk;
  logic enable;
  logic seed_dv;
  logic [NUM_BITS-1:0] seed_data;
  logic [NUM_BITS-1:0] lfsr_state;
  logic lfsr_done;
  int cycles;
  
  // Instantiate DUT
  LFSR #(.NUM_BITS(NUM_BITS)) dut (
    .i_Clk(clk),
    .i_Enable(enable),
    .i_Seed_DV(seed_dv),
    .i_Seed_Data(seed_data),
    .o_LFSR_Data(lfsr_state),
    .o_LFSR_Done(lfsr_done)
  );

  // Clock generation (100 MHz → 10 ns period)
  initial clk = 0;
  always #5 clk = ~clk;
  
  //test procedure
  initial begin
  enable = 0;
  seed_dv = 0;
  seed_data = 8'hF3;
  #20;
  
   // Load seed
    $display("Loading seed %b", seed_data);
    seed_dv = 1;
    #10;
    seed_dv = 0;

    // Start LFSR
    enable = 1;
    $display("Starting LFSR...");

    cycles = 0;

    // Monitor sequence
    forever begin
      @(posedge clk);
      cycles++;

      $display("%0d: LFSR = %b", cycles, lfsr_state);

      // Stop when sequence returns to the seed (period reached)
      if ((lfsr_state == seed_data) && cycles > 1) begin
        $display("Sequence repeated after %0d cycles.", cycles - 1);
        $finish;
      end

      if (cycles > 3000) begin
        $display("ERROR: LFSR did not repeat within expected range!");
        $finish;
      end
    end
  end
  
  
  
  endmodule