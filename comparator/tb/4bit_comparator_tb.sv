//testbench for 4 bit comparator

module comp_4bit_tb();

//declare signals
logic [3:0] a,b;
reg a_Eq_b, a_grt_b, a_less_b ;

//instantiate dut
fourBitComparator dut(
    .a(a), .b(b), .a_Eq_b(a_Eq_b), .a_grt_b(a_grt_b), .a_less_b(a_less_b)
    );

initial begin
    $dumpfile("comp.vcd");   // for waveform viewing
    $dumpvars(0, comp_4bit_tb); //with the same name of the module

    $display("=========initialize variables==========");
    a = '0;
    b = '0;
    #(10);

    $monitor("a = %4b | b = %4b | a_Eq_b = %b | a_grt_b = %b | a_less_b = %b", a,b,a_Eq_b,a_grt_b,a_less_b);

    for(int i = 0; i < 25; i = i + 1) begin
        #(5);
        a = $random;
        b = $random;
        #(5);
    end

    $finish;

end

endmodule