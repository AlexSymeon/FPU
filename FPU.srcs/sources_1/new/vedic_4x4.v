`timescale 1ns / 1ps

module vedic_4x4(a, b, result);

input [3:0] a,b;
output [7:0] result;
wire [7:0] result;

wire w1,w2,w3,w4,w5;
wire [3:0] temp1;
wire [5:0] temp2,temp3,temp4;
wire [3:0] q0,q1,q2,q3,q4;
wire [5:0] q5,q6;

vedic_2x2 V1(a[1:0], b[1:0], q0[3:0]);
vedic_2x2 V2(a[3:2], b[1:0], q1[3:0]);
vedic_2x2 V3(a[1:0], b[3:2], q2[3:0]);
vedic_2x2 V4(a[3:2], b[3:2], q3[3:0]);

assign temp1= {2'b00, q0[3:2]};
assign q4 = q1 + temp1;

assign temp2= {2'b00, q2[3:0]};
assign temp3= {q3[3:0], 2'b00};
assign q5 = temp2 + temp3;

assign temp4= {2'b00, q4[3:0]};
assign q6 = temp4 + q5;

assign result[1:0] = q0[1:0];
assign result[7:2] = q6[5:0];

endmodule
