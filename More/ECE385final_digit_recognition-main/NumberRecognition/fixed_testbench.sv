module fixed_testbench();
    reg signed [7:0] a, b, c;
    reg signed [15:0] ab;  // large enough for product

    localparam sf = 2.0**-4.0;  // Q4.4 scaling factor is 2^-4

    initial begin
        $display("Fixed Point Examples from projectf.io.");

        a = 8'b0011_1010;  // 3.6250
        b = 8'b0100_0001;  // 4.0625
        c = a + b;         // 0111.1011 = 7.6875 should be 14.7265625
        $display("%f + %f = %f", $itor(a)*sf, $itor(b)*sf, $itor(c)*sf);

        a = 8'b0011_1010;  // 3.6250
        b = 8'b1110_1000;  // -1.5000
        c = a + b;         // 0010.0010 = 2.1250
        $display("%f + %f = %f", $itor(a)*sf, $itor(b)*sf, $itor(c)*sf);

        a = 8'b0011_0100;  // 3.2500
        b = 8'b0010_0001;  // 2.0625
        ab = a * b;        // 00000110.10110100 = 6.703125
        c = ab[11:4];      // take middle 8 bits: 0110.1011 = 6.6875
        $display("%f x %f = %f", $itor(a)*sf, $itor(b)*sf, $itor(c)*sf);

        a = 8'b0111_1000;  // 7.5000
        b = 8'b0000_1000;  // 0.5000
        ab = a * b;        // 00000011.11000000 = 3.7500
        c = ab[11:4];      // take middle 8 bits: 0011.1100 = 3.7500
        $display("%f x %f = %f", $itor(a)*sf, $itor(b)*sf, $itor(c)*sf);
		  
		  
		  // 这样不会被解释为fixed-point ！！！！ 一定只能对半分
		  a = 8'b01_111000;  // 1.8750
        b = 8'b00_001000;  // 0.1250
        ab = a * b;        // 0001.000111000000 = 1.109375
        c = ab[13:6];      // take bits: 01.000111 = 
        $display("%f x %f = %f", $itor(a)*sf, $itor(b)*sf, $itor(c)*sf);
    end
endmodule