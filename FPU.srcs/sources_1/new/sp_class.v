`timescale 1ns / 1ps


module sp_class(f, nan, inf, zero, subnormal, normal);
    

input [31:0] f;
output nan, inf, zero, subnormal, normal;

wire expOnes, expZeroes, sigZeroes;

assign expOnes = &f[30:23];
assign expZeroes = ~|f[30:23];
assign sigZeroes = ~|f[22:0];

assign nan = expOnes & ~sigZeroes;
assign inf = expOnes & sigZeroes;
assign zero = expZeroes & sigZeroes;
assign subnormal = expZeroes & ~sigZeroes;
assign normal = ~expOnes & ~expZeroes;

    
endmodule
