`timescale 1ns / 1ps

module SeqMultiplier #(
parameter width = 16,
          counter_value = 16
)
(
input   wire [width - 1 : 0] a,b,
input   wire start,
output  wire [2*width - 1 : 0] result
);

reg [2*width : 0] Result;
reg [width - 1 : 0] counter;

always @(posedge start) begin

    Result[2*width - 1 : width] = 8'b00000000;
    Result[width - 1 : 0] = b;
    counter = counter_value;

        while (counter) begin

            if (Result[0] == 1'b0) begin

                Result = {Result[2*width], Result[2*width - 1 : 1]};
                counter = counter - 1;

            end 

            else begin 
                
                Result[2*width : width] = Result[2*width - 1 : width] + a;
                Result = {Result[2*width], Result[2*width - 1 : 1]};
                //Result = {a[width - 1], (a + Result[2*width - 1 : width]), Result[width - 1 : 1]};
                counter = counter - 1;
                    
            end
            
        end
    end

assign result = Result[2*width - 1 : 0];

endmodule
