`timescale 1ns / 1ps

module MSB_position_tb();

  reg [31:0] binary_array;
  wire [4:0] msb_position;

integer i;

initial
    begin
        for (i = 0; i < 32; i = i + 1)
            begin 
            binary_array = i;  
            end
        $stop;
    end

MSB_position UUT (binary_array,msb_position);

endmodule
