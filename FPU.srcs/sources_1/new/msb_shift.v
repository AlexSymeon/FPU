`timescale 1ns / 1ps


module msb_shift#(parameter N = 128)(
  input [N-1:0] data,
  output reg [$clog2(N)-1:0] position,
  output reg [N-1:0] out
);

integer i;
reg found;

  always @* begin
    position = -1;

    // Flag to indicate whether the leftmost '1' has been found    
    found = 0;

for (i = N-1; i >= 0; i = i - 1) begin
      if (data[i] == 1'b1 && !found) begin
        // Found the leftmost '1', update position and set the found flag
        position = i;
        found = 1;
      end
    end

    out = data << (N - position - 1);
    
 end



endmodule
