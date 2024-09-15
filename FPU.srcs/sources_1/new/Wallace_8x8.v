`timescale 1ns / 1ps

module Wallace_8x8(
input wire [7:0] a,b,
output [15:0] result
);

wire [63:0] pp;
wire [62:0] c;
wire [52:0] s;
wire carry;

genvar i,j;
generate
    for (i=0; i < 8; i = i + 1) begin
        for (j=0; j < 8; j = j + 1) begin
            assign pp[8*i+j] = a[i] & b[j];
        end
    end
endgenerate

//Level 1 - Stage 1
half_adder HA1 (pp[1],pp[8],s[0],c[0]);

generate
    for (i=0; i < 6; i = i + 1) begin: L1_S1
        full_adder FAi_L1_S1 (pp[2+i],pp[9+i],pp[16+i],s[i+1],c[i+1]);
    end
endgenerate

half_adder HA2 (pp[15],pp[22],s[7],c[7]);


//Level 1 - Stage 2
half_adder HA3 (pp[25],pp[32],s[8],c[8]);

generate
    for (i=0; i < 6; i = i + 1) begin: L1_S2
        full_adder FAi_L1_S2 (pp[26+i],pp[33+i],pp[40+i],s[i+9],c[i+9]);
    end
endgenerate

half_adder HA4 (pp[39],pp[46],s[15],c[15]);


//Level 2 - Stage 1
half_adder HA5 (s[1],c[0],s[16],c[16]);

full_adder FA11_L2 (s[2],c[1],pp[24],s[17],c[17]);

generate
    for (i=0; i < 5; i = i + 1) begin: L2_S1
        full_adder FAi_L2_S1 (s[3+i],c[2+i],s[8+i],s[i+18],c[i+18]);
    end
endgenerate

full_adder FA22_L2 (pp[23],c[7],s[13],s[23],c[23]);


//Level 2 - Stage 2
half_adder HA6 (c[9],pp[48],s[24],c[24]);

generate
    for (i=0; i < 6; i = i + 1) begin: L2_S2
        full_adder FAi_L2_S2 (c[10+i],pp[49+i],pp[56+i],s[i+25],c[i+25]);
    end
endgenerate

half_adder HA7 (pp[55],pp[62],s[31],c[31]);


//Level 3 - Stage 1
half_adder HA8 (s[17],c[16],s[32],c[32]);
half_adder HA9 (s[18],c[17],s[33],c[33]);

full_adder FA11_L3 (s[19],c[18],c[8],s[34],c[34]);

generate
    for (i=0; i < 4; i = i + 1) begin: L3_S1
        full_adder FAi_L3_S1 (s[20+i],c[19+i],s[24+i],s[i+35],c[i+35]);
    end
endgenerate

full_adder FA22_L3 (s[14],c[23],s[28],s[39],c[39]);

half_adder HA10 (s[15],s[29],s[40],c[40]);
half_adder HA11 (pp[47],s[30],s[41],c[41]);


//Level 4 - Stage 1
assign result[0] = pp[0];
assign result[1] = s[0];
assign result[2] = s[16];
assign result[3] = s[32];

generate
    for (i=0; i < 3; i = i + 1) begin: HA_L4_S1
        half_adder HAi_L4_S1 (s[33+i],c[32+i],s[42+i],c[i+42]);
    end
endgenerate

generate
    for (i=0; i < 6; i = i + 1) begin: L4_S1
        full_adder FAi_L4_S1 (c[24+i],s[36+i],c[35+i],s[i+45],c[i+45]);
    end
endgenerate

full_adder FA11_L4 (c[30],s[31],c[41],s[51],c[51]);
half_adder HA12 (pp[63],c[31],s[52],c[52]);


//Level 5 - Stage 1
assign result[4] = s[42];

half_adder HA13 (s[43],c[42],result[5],c[53]);

generate
    for (i=0; i < 9; i = i + 1) begin: L5_S1
        full_adder FAi_L5_S1 (s[44+i],c[43+i],c[53+i],result[i+6],c[i+54]);
    end
endgenerate

half_adder HA14 (c[52],c[62],result[15],carry);

endmodule
