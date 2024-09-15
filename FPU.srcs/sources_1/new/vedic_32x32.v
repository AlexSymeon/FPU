`timescale 1ns / 1ps

module vedic_32x32(a,b,result);

input [31:0] a,b;
output [63:0] result;
wire [63:0] result;

wire [31:0] q0,q1,q2,q3,q4;
wire [31:0] temp1,temp2,temp3,temp4;

vedic_16x16 V13 (a[15:0],b[15:0],q0);
vedic_16x16 V14 (a[31:16],b[15:0],q1);
vedic_16x16 V15 (a[15:0],b[31:16],q2);
vedic_16x16 V16 (a[31:16],b[31:16],q3);

assign temp1 = {16'b0,q0[31:16]};
assign temp3 = q1 + q2;
assign q4 = temp3 + temp1;
assign temp4 = {16'b0,q4[31:16]} + q3; 

assign result[15:0] = q0[15:0];
assign result[31:16] = q4[15:0];
assign result[63:32] = temp4;

endmodule
