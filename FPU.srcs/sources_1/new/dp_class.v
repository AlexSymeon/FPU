`timescale 1ns / 1ps

module dp_class(f, nan, inf, zero, subnormal, normal);
    
    
input [63:0] f;
output nan, inf, zero, subnormal, normal;

wire expOnes, expZeroes, sigZeroes;

assign expOnes = &f[62:52];
assign expZeroes = ~|f[62:52];
assign sigZeroes = ~|f[51:0];

assign nan = expOnes & ~sigZeroes;
assign inf = expOnes & sigZeroes;
assign zero = expZeroes & sigZeroes;
assign subnormal = expZeroes & ~sigZeroes;
assign normal = ~expOnes & ~expZeroes;

    
endmodule
