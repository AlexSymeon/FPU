`timescale 1ns / 1ps

module Array_2x2(a,b,c);

input [1:0] a,b;
output [3:0]c;
wire [3:0] c;
wire [3:0] temp;

    assign c[0]=a[0]&b[0];
    assign temp[0]=a[1]&b[0];
    assign temp[1]=a[0]&b[1];
    assign temp[2]=a[1]&b[1];
    half_adder U1 (.a(temp[0]),.b(temp[1]),.sum(c[1]),.carry(temp[3]));
    half_adder U2 (.a(temp[2]),.b(temp[3]),.sum(c[2]),.carry(c[3]));
    
endmodule

module Array_4x4(a,b,c);

input [3:0]a, b;
output [7:0]c;
     
    wire [3:0]q0,q1,q2,q3,q4,temp1;
     
    wire [7:0]c;
    wire [5:0]q5,q6,temp2,temp3,temp4;
     
    Array_2x2 U1 (a[1:0],b[1:0],q0[3:0]);
    Array_2x2 U2 (a[3:2],b[1:0],q1[3:0]);
    Array_2x2 U3 (a[1:0],b[3:2],q2[3:0]);
    Array_2x2 U4 (a[3:2],b[3:2],q3[3:0]);
     
    assign temp1 ={2'b0,q0[3:2]};
    assign q4 = q1[3:0]+temp1;
    assign temp2 ={2'b0,q2[3:0]};
    assign temp3 ={q3[3:0],2'b0};
    assign q5 = temp2+temp3;
    assign temp4={2'b0,q4[3:0]};
    assign q6 = temp4+q5;
     
    assign c[1:0] = q0[1:0];
    assign c[7:2] = q6[5:0];
    
endmodule

module Array_8x8(a,b,c);
    input [7:0]a,b;
    output [15:0]c;
     
    wire [15:0]c;
    wire [7:0]q0,q1,q2,q3,q4,temp1;
    wire [11:0]q5,q6,temp2,temp3,temp4;
     
    Array_4x4 U1(a[3:0],b[3:0],q0[7:0]);
    Array_4x4 U2(a[7:4],b[3:0],q1[7:0]);
    Array_4x4 U3(a[3:0],b[7:4],q2[7:0]);
    Array_4x4 U4(a[7:4],b[7:4],q3[7:0]);
     
    assign temp1 ={4'b0,q0[7:4]};
    assign q4 = q1[7:0]+temp1;
    assign temp2 ={4'b0,q2[7:0]};
    assign temp3 ={q3[7:0],4'b0};
    assign q5 = temp2+temp3;
    assign temp4={4'b0,q4[7:0]};
     
    
    assign q6 = temp4+q5;
     
    assign c[3:0]=q0[3:0];
    assign c[15:4]=q6[11:0];
endmodule

module Array_16x16(a,b,c);
 
    input [15:0]a,b;
    output [31:0]c;
     
    wire [15:0]q0,q1,q2,q3,q4,temp1;
    wire [31:0]c;
    wire [23:0]q5,q6,temp2,temp3,temp4;
     
    Array_8x8 U1(a[7:0],b[7:0],q0[15:0]);
    Array_8x8 U2(a[15:8],b[7:0],q1[15:0]);
    Array_8x8 U3(a[7:0],b[15:8],q2[15:0]);
    Array_8x8 U4(a[15:8],b[15:8],q3[15:0]);
    assign temp1 ={8'b0,q0[15:8]};
    assign q4 = q1[15:0]+temp1;
    assign temp2 ={8'b0,q2[15:0]};
    assign temp3 ={q3[15:0],8'b0};
    assign q5 = temp2+temp3;
    assign temp4={8'b0,q4[15:0]};
     
    assign q6 = temp4 + q5;
     
    assign c[7:0]=q0[7:0];
    assign c[31:8]=q6[23:0];
 
endmodule

module Array_32x32(a,b,c);
 
    input [31:0]a,b;
    output [63:0]c;
     
    wire [31:0]q0,q1,q2,q3,q4,temp1;
    wire [63:0]c;
    wire [47:0]q5,q6,temp2,temp3,temp4;
     
    Array_16x16 U1(a[15:0],b[15:0],q0[31:0]);
    Array_16x16 U2(a[31:16],b[15:0],q1[31:0]);
    Array_16x16 U3(a[15:0],b[31:16],q2[31:0]);
    Array_16x16 U4(a[31:16],b[31:16],q3[31:0]);
    assign temp1 ={16'b0,q0[31:16]};
    assign q4 = q1[31:0]+temp1;
    assign temp2 ={16'b0,q2[31:0]};
    assign temp3 ={q3[31:0],16'b0};
    assign q5 = temp2+temp3;
    assign temp4={16'b0,q4[31:0]};
     
    assign q6 = temp4 + q5;
     
    assign c[15:0]=q0[15:0];
    assign c[63:16]=q6[47:0];
 
endmodule

module Array_64x64(a,b,c);
 
    input [63:0]a,b;
    output [127:0]c;
     
    wire [63:0]q0,q1,q2,q3,q4,temp1;
    wire [127:0]c;
    wire [96:0]q5,q6,temp2,temp3,temp4;
     
    Array_32x32 U1(a[31:0],b[31:0],q0[63:0]);
    Array_32x32 U2(a[63:32],b[31:0],q1[63:0]);
    Array_32x32 U3(a[31:0],b[63:32],q2[63:0]);
    Array_32x32 U4(a[63:32],b[63:32],q3[63:0]);
    assign temp1 ={32'b0,q0[63:32]};
    assign q4 = q1[63:0]+temp1;
    assign temp2 ={32'b0,q2[63:0]};
    assign temp3 ={q3[63:0],32'b0};
    assign q5 = temp2+temp3;
    assign temp4={32'b0,q4[63:0]};
     
    assign q6 = temp4 + q5;
     
    assign c[31:0]=q0[31:0];
    assign c[127:32]=q6[96:0];
 
endmodule