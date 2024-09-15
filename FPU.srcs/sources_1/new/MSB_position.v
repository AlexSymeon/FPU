`timescale 1ns / 1ps

module MSB_position(
  input wire [31:0] binary_array,
  output reg [4:0] msb_position
);

integer i;
  
initial begin
    // Iterate through the array from left to right
    for (i = 0; i < 32; i = i + 1) begin
      if (binary_array[i] == 1'b1) begin
        // Set the position of the MSB found
        msb_position = i;
        break; // Exit the loop once the MSB is found
      end
    end
end

endmodule