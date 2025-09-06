//test bench of the one bit full adder
`timescale 1ns/1ps

module tb;

//declare signals
logic a, b, cin;
logic cout, sum;

//istantiate dut
full_adder dut(
    .a(a), .b(b), .cin(cin),
    .cout(cout), .sum(sum)
);

initial begin

    $dumpfile("wave.vcd");   // for waveform viewing
    $dumpvars(0, tb); //with the same name of the module

    $display("=========START SIMULATION============");
    $display("======== INITIALIZING INPUT ======== ");

    //brute force try all combinations
    a = 0; b = 0; cin = 0; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 0; b = 0; cin = 1; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 0; b = 1; cin = 0; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 0; b = 1; cin = 1; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 1; b = 0; cin = 0; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 1; b = 0; cin = 1; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 1; b = 1; cin = 0; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);
    a = 1; b = 1; cin = 1; #10; $display("| %d | %d | %d | %d | %d |",a,b,cin,sum,cout);

    //check with nested loop
    for (int i=0; i<2; i = i+1) begin
        for (int j=0; j<2; j = j+1) begin
            for (int k=0; k<2; k = k+1) begin
            a=i; b=j; cin=k; #10;
            assert(sum === (a^b^cin)) else $error("%0d%0d%0d sum fail",i,j,k);
            assert(cout === (a & b)|(cin & (a ^ b))) else $error("%0d%0d%0d cout fail",i,j,k);
            end
        end
    end

    $finish;
end

endmodule
