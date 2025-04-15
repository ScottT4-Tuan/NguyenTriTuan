module address_generator(CLK25, enable, vsync, address);
   input         CLK25;
   input         enable;
   input         vsync;
   output [16:0] address;
   
   
   reg [16:0]    val;
   
   assign address = val;
   
   
   always_ff @(posedge CLK25)
	begin
         if (enable == 1'b1)
         begin
            if (val < 320 * 240)
               val <= val + 1;
         end
			
         if (vsync == 1'b0)
            val <= {17{1'b0}};
      end
   
endmodule
 