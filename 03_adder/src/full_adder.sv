//this code implements a one bit full adder 

module full_adder(
    input logic a,b,cin
    output logic cout,sum
);

//from full adder theory, we can define two additional internal variables
//generate and propagate
logic g, p;

//an always comb statement with blocking assignment. (it is executed in order)
//always @(a, b, cin) would have been equivalent, but there is the risk to miss some signals
//in the sensitivity list

always_comb
    begin
        p = a ^ b;
        g = a & b;
        sum = p ^ cin;
        cout = g|(p & cin);
    end

endmodule
