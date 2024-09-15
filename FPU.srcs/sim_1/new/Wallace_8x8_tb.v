`timescale 1ns / 1ps

module Wallace_8x8_tb();

reg [7:0] a,b;
wire [15:0] result;

Wallace_8x8 UUT(a,b,result);

integer i,j,correct,error;

initial begin
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
                        #100;
                        if (a * b == result)
                            correct = correct + 1;
                        else
                            error = error + 1;
                    end
            end
        $display("Number of correct operations: %d", correct);
        $display("Number of errors: %d", error);
        $stop;
    end

endmodule
