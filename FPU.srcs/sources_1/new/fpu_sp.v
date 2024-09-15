`timescale 1ns / 1ps

module fpu_sp(
    input [31:0]a,b,
    input clk,start,
    output [31:0]result,
    wire [7:0] ripple_a,
    wire [7:0] ripple_b,
    wire [31:0] vedic_a,
    wire [31:0] vedic_b,
    wire [8:0] temp,
    reg [8:0] temp_r,
    wire [63:0] temp2,
    wire [63:0] temp3,
    wire pos,
    output nan_a, inf_a, zero_a, subnormal_a, normal_a,
    output nan_b, inf_b, zero_b, subnormal_b, normal_b,
    output nan_res, inf_res, zero_res, subnormal_res, normal_res
    );
    
    assign ripple_a = a[30:23];
    assign ripple_b = b[30:23];
    
    assign vedic_a = {1'b1,a[22:0]};
    assign vedic_b = {1'b1,b[22:0]};
    
    
    sp_class U1 (.f(a), .nan(nan_a), .inf(inf_a), .zero(zero_a), .subnormal(subnormal_a), .normal(normal_a));
    sp_class U2 (.f(b), .nan(nan_b), .inf(inf_b), .zero(zero_b), .subnormal(subnormal_b), .normal(normal_b));
    
    Ripple_Carry_Adder_sp U3 (.a(ripple_a), .b(ripple_b), .s(temp[8:0]));
        

    always @* begin
        temp_r[8:0] = temp[8:0] - 8'b01111111;
    if (temp2[47] == 1) begin
        temp_r[8:0] = temp_r[8:0] + 1'b1;
    end
end
  
    // vedic_32x32 U4 (.a(vedic_a), .b(vedic_b), .result(temp2));
    // Modified_Booth #(.width(32),.counter_value(32)) U4 (.a(vedic_a), .b(vedic_b), .start(start), .clk(clk), .result(temp2));
    Wallace_64x64 U4 (.a(vedic_a), .b(vedic_b), .result(temp2));
    // Array_32x32 U4 (.a(vedic_a), .b(vedic_b), .c(temp2));

    msb_shift #(.N(64)) U5 (.data(temp2), .position(pos), .out(temp3));
        

    assign result = {a[31]^b[31],temp_r[7:0],temp3[62:40]};
    
    sp_class U6 (.f(result), .nan(nan_res), .inf(inf_res), .zero(zero_res), .subnormal(subnormal_res), .normal(normal_res));

    
endmodule
