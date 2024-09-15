`timescale 1ns / 1ps

module fpu_hp(
    input [15:0]a,b,
    input clk,start,
    output [15:0]result,
    wire [4:0] ripple_a,
    wire [4:0] ripple_b,
    wire [15:0] vedic_a,
    wire [15:0] vedic_b,
    wire [10:0] seq_a,
    wire [10:0] seq_b,
    wire [5:0] temp,
    reg [5:0] temp_r,
    wire [31:0] temp2,
    wire [31:0] temp3,
    wire [4:0] pos,
    output nan_a, inf_a, zero_a, subnormal_a, normal_a,
    output nan_b, inf_b, zero_b, subnormal_b, normal_b
    );
    
    assign ripple_a = a[14:10];
    assign ripple_b = b[14:10];
    
    assign vedic_a = {1'b1,a[9:0]};
    assign vedic_b = {1'b1,b[9:0]};
    
    assign seq_a = {1'b1,a[9:0]};
    assign seq_b = {1'b1,b[9:0]};

    hp_class U1 (.f(a), .nan(nan_a), .inf(inf_a), .zero(zero_a), .subnormal(subnormal_a), .normal(normal_a));
    hp_class U2 (.f(b), .nan(nan_b), .inf(inf_b), .zero(zero_b), .subnormal(subnormal_b), .normal(normal_b));
    
    Ripple_Carry_Adder U3  (.a(ripple_a), .b(ripple_b), .s(temp[5:0]));
  
          
always @* begin
        temp_r[5:0] = temp[5:0] - 6'b001111;
    //if (vedic_a[10] == 1 && vedic_b[10] == 1) begin
    if (temp2[21] == 1) begin
        temp_r[5:0] = temp_r[5:0] + 1'b1;
    end
end

    // vedic_16x16 U4 (.a(vedic_a), .b(vedic_b), .result(temp2));
    Modified_Booth #(.width(11),.counter_value(11)) U4 (.a(seq_a), .b(seq_b), .start(start), .clk(clk), .result(temp2));
    // Wallace_16 U4 (.a(vedic_a), .b(vedic_b), .result(temp2));
    // Array_16x16 U4 (.a(vedic_a), .b(vedic_b), .c(temp2)); 

    msb_shift #(.N(32)) U5 (.data(temp2), .position(pos), .out(temp3));
    
    
    assign result = {a[15]^b[15],temp_r[4:0],temp3[30:21]};
    
endmodule