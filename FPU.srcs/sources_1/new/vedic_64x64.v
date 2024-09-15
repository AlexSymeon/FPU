`timescale 1ns / 1ps

module vedic_64x64(a,b,result);

input [63:0] a,b;
output [127:0] result;
wire [127:0] result;


wire [63:0] q0,q1,q2,q3,q4;
wire [63:0] temp1,temp2,temp3,temp4;

vedic_32x32 V1 (a[31:0],b[31:0],q0);
vedic_32x32 V2 (a[31:0],b[63:32],q1);
vedic_32x32 V3 (a[63:32],b[31:0],q2);
vedic_32x32 V4 (a[63:32],b[63:32],q3);

assign temp1 = {32'b0,q0[63:32]};
assign temp3 = q1 + q2;
assign q4 = temp3 + temp1;
assign temp4 = {31'b0,q4[63:32]} + q3;

assign result[31:0] = q0[31:0];
assign result[63:32] = q4[31:0];
assign result[127:64] = temp4;


endmodule
