module camera_read(
	input logic  	p_clock,
	input logic  	vsync,
	input logic  	href,
	input logic  	[7:0] p_data,
	output logic 	[15:0] pixel_data =0,
	output logic 	pixel_valid = 0,
	output logic 	frame_done = 0,
	output logic 	[16:0] address = 0
    );
	 

	logic [1:0] FSM_state = 0;
	logic pixel_half = 0;

	localparam WAIT_FRAME_START = 0;
	localparam ROW_CAPTURE = 1;
	
	
	always_ff@(posedge p_clock)
	begin 
		case(FSM_state)
			WAIT_FRAME_START: begin //wait for VSYNC
				FSM_state <= (!vsync) ? ROW_CAPTURE : WAIT_FRAME_START;
				frame_done <= 0;
				pixel_half <= 0;
				address <= 0;
			end
			
			ROW_CAPTURE: begin 
				FSM_state <= vsync ? WAIT_FRAME_START : ROW_CAPTURE;
				frame_done <= vsync ? 1 : 0;
				pixel_valid <= (href && pixel_half) ? 1 : 0;
				if(href && pixel_half)
					address <= address + 1; // the address starts at 1 for the first pixel!
				if (href) begin
					 pixel_half <= ~ pixel_half;
					 if (pixel_half) pixel_data[7:0] <= p_data;
					 else pixel_data[15:8] <= p_data;
				end
			end
		endcase
	end
	
endmodule