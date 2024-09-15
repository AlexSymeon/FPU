`timescale 1ns / 1ps


module hp_class_tb();

reg [15:0] f;
wire nan, inf, zero, subnormal, normal;

integer i, n_nan, n_inf, n_zero, n_subnormal, n_normal;

initial 
    begin
        assign f = 0;
        n_nan = 0;
        n_inf = 0;
        n_zero = 0;
        n_subnormal = 0;
        n_normal = 0;
    end

initial
    begin
        for (i = 0; i < 65536; i = i + 1)
            begin
                #1 assign f = i;
                if ((nan & ~inf & ~zero & ~subnormal & ~normal) == 1)
                    n_nan = n_nan + 1;
                else if ((~nan & inf & ~zero & ~subnormal & ~normal) == 1)
                    n_inf = n_inf + 1;
                else if ((~nan & ~inf & zero & ~subnormal & ~normal) == 1)
                    n_zero = n_zero + 1;
                else if ((~nan & ~inf & ~zero & subnormal & ~normal) == 1)
                    n_subnormal = n_subnormal + 1;
                else if ((~nan & ~inf & ~zero & ~subnormal & normal) == 1)
                    n_normal = n_normal + 1;
                else
                    begin
                        $display("Error");
                        $stop;
                    end
            end
            
        begin
            $display("Number of NaN: %d", n_nan);
            $display("Number of Infinities: %d", n_inf);
            $display("Number of Zeroes: %d", n_zero);
            $display("Number of Subnormals: %d", n_subnormal);
            $display("Number of Normals: %d", n_normal);
            $display("Total: %d", n_nan+n_inf+n_zero+n_subnormal+n_normal);
         end
         
         #1;
         $stop;
    end

    hp_class UUT (f, nan, inf, zero, subnormal, normal);

endmodule
