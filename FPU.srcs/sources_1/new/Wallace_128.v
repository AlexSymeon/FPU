`timescale 1ns / 1ps

module Wallace_128(
input wire [63:0] a,b,
output [127:0] result,
wire [31:0] Pa,Pb,Qa,Qb,Ra,Rb,Sa,Sb,
wire [63:0] tempP,tempQ,tempR,tempS,temp1,temp2,temp3,
wire cout1,cout2,cout3
    );

assign Pa = a[31:0];
assign Pb = b[31:0];
assign Qa = a[63:32];
assign Qb = b[31:0];
assign Ra = a[31:0];
assign Rb = b[63:32];
assign Sa = a[63:32];
assign Sb = b[63:32];

Wallace_64x64 U1 (.a(Pa), .b(Pb), .result(tempP[63:0]));
Wallace_64x64 U2 (.a(Qa), .b(Qb), .result(tempQ));
Wallace_64x64 U3 (.a(Ra), .b(Rb), .result(tempR));
Wallace_64x64 U4 (.a(Sa), .b(Sb), .result(tempS));

adder_64bits U5 (.a(tempQ), .b(tempR), .sum(temp1), .cout(cout1));
adder_64bits U6 (.a({32'b0,tempP[63:32]}), .b(temp1), .sum(temp2), .cout(cout2));
adder_64bits U7 (.a({31'b0,cout1,temp2[63:32]}), .b(tempS), .sum(temp3), .cout(cout3));

assign result = {temp3,temp2[31:0],tempP[31:0]};

endmodule
