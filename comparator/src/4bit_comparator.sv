//this module implements a four bit comparator circuit

//it compares two four bit input numbers a and b and check a=b, a<b or a>b

module fourBitComparator(
    input logic [3:0] a,b,
    output reg a_Eq_b, a_grt_b, a_less_b 
);


always_comb begin
    //initialize variables
    a_Eq_b = '0;
    a_grt_b = '0;
    a_less_b = '0;

    //compare values
    if (a == b)
        a_Eq_b = '1;
    else if (a > b)
        a_grt_b = '1;
    else
        a_less_b = '1;

end

endmodule