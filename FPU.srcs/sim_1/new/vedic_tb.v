`timescale 1ns / 1ps

module vedic_tb();

reg [63:0] a,b;
wire [127:0] result;

vedic_64x64 V0(a,b,result);

integer i,j,correct,error;

initial
    begin
        correct = 0;
        error = 0;
    end

initial
    begin
        for (i = 0; i < 100; i = i + 1)
            begin
                for (j = 0; j < 100; j = j + 1)
                    begin
                        a = $urandom();
                        b = $urandom();
                        #10;
                        if (a * b == result)
                            correct = correct + 1;
                        else    
                            error = error + 1;
                            $monitor("a=%d, b=%d", a, b);
                    end
            end
        $display("Number of correct operations: %d", correct);
        $display("Number of errors: %d", error);
        $stop;
    end


endmodule
