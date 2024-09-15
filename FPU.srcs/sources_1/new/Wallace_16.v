`timescale 1ns / 1ps

module Wallace_16(
input wire [15:0] a,b,
output [31:0] result,
wire [7:0] Pa,Pb,Qa,Qb,Ra,Rb,Sa,Sb,
wire [15:0] tempP,tempQ,tempR,tempS,temp1,temp2,temp3,
wire cout1,cout2,cout3
    );

assign Pa = a[7:0];
assign Pb = b[7:0];
assign Qa = a[15:8];
assign Qb = b[7:0];
assign Ra = a[7:0];
assign Rb = b[15:8];
assign Sa = a[15:8];
assign Sb = b[15:8];

Wallace_8x8 U1 (.a(Pa), .b(Pb), .result(tempP));
Wallace_8x8 U2 (.a(Qa), .b(Qb), .result(tempQ));
Wallace_8x8 U3 (.a(Ra), .b(Rb), .result(tempR));
Wallace_8x8 U4 (.a(Sa), .b(Sb), .result(tempS));


adder_16bits U5 (.a(tempQ), .b(tempR), .sum(temp1), .cout(cout1));
adder_16bits U6 (.a({8'b0,tempP[15:8]}), .b(temp1), .sum(temp2), .cout(cout2));
adder_16bits U7 (.a({7'b0,cout1,temp2[15:8]}), .b(tempS), .sum(temp3), .cout(cout3));

assign result = {temp3,temp2[7:0],tempP[7:0]};

   
endmodule

module adder_16bits(a,b,sum,cout);
    
input [15:0]a; 
input [15:0]b;
output [15:0]sum;
output cout;
   
wire [15:1] t;
genvar i;

half_adder h1(.a(a[0]), .b(b[0]), .sum(sum[0]), .carry(t[1]));

generate
    for (i=0; i < 14; i = i + 1) begin: L1
        full_adder FA_i (.a(a[i+1]), .b(b[i+1]), .cin(t[i+1]), .sum(sum[i+1]), .cout(t[i+2]));
    end
endgenerate

full_adder FF(.a(a[15]), .b(b[15]), .cin(t[15]), .sum(sum[15]), .cout(cout));


endmodule

