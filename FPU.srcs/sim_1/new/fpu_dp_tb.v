`timescale 1ns / 1ps

module fpu_dp_tb();

reg [63:0] a,b;
wire [63:0] result;


    wire [11:0] temp;
    wire [11:0] temp_r;
    wire [127:0] temp2;
    wire [127:0] temp3;
    wire [10:0] ripple_a,ripple_b;
    wire [63:0] vedic_a,vedic_b;
    reg exp_overflow;

    reg clk,start;

    wire nan_a, inf_a, zero_a, subnormal_a, normal_a;
    wire nan_b, inf_b, zero_b, subnormal_b, normal_b;


fpu_dp UUT(a,b,clk,start,result,ripple_a,ripple_b,vedic_a,vedic_b,temp,temp_r,temp2,temp3,pos,nan_a, inf_a, zero_a, subnormal_a, normal_a,nan_b, inf_b, zero_b, subnormal_b, normal_b);

initial begin
    clk = 0;
    start = 0;
    #1;
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
                        start = 1;
                        a[31:0] = $urandom();
                        a[63:32] = $urandom();
                        b[31:0] = $urandom();
                        b[63:32] = $urandom();
                        #5;
                        start = 0;
                        #640;
                        if (temp_r[11] == 1) begin
                            exp_overflow = 1; 
                            #1;
                            exp_overflow = 0;
                        end
            end
        $stop;
    end
end


endmodule
