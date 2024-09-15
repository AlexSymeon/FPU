`timescale 1ns / 1ps

module Ripple_Carry_Adder_sp_tb();
    
reg [7:0] a,b;
wire [8:0] s;

integer i,j,correct,error;

initial
    begin
        correct = 0;
        error = 0;
    end

initial
    begin
        for (i = 0; i < 256; i = i + 1)
            begin
                for (j = 0; j < 256; j = j + 1)
                    begin
                        a = i;
                        b = j;
                        #10;
                        if (a + b == s)
                            correct = correct + 1;
                        else    
                            error = error + 1;
                    end
            end
        $display("Number of correct operations: %d", correct);
        $display("Number of errors: %d", error);
        $stop;
    end

Ripple_Carry_Adder_sp UUT (a,b,s);

endmodule
