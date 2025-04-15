module ov7670_capture(
   input         pclk,
   input         vsync,
   input         href,
   input [7:0]   d,
   output [16:0] addr,
   output [15:0] dout,
   output        we
);
   
   
   reg [15:0]    d_latch;
   reg [16:0]    address;
   reg [1:0]     line;
   reg [6:0]     href_last;
   reg           we_reg;
   reg           href_hold;
   reg           latched_vsync;
   reg           latched_href;
   reg [7:0]     latched_d;
   
   assign addr = address;
   assign we = we_reg;
	assign dout = {d_latch[15:11], d_latch[10:5], d_latch[4:0]};
//   assign dout = {d_latch[15:12], d_latch[10:7], d_latch[4:1]};
   
   
   always_ff @(posedge pclk)
	begin
		if (we_reg == 1'b1)
			address <= (address + 1);
		
		if (href_hold == 1'b0 & latched_href == 1'b1)
			case (line)
				2'b00 :
					line <= 2'b01;
				2'b01 :
					line <= 2'b10;
				2'b10 :
					line <= 2'b11;
				default :
					line <= 2'b00;
			endcase
		href_hold <= latched_href;
		
		if (latched_href == 1'b1)
			d_latch <= {d_latch[7:0], latched_d};
		we_reg <= 1'b0;
		// if vsync jumps up, clear out everything
		if (latched_vsync == 1'b1)
		begin
			address <= {17{1'b0}};
			href_last <= {7{1'b0}};
			line <= {2{1'b0}};
		end // or if vsync is low
		else
			if (href_last[2] == 1'b1)
			begin // line[1] changes every 2 cycles
				if (line[1] == 1'b1)
					we_reg <= 1'b1;
				href_last <= {7{1'b0}};
			end
			else  // href_last is like a shift register shifting left
				href_last <= {href_last[6 - 1:0], latched_href};
	end

	
	
	always_ff@(negedge pclk)
	begin
		latched_d <= d;
		latched_href <= href;
		latched_vsync <= vsync;
	end
   
endmodule

