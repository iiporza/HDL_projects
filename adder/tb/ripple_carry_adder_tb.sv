//this module implements a test bench for the ripple carry address
`timescale 1ns/1ps
module tb_ripple;

//declare signals
parameter n = 4;
logic [n-1:0] a,b,sum;
logic cout;
logic [n:0] expected;

//instantiate dut
ripple_carry_adder dut(
    .a(a), .b(b), .sum(sum), .cout(cout)
);

initial begin

    $dumpfile("wave_ripple.vcd");   // for waveform viewing
    $dumpvars(0, tb_ripple); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");
    expected = '0;
    a = '0;
    b = '0;
    #10;

    $monitor("a = %4b | b = %4b | cout = %1b | sum = %4b",a,b,cout,sum);

    for (int i = 0; i < 25; i = i + 1) begin
        #10
        a = $urandom_range(0,2**n -1);
        b = $urandom_range(0,2**n -1);      
        #1;
        expected = a + b;
        assert({cout, sum} == expected) else $error("Mismatch %0d + %0d = %0d fail",a,b,sum);
    end

    $finish;
end

endmodule
