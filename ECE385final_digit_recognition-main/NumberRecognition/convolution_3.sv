module convolution_3(
	input logic 				  Clk, Reset, start,
	input logic signed [31:0] curdata,
	input logic signed [31:0] curweight,
	input logic signed [31:0] curbias,
	output logic 		 [13:0] data_addr,
	output logic 		 [13:0] weight_addr,
	output logic 		 [9:0]  bias_addr,
	output logic 		 [13:0] temp_addr,
	output logic signed[31:0] temp_data,
	output logic     			  temp_wren,
	output logic 				  ready
);

	// temporary variable
	logic signed [31:0] data [25]; // TODO shrinked the size of the multiplier!
	logic signed [31:0] weight [25];
	logic signed [31:0] bias;
	logic signed [31:0] result;
	logic signed [31:0] accumulator = 32'b0; // DEBUG: initialize accumulator
	logic 		 [13:0] data_base_addr;
	integer counter_step, counter_data, counter_batch, counter_level;
	// removed counter_weight

	kernel_1x5x5 kernel(.data, .weight, .bias(32'b0), .reluEnable(1'b0), .result); 
	// DEBUG: do not relu and bias
	
	assign data_base_addr = counter_level*25;
//	assign data_addr = data_base_addr + counter_data/5*5 + counter_data%5;
	assign data_addr = data_base_addr + counter_data;
	
	assign weight_addr = counter_batch*250 + counter_level*25 + counter_data;
	assign temp_addr = counter_batch;
	assign temp_data = accumulator; // DEBUG: the temp_data is no longer variable 'result'
	
	enum logic [4:0] {IDLE, CHECK_BATCH, LOAD_BIAS, LOAD, CHECK_STEP, CHECK_LEVEL,
							LOAD_DATA, ACCUMULATE, RELU, SAVE_RESULT, DONE} state;
	
	always_ff@(posedge Clk)
	begin
		if(Reset)begin
			state 			<= IDLE;
			accumulator    <= 0;
			bias_addr 		<= 0;
			counter_batch 	<= 0;
			counter_data 	<= 0;
			counter_step 	<= 0;
			counter_level  <= 0;
		end else begin
			case(state)
				IDLE:
					if(start)
						state <= CHECK_BATCH;
						
				CHECK_BATCH:
					if(counter_batch == 60) // avoid using comparison
						state <= DONE;
					else begin
						state <= LOAD_BIAS;
					end
						
				LOAD_BIAS:begin
					bias <= curbias;
					bias_addr <= bias_addr + 1;
					state <= CHECK_STEP;
				end
				
				CHECK_STEP:
					if(counter_step == 1)begin
						counter_step <= 0;
						counter_batch <= counter_batch + 1;
						state <= CHECK_BATCH;
					end else 
						state <= CHECK_LEVEL;
						
				CHECK_LEVEL:
					if(counter_level == 10)begin
						counter_level 	<= 0;
						accumulator 	<= accumulator + bias; // add bias
						state 			<= RELU;
					end else
						state <= LOAD;
					
						
				LOAD:begin
					if(counter_data == 25)begin
						state <= ACCUMULATE;
						counter_data <= 0; // reset counter_data
					end else begin
						counter_data 			<= counter_data + 1;
						data[counter_data] 	<= curdata;
						weight[counter_data] <= curweight;
					end
				end

				
				ACCUMULATE:begin
					accumulator 	<= accumulator + result;
					counter_level 	<= counter_level + 1;
					state 			<= CHECK_LEVEL;
				end
					
				RELU:begin
					if(accumulator < 0)
						accumulator <= 0;
					state <= SAVE_RESULT;
				end
					
				
				SAVE_RESULT:begin
					accumulator <= 0; // reset accumulator
					counter_step <= counter_step + 1;
					state <= CHECK_STEP;
				end
				
				DONE:begin
					counter_batch <= 0;
					state <= IDLE;
				end
		
			endcase
		end
	end
	
	always_comb
	begin
		temp_wren = 1'b0;
		ready = 1'b0;
		case(state)
			SAVE_RESULT:
				temp_wren = 1'b1;
				
			DONE:
				ready = 1'b1;
				
			default:;
		
		endcase
	
	end

endmodule
