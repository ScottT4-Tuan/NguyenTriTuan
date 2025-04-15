module find_max(
	input logic 				  Clk, Reset, start,
	input logic signed [31:0] curdata,
	output logic 		 [13:0] data_addr,
	output logic 				  done,
	output logic 		 [3:0]  idx
);
	
	integer 					counter_step = 0;
	logic signed [31:0] 	temp = 32'b0;
	logic 		 [3:0]	max;
	
	assign idx = max;
	
	assign data_addr = counter_step[13:0];
	
	enum logic [2:0] {IDLE, CHECK_STEP, COMPARE, DONE} state;
	
	always_ff@(posedge Clk)
	begin
		if(Reset)begin
			state <= IDLE;
			counter_step <= 0;
			max <= 0;
		end else begin
			case(state)
				IDLE:
					if(start)begin
						max <= 0;
						state <= CHECK_STEP;
					end
				
				CHECK_STEP:
					if(counter_step == 10)begin
						counter_step <= 0;
						state <= DONE;
					end else 
						state <= COMPARE;
				
				COMPARE:begin
					if(curdata > temp)begin
						temp <= curdata;
						max <= counter_step[3:0];
					end
					state <= CHECK_STEP;
					counter_step <= counter_step + 1;
				end
				
				DONE:begin
					temp <= 32'b0; // forgot to reset temp
					state <= IDLE;
				end
			
			endcase
		end
	end
	
	always_comb
	begin
		done = 1'b0;
		case(state)
			DONE:
				done = 1'b1;
				
			default:;
		endcase
	end

endmodule 