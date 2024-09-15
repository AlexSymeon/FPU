`timescale 1ns / 1ps

module Modified_Booth#(
parameter width = 4,
          counter_value = 4
)(
input   wire [width - 1 : 0] a,b,
input   wire start,clk,
output  wire [2*width - 1 : 0] result
);

reg [width - 1 : 0] A,Q,M;
reg C;
reg [width - 1 : 0] counter;
wire [width : 0] diff,sum;
reg valid;

	always @(posedge clk, posedge start) 
		begin 
			if (start) 
				begin 
					 A <= 4'b0;
					 M <= b; 
					 Q <= a; 
					 counter <= counter_value; 
					 valid <= 1'b0;
				end 
		   else 
				begin 
					 case (Q[0]) 
						1'b1 : begin
						       {C, A} = A + M;
						       {C,A,Q} = {1'b0,C,A,Q[width-1:1]};
                               end
						1'b0 : {C,A,Q} = {1'b0,C,A,Q[width-1:1]};
					 endcase 
					 counter <= counter + 1'b1; 
				 end
            valid = (&counter) ? 1'b1 : 1'b0; 
		 end 

assign result = {A,Q};

endmodule
