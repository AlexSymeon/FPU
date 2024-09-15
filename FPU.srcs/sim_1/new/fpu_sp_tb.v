`timescale 1ns / 1ps

module fpu_sp_tb();

reg [31:0] a,b;
wire [31:0] result;


    wire [8:0] temp;
    wire [8:0] temp_r;
    wire [63:0] temp2;
    wire [63:0] temp3;
    wire [7:0] ripple_a,ripple_b;
    wire [31:0] vedic_a,vedic_b;
    reg exp_overflow;

    reg clk,start;

    wire nan_a, inf_a, zero_a, subnormal_a, normal_a;
    wire nan_b, inf_b, zero_b, subnormal_b, normal_b;
    wire nan_res, inf_res, zero_res, subnormal_res, normal_res;


fpu_sp UUT(a,b,clk,start,result,ripple_a,ripple_b,vedic_a,vedic_b,temp,temp_r,temp2,temp3,pos,nan_a, inf_a, zero_a, subnormal_a, normal_a,nan_b, inf_b, zero_b, subnormal_b, normal_b,nan_res, inf_res, zero_res, subnormal_res, normal_res);

initial begin
    #10;
    clk = 0;
    start = 0;
    exp_overflow = 0;
end

always #5 clk = ~clk;

// always #50 start = ~start;

integer i,j;

initial
    begin
        for (i = 0; i < 100; i = i + 1)
            begin
                for (j = 0; j < 100; j = j + 1)
                    begin
                        start = 1;
                        a = $urandom();
                        b = $urandom();
                        #5;
                        start = 0;
                        #320;
                        if (temp_r[8] == 1) begin
                            exp_overflow = 1; 
                            #1;
                            exp_overflow = 0;
                        end
            end
        $stop;
    end
end

endmodule
