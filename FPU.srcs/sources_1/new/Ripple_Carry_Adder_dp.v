`timescale 1ns / 1ps


module Ripple_Carry_Adder_dp(
    input [10:0] a,
    input [10:0] b,
    output [11:0] s
    );
            
            wire cout0,cout1,cout2,cout3,cout4,cout5,cout6,cout7,cout8,cout9,cout10,cout11;
    full_adder
        fa0(.a(a[0]), .b(b[0]), .cin(0), .sum(s[0]), .cout(cout0)),
        fa1(.a(a[1]), .b(b[1]), .cin(cout0), .sum(s[1]), .cout(cout1)),
        fa2(.a(a[2]), .b(b[2]), .cin(cout1), .sum(s[2]), .cout(cout2)),
        fa3(.a(a[3]), .b(b[3]), .cin(cout2), .sum(s[3]), .cout(cout3)),
        fa4(.a(a[4]), .b(b[4]), .cin(cout3), .sum(s[4]), .cout(cout4)),
        fa5(.a(a[5]), .b(b[5]), .cin(cout4), .sum(s[5]), .cout(cout5)),
        fa6(.a(a[6]), .b(b[6]), .cin(cout5), .sum(s[6]), .cout(cout6)),
        fa7(.a(a[7]), .b(b[7]), .cin(cout6), .sum(s[7]), .cout(cout7)),
        fa8(.a(a[8]), .b(b[8]), .cin(cout7), .sum(s[8]), .cout(cout8)),
        fa9(.a(a[9]), .b(b[9]), .cin(cout8), .sum(s[9]), .cout(cout9)),
        fa10(.a(a[10]), .b(b[10]), .cin(cout9), .sum(s[10]), .cout(s[11]));
    
endmodule
