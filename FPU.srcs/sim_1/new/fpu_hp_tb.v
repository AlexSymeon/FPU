`timescale 1ns / 1ps

module fpu_hp_tb();
    
reg [15:0] a,b;
wire [15:0] result;


    wire [5:0] temp;
    wire [5:0] temp_r;
    wire [31:0] temp2;
    wire [31:0] temp3;
    wire [4:0] ripple_a,ripple_b;
    wire [15:0] vedic_a,vedic_b;
    wire [10:0] seq_a,seq_b;
    reg exp_overflow;

    wire [4:0] pos;
    reg clk,start;

    wire nan_a, inf_a, zero_a, subnormal_a, normal_a;
    wire nan_b, inf_b, zero_b, subnormal_b, normal_b;

fpu_hp UUT(a,b,clk,start,result,ripple_a,ripple_b,vedic_a,vedic_b,seq_a,seq_b,temp,temp_r,temp2,temp3,pos,nan_a, inf_a, zero_a, subnormal_a, normal_a,nan_b, inf_b, zero_b, subnormal_b, normal_b);

initial begin
    clk = 0;
    start = 0;
    exp_overflow = 0;
end


always #5 clk = ~clk;


integer i,j;

initial
    begin
        for (i = 0; i < 100; i = i + 1)
            begin
                for (j = 0; j < 100; j = j + 1)
                    begin
                        a = $urandom();
                        b = $urandom();
                        start = 1;
                        #1;
                        start = 0;
                        if (temp_r[5] == 1) begin
                            exp_overflow = 1;
                            #1;
                            exp_overflow = 0;
                        end
                        #100;
            end
        $stop;
    end
end


endmodule
