module fullyconnect_5(
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
	logic signed [31:0] data; // TODO shrinked the size of the multiplier!
	logic signed [31:0] weight;
	logic signed [31:0] bias;
	logic signed [31:0] result;
	logic signed [31:0] accumulator = 32'b0; // DEBUG: initialize accumulator
	logic 		 [13:0] data_base_addr;
	integer counter_step, counter_neuron;
	// removed counter_weight

	Mult kernel(.a(data), .b(weight), .c(result)); // DEBUG: do not relu
	
	assign data_addr = counter_step;
	
	assign weight_addr = counter_neuron * 48 + counter_step;
	assign temp_addr = counter_neuron[13:0];
	assign temp_data = accumulator; // DEBUG: the temp_data is no longer variable 'result'
	
	enum logic [4:0] {IDLE, CHECK_NEURON, LOAD_BIAS, LOAD, CHECK_STEP, 
							ACCUMULATE, RELU, SAVE_RESULT, DONE} state;
	
	always_ff@(posedge Clk)
	begin
		if(Reset)begin
			state 			<= IDLE;
			accumulator    <= 0;
			bias_addr 		<= 0;
			counter_step 	<= 0;
			counter_neuron <= 0;
		end else begin
			case(state)
				IDLE:
					if(start)
						state <= CHECK_NEURON;
						
				CHECK_NEURON:
					if(counter_neuron == 10) // avoid using comparison
						state <= DONE;
					else begin
						state <= LOAD_BIAS;
					end
						
				LOAD_BIAS:begin
					bias 			<= curbias;
					bias_addr 	<= bias_addr + 1;
					state 		<= CHECK_STEP;
				end
						
				CHECK_STEP:
					if(counter_step == 48)begin
						counter_step <= 0;
						accumulator  <= accumulator + bias; // add bias
						state 		 <= SAVE_RESULT;
					end else
						state <= LOAD;
					
						
				LOAD:begin
					state 			<= ACCUMULATE;
					counter_step 	<= counter_step + 1;
					data 				<= curdata;
					weight 			<= curweight;
				end

				
				ACCUMULATE:begin
					accumulator 	<= accumulator + result;
					state 			<= CHECK_STEP;
				end
					
//				RELU:begin
//					if(accumulator < 0)
//						accumulator <= 0;
//					state <= SAVE_RESULT;
//				end
					
				
				SAVE_RESULT:begin
					accumulator 	<= 0; // reset accumulator
					counter_neuron <= counter_neuron + 1;
					state 			<= CHECK_NEURON;
				end
				
				DONE:begin
					counter_neuron <= 0; // reset neuron counter
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
