`timescale 1ns / 1ps


module Wallace_16bits_tb();

reg [15:0] a,b;
wire [31:0] result;

wire [7:0] Pa,Pb,Qa,Qb,Ra,Rb,Sa,Sb;
wire [15:0] tempP,tempQ,tempR,tempS,temp3,temp2,temp1;

Wallace_16 UUT(a,b,result,Pa,Pb,Qa,Qb,Ra,Rb,Sa,Sb,tempP,tempQ,tempR,tempS,temp1,temp2,temp3);

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
