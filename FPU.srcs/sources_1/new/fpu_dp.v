`timescale 1ns / 1ps

module fpu_dp(
    input [63:0]a,b,
    input clk,start,
    output [63:0]result,
    wire [10:0] ripple_a,
    wire [10:0] ripple_b,
    wire [63:0] vedic_a,
    wire [63:0] vedic_b,
    wire [11:0] temp,
    reg [11:0] temp_r,
    wire [127:0] temp2,
    wire [127:0] temp3,
    wire pos,
    output nan_a, inf_a, zero_a, subnormal_a, normal_a,
    output nan_b, inf_b, zero_b, subnormal_b, normal_b
    );
    
    
    assign ripple_a = a[62:52];
    assign ripple_b = b[62:52];
    
    assign vedic_a = {1'b1,a[51:0]};
    assign vedic_b = {1'b1,b[51:0]};
    
    dp_class U1 (.f(a), .nan(nan_a), .inf(inf_a), .zero(zero_a), .subnormal(subnormal_a), .normal(normal_a));
    dp_class U2 (.f(b), .nan(nan_b), .inf(inf_b), .zero(zero_b), .subnormal(subnormal_b), .normal(normal_b));
    
    Ripple_Carry_Adder_dp U3 (.a(ripple_a), .b(ripple_b), .s(temp));

    always @* begin
        temp_r[11:0] = temp[11:0] - 11'b01111111111;
        if (temp2[105] == 1) begin
            temp_r[11:0] = temp_r[11:0] + 1'b1;
        end
    end

    // vedic_64x64 U4 (.a(vedic_a), .b(vedic_b), .result(temp2));
    // Modified_Booth #(.width(64),.counter_value(64)) U4 (.a(vedic_a), .b(vedic_b), .start(start), .clk(clk), .result(temp2));
    Wallace_128 U4 (.a(vedic_a), .b(vedic_b), .result(temp2));
    // Array_64x64 U4 (.a(vedic_a), .b(vedic_b), .c(temp2));

    msb_shift U5 (.data(temp2), .position(pos), .out(temp3));
    
    assign result = {a[63]^b[63],temp_r[10:0],temp3[126:75]};

    
endmodule
