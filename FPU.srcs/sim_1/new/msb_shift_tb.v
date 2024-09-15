`timescale 1ns / 1ps

module msb_shift_tb#(parameter N = 32)();

reg [N-1:0] data;
wire [$clog2(N)-1:0] position;
wire [N-1:0] out;
integer i;

initial
    begin
        for (i = 0; i < 32; i = i + 1)
            begin
                data = i;
                #10;
            end
        $stop;
end

msb_shift UUT (data,position,out);

endmodule
