module Retrieve_Data(
	input logic 					clk,
	input logic [7:0]				pixel_data, // gray image
	input logic 					detectArea,
	input logic 					frame_done,
	input logic 					hold, // active low
	output logic signed [31:0]	retrieve_data,
	output logic [9:0]			retrieve_data_addr,
	output logic 					retrieve_data_wren,
	output logic 					retrieve_done
);


	integer 		 		  counter = 0;
	logic signed [31:0] extended_data, scaled_data;
//	logic signed [31:0] scale_param = 32'b00000000000000100000001000000010; // 2/255 = 0.0078431...
 
//	Mult multiplier(.a(scale_param), .b(pixel_data), .c(scaled_data));
	
	 // since number larger than 128 will cause the multiplier to malfunction, need to divided by 2
	always_comb
	begin
		if(pixel_data > 8'b01001000)
			extended_data = 32'b00000000000000000000000000000000; // remember to take the complement of pixel
		else
			extended_data = 32'b00000001000000000000000000000000; //  1
//			extended_data = {1{1'b0}, scaled_data, 23{1'b0}};
	end
  
	
	
	assign retrieve_data_addr = counter;
//	assign retrieve_data_wren = detectArea; // for non-FSM design
	assign retrieve_data = extended_data;
//	assign retrieve_data = 32'b11111111000000000000000000000000; // for test
	
	enum logic [2:0] {IDLE, CHECK, LOAD, DONE} state;
 
	always_ff@(posedge clk) // VGA clk
	begin
		
		case(state)
			IDLE:
				if(detectArea && hold)
					state <= LOAD;
			
			LOAD:begin
				if(counter == 1023) // DEBUG: should be 1023 rather than 1024
					state <= DONE;
				else if(detectArea == 1'b0)begin
					counter <= counter + 1; // DEBUG: should also plus 1 here. ref. my note
					state <= IDLE;
				end else
					counter <= counter + 1;
			end
			
			DONE:begin
				state <= IDLE;
				counter <= 0; // DEBUG: forgot to reset the counter
			end
				
			default:
				state <= IDLE;
		
		endcase

	end
	
	always_comb
	begin
		retrieve_data_wren = 1'b0;
		retrieve_done = 1'b0;
		case(state)
			LOAD:
				retrieve_data_wren = 1'b1;
				
			DONE:
				retrieve_done = 1'b1;
				
			default:;
		endcase
	end

endmodule
