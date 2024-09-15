`timescale 1ns / 1ps

module SeqMultiplier_tb#(
parameter width = 32,
          counter_value = 32
)();

reg [width - 1: 0] a,b;
reg start;
wire [2*width - 1: 0] result;

SeqMultiplier UUT(a,b,start,result);

    
integer i,j,correct,error;

initial
    begin
        correct = 0;
        error = 0;
        start = 1;
        #1;
        start = 0;
        #1;
        start = 1;
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
                        start = 0;
                        #10;
                        start = 1;
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
