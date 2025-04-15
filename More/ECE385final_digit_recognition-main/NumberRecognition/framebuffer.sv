module framebuffer(
	input logic [7:0]   data,
   input logic [16:0]  rdaddress,
   input logic         rdclock,
   input logic [16:0]  wraddress,
   input logic         wrclock,
   input logic         wren,
   output logic [7:0]  q
);

	logic [7:0] q_top, q_bottom;
	logic 		wren_top, wren_bottom;

	ram_dual_port ram1(.data(data[7:0]), 
							.rdaddress(rdaddress[15:0]), 
							.rdclock(rdclock), 
							.wraddress(wraddress[15:0]), 
							.wrclock(wrclock), 
							.wren(wren_top), 
							.q(q_top));
	ram_dual_port ram2(.data(data[7:0]), 
							.rdaddress(rdaddress[15:0]), 
							.rdclock(rdclock), 
							.wraddress(wraddress[15:0]), 
							.wrclock(wrclock), 
							.wren(wren_bottom), 
							.q(q_bottom));
	
	// decide which part to operate
	always_comb
	begin
      case(wraddress[16])
         1'b0 :
            begin
               wren_top = wren;
               wren_bottom = 1'b0;
            end
         1'b1 :
            begin
               wren_top = 1'b0;
               wren_bottom = wren;
            end
         default :
            begin
               wren_top = 1'b0;
               wren_bottom = 1'b0;
            end
      endcase
	end
	
	always_comb
	begin
      case (rdaddress[16])
         1'b0 :
            q = q_top;
         1'b1 :
            q = q_bottom;
         default :
            q = 0;
      endcase
	end


endmodule
