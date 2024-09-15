`timescale 1ns / 1ps

module Modified_Booth_tb#(
parameter width = 4,
          counter_value = 4
)
();

reg [width - 1: 0] a,b;
reg start,clk;
wire [2*width - 1: 0] result;
wire valid;
reg [width - 1 : 0] counter;


Modified_Booth UUT (a,b,start,clk,result,valid);


integer i,j,correct,error;

always #5 clk = ~clk;

initial
    begin
        correct = 0;
        error = 0;
		clk = 0;
		start = 0;
        a = 0;
		b = 0;
		#10
		
        for (i = 0; i < 100; i = i + 1)
            begin
                for (j = 0; j < 100; j = j + 1)
                    begin
                        start = 1;
                        a = $urandom();
                        b = $urandom();
                        #5;
                        start = 0;
                        #40;
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
