`timescale 1ns / 1ps

module hp_class(f, nan, inf, zero, subnormal, normal);

input [15:0] f;
output nan, inf, zero, subnormal, normal;

wire expOnes, expZeroes, sigZeroes;

assign expOnes = &f[14:10];
assign expZeroes = ~|f[14:10];
assign sigZeroes = ~|f[9:0];

assign nan = expOnes & ~sigZeroes;
assign inf = expOnes & sigZeroes;
assign zero = expZeroes & sigZeroes;
assign subnormal = expZeroes & ~sigZeroes;
assign normal = ~expOnes & ~expZeroes;

endmodule
