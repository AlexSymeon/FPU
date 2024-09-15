`timescale 1ns / 1ps

module adder_64bits(a,b,sum,cout);
    
input [63:0]a; 
input [63:0]b;
output [63:0]sum;
output cout;
   
wire [63:1] t;
genvar i;

half_adder h1(.a(a[0]), .b(b[0]), .sum(sum[0]), .carry(t[1]));

generate
    for (i=0; i < 62; i = i + 1) begin: L1
        full_adder FA_i (.a(a[i+1]), .b(b[i+1]), .cin(t[i+1]), .sum(sum[i+1]), .cout(t[i+2]));
    end
endgenerate

full_adder FF(.a(a[63]), .b(b[63]), .cin(t[63]), .sum(sum[63]), .cout(cout));


endmodule
