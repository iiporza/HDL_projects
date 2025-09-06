//this module implements a test bench for the ripple carry address
`timescale 1ns/1ps

module tb_addsub;

//declare signals
parameter n = 4;
logic [n-1:0] a, b, sum;
logic         cout;
logic         sub;
logic [n:0]   expected;   // n+1-bit expected {carry,sum}
logic [n:0]   temp;

//instantiate dut
adder_subtractor dut(
    .a(a), .b(b), .sub(sub), .sum(sum), .cout(cout)
);

initial begin

    $dumpfile("wave_sub.vcd");   // for waveform viewing
    $dumpvars(0, tb_addsub); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");
    expected = '0;
    a = '0;
    b = '0;
    sub = 0;
    temp = '0;
    #10;

   $monitor("a=0x%0h(%2d) | b=0x%0h(%2d) | sub=%b -> {cout,sum}=0x%2h(%2d)", a, a, b, b, sub, temp, temp);

    for (int i = 0; i < 32; i = i + 1) begin
        #10;
        a   = $urandom_range(0, 2**n - 1);
        b   = $urandom_range(0, 2**n - 1);
        sub = $urandom_range(0, 1);
        #1; // allow combinational settle

        temp = {cout, sum};

        // Expected n+1-bit result using pure bit-vector math
        expected = {1'b0, a} + (sub ? {1'b0, ~b} : {1'b0, b}) + sub;

        // Check both the full vector and individual pieces
        assert ({cout, sum} === expected)
          else $error("Mismatch: a=%0d b=%0d sub=%0b -> DUT {cout,sum}=%0d expected=%0d",
                       a, b, sub, {cout, sum}, expected);
        assert (sum  === expected[n-1:0]) else $error("Sum mismatch only");
        assert (cout === expected[n])     else $error("Carry/borrow flag mismatch");
    end

    $finish;
end

endmodule
