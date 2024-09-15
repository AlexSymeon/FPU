`timescale 1ns / 1ps

module Booth #(
    parameter width = 4,
              counter_value = 4
)
(
input   wire [width - 1 : 0] a,b,
input   wire start,clk,
output  wire [2*width - 1 : 0] result,
output reg valid
);

reg [width - 1 : 0] AC,Q,M;
reg  Qn;
reg [width - 1 : 0] counter;
wire [width - 1 : 0] diff,sum;


	always @(posedge clk, posedge start) 
		begin 
			if (start) 
				begin 
					 AC <= 8'b0;
					 M <= b; 
					 Q <= a; 
					 Qn <= 1'b0; 
					 counter <= counter_value; 
					 valid <= 1'b0;
				end 
		   else 
				begin 
					 case ({Q[0], Qn}) 
						2'b0_1 : {AC, Q, Qn} <= {sum[width - 1], sum, Q}; 
						2'b1_0 : {AC, Q, Qn} <= {diff[width - 1], diff, Q};
						default: {AC, Q, Qn} <= {AC[width - 1], AC, Q}; 
					 endcase 
					 counter <= counter + 1'b1; 
				 end
            valid = (&counter) ? 1'b1 : 1'b0; 
		 end 

assign diff = AC + ~M + 1'b1;
assign sum = AC + M;

assign result = {AC,Q};

endmodule
