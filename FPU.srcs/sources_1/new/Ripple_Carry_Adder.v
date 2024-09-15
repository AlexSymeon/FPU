`timescale 1ns / 1ps



module full_adder(
    input a,b,cin,
    output sum,cout
    );

    wire c, c1, s;
    
    half_adder ha0(a,b,s,c);
    half_adder ha1(cin,s,sum,c1);

    assign cout = c | c1 ;

endmodule

module Ripple_Carry_Adder(
    input [4:0] a,
    input [4:0] b,
    output [5:0] s
    );

    wire cout0,cout1,cout2,cout3;
    full_adder
        fa0(.a(a[0]), .b(b[0]), .cin(1'b0), .sum(s[0]), .cout(cout0)),
        fa1(.a(a[1]), .b(b[1]), .cin(cout0), .sum(s[1]), .cout(cout1)),
        fa2(.a(a[2]), .b(b[2]), .cin(cout1), .sum(s[2]), .cout(cout2)),
        fa3(.a(a[3]), .b(b[3]), .cin(cout2), .sum(s[3]), .cout(cout3)),
        fa4(.a(a[4]), .b(b[4]), .cin(cout3), .sum(s[4]), .cout(s[5]));

endmodule

