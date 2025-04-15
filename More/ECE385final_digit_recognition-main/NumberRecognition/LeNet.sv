module LeNet(
	input logic 					Clk, Reset, start,
	input logic  [13:0]  		test_rdaddr,
	input logic signed [31:0]	sample_data_data,
	output logic signed [31:0] test_rddata,
	output logic [9:0]			sample_data_addr,
	output logic					done,
	output logic [3:0] 			inference
);
	
	
	// wren and address control
	logic [13:0] 	c1_temp_wraddr;
	logic [31:0]	c1_temp_wrdata;
	logic 			c1_temp_wren;
	
	logic [13:0] 	s1_temp_wraddr;
	logic [31:0]	s1_temp_wrdata;
	logic 			s1_temp_wren;
	
	logic [13:0] 	c2_temp_wraddr;
	logic [31:0]	c2_temp_wrdata;
	logic 			c2_temp_wren;
	
	logic [13:0] 	s2_temp_wraddr;
	logic [31:0]	s2_temp_wrdata;
	logic 			s2_temp_wren;
	
	logic [13:0] 	c3_temp_wraddr;
	logic [31:0]	c3_temp_wrdata;
	logic 			c3_temp_wren;
	
	logic [13:0] 	f4_temp_wraddr;
	logic [31:0]	f4_temp_wrdata;
	logic 			f4_temp_wren;
	
	logic [13:0] 	f5_temp_wraddr;
	logic [31:0]	f5_temp_wrdata;
	logic 			f5_temp_wren;

	logic 					inter_ram0_wren;
	logic 					inter_ram1_wren;
	logic 					c1_ready, s1_ready, c2_ready, s2_ready, c3_ready, f4_ready, f5_ready, infer_ready;
	
	logic [9:0]			   c1_data_addr;
	logic [13:0]			s1_data_addr;
	logic [13:0]			c2_data_addr;
	logic [13:0]			s2_data_addr;
	logic [13:0]			c3_data_addr;
	logic [13:0]			f4_data_addr;
	logic [13:0]			f5_data_addr;
	logic [13:0]			find_max_data_addr;
	
	
	logic [9:0]			   c1_weight_addr;
	logic [13:0]			c2_weight_addr;
	logic [13:0]			c3_weight_addr;
	logic [13:0]			f4_weight_addr;
	logic [13:0]			f5_weight_addr;
	
	logic [9:0]				c1_bias_addr;
	logic [9:0]				c2_bias_addr;
	logic [9:0]				c3_bias_addr;
	logic [9:0]				f4_bias_addr;
	logic [9:0]				f5_bias_addr;
	
	logic [13:0]			inter_ram0_wraddr;
	logic [13:0]			inter_ram1_wraddr;
	logic [13:0]			inter_ram0_rdaddr;
	logic [13:0]			inter_ram1_rdaddr;
	
	
	logic signed [31:0]	c1_weight_data;
	logic signed [31:0]	c2_weight_data;
	logic signed [31:0]	c3_weight_data;
	logic signed [31:0]	f4_weight_data;
	logic signed [31:0]	f5_weight_data;
	
	logic signed [31:0]	c1_bias_data;
	logic signed [31:0]	c2_bias_data;
	logic signed [31:0]	c3_bias_data;
	logic signed [31:0]	f4_bias_data;
	logic signed [31:0]	f5_bias_data;
	
	logic signed [31:0]	inter_ram0_rddata;
	logic signed [31:0]	inter_ram1_rddata;
	logic signed [31:0]	inter_ram0_wrdata;
	logic signed [31:0]	inter_ram1_wrdata;
	
	
	intermediate_ram temp0(
							.Clk,
							.rdaddr(inter_ram0_rdaddr),
							.rddata(inter_ram0_rddata),
							.wren(inter_ram0_wren),
							.wraddr(inter_ram0_wraddr),
							.wrdata(inter_ram0_wrdata));
							
	intermediate_ram temp1(
							.Clk,
							.rdaddr(inter_ram1_rdaddr),
							.rddata(inter_ram1_rddata),
							.wren(inter_ram1_wren),
							.wraddr(inter_ram1_wraddr),
							.wrdata(inter_ram1_wrdata));
	
	c1_weight_ram c1_weight(
							.Clk,
							.addr(c1_weight_addr),
							.read_data(c1_weight_data));
							
	c1_bias_ram c1_bias(
							.Clk,
							.addr(c1_bias_addr),
							.read_data(c1_bias_data));
							
							
	convolution_1 c1(
							.Clk, .start(start), .Reset,
							.curdata(sample_data_data),
							.curweight(c1_weight_data),
							.curbias(c1_bias_data),
							.data_addr(sample_data_addr),
							.weight_addr(c1_weight_addr),
							.bias_addr(c1_bias_addr),
							.temp_addr(c1_temp_wraddr), // save to ram0
							.temp_data(c1_temp_wrdata),
							.temp_wren(c1_temp_wren),
							.ready(c1_ready));
							
	pooling_1 s1(
							.Clk, .Reset, .start(c1_ready),
							.curdata(inter_ram0_rddata), // read from ram0
							.data_addr(s1_data_addr),
							.temp_addr(s1_temp_wraddr), // save to ram1
							.temp_data(s1_temp_wrdata),
							.temp_wren(s1_temp_wren),
							.ready(s1_ready));
							
	c2_weight_ram c2_weight(
							.Clk,
							.addr(c2_weight_addr),
							.read_data(c2_weight_data));
							
	c2_bias_ram c2_bias(
							.Clk,
							.addr(c2_bias_addr),
							.read_data(c2_bias_data));
							
							
	convolution_2 c2(
							.Clk, .start(s1_ready), .Reset,
							.curdata(inter_ram1_rddata), // read from ram1
							.curweight(c2_weight_data),
							.curbias(c2_bias_data),
							.data_addr(c2_data_addr),
							.weight_addr(c2_weight_addr),
							.bias_addr(c2_bias_addr),
							.temp_addr(c2_temp_wraddr), // save to ram0
							.temp_data(c2_temp_wrdata),
							.temp_wren(c2_temp_wren),
							.ready(c2_ready));
							
	pooling_2 s2(
							.Clk, .Reset, .start(c2_ready),
							.curdata(inter_ram0_rddata), // read from ram0
							.data_addr(s2_data_addr),
							.temp_addr(s2_temp_wraddr), // save to ram1
							.temp_data(s2_temp_wrdata),
							.temp_wren(s2_temp_wren),
							.ready(s2_ready));
							
	c3_weight_ram c3_weight(
							.Clk,
							.addr(c3_weight_addr),
							.read_data(c3_weight_data));
							
	c3_bias_ram c3_bias(
							.Clk,
							.addr(c3_bias_addr),
							.read_data(c3_bias_data));
							
	convolution_3 c3(
							.Clk, .start(s2_ready), .Reset,
							.curdata(inter_ram1_rddata), // read from ram1
							.curweight(c3_weight_data),
							.curbias(c3_bias_data),
							.data_addr(c3_data_addr),
							.weight_addr(c3_weight_addr),
							.bias_addr(c3_bias_addr),
							.temp_addr(c3_temp_wraddr), // save to ram0
							.temp_data(c3_temp_wrdata),
							.temp_wren(c3_temp_wren),
							.ready(c3_ready));
							
	f4_weight_ram f4_weight(
							.Clk,
							.addr(f4_weight_addr),
							.read_data(f4_weight_data));
							
	f4_bias_ram f4_bias(
							.Clk,
							.addr(f4_bias_addr),
							.read_data(f4_bias_data));
							
	fullyconnect_4 f4(
							.Clk, .start(c3_ready), .Reset,
							.curdata(inter_ram0_rddata), // read from ram0
							.curweight(f4_weight_data),
							.curbias(f4_bias_data),
							.data_addr(f4_data_addr),
							.weight_addr(f4_weight_addr),
							.bias_addr(f4_bias_addr),
							.temp_addr(f4_temp_wraddr), // save to ram1
							.temp_data(f4_temp_wrdata),
							.temp_wren(f4_temp_wren),
							.ready(f4_ready));
							
	f5_weight_ram f5_weight(
							.Clk,
							.addr(f5_weight_addr),
							.read_data(f5_weight_data));
							
	f5_bias_ram f5_bias(
							.Clk,
							.addr(f5_bias_addr),
							.read_data(f5_bias_data));
							
	fullyconnect_5 f5(
							.Clk, .start(f4_ready), .Reset,
							.curdata(inter_ram1_rddata), // read from ram1
							.curweight(f5_weight_data),
							.curbias(f5_bias_data),
							.data_addr(f5_data_addr),
							.weight_addr(f5_weight_addr),
							.bias_addr(f5_bias_addr),
							.temp_addr(f5_temp_wraddr), // save to ram0
							.temp_data(f5_temp_wrdata),
							.temp_wren(f5_temp_wren),
							.ready(f5_ready));
							
	find_max infer(
							.Clk, .Reset, .start(f5_ready),
							.curdata(inter_ram0_rddata), // read from ram0
							.data_addr(find_max_data_addr),
							.done(infer_ready),
							.idx(inference));
							
							
	assign test_rddata = inter_ram0_rddata;
	
	
	enum logic [3:0]{IDLE, CONV1, S1, CONV2, S2, CONV3, F4, F5, INFERENCE, DONE, DEBUG} state, state_in;
	
	always_ff@(posedge Clk)
	begin
		if(Reset)
			state <= IDLE;
		else
			state <= state_in;
	end
	
	always_comb
	begin
		state_in = state;
		unique case(state)
			IDLE:
				if(start)
					state_in = CONV1;
			
			CONV1:
				if(c1_ready)
					state_in = S1;
			
			S1:
				if(s1_ready)
					state_in = CONV2;
			
			CONV2:
				if(c2_ready)
					state_in = S2;
			
			S2:
				if(s2_ready) // do not forget this line
					state_in = CONV3;
			
			CONV3:
				if(c3_ready)
					state_in = F4;
			
			F4:
				if(f4_ready)
					state_in = F5;
			
			F5:
				if(f5_ready)
					state_in = INFERENCE;
			
			INFERENCE:
				if(infer_ready)
					state_in = DONE;
			
			DONE:
				if(~start)
					state_in = IDLE;
					
			DEBUG:;
				
		endcase
	end
	
	// some logic control
	always_comb
	begin
		done = 1'b0;
		
		unique case(state)
			
			DONE:
				done = 1'b1;
				
			DEBUG:;
			
			default:;
		
		endcase
	
	end
	
	// ram write control
	always_comb
	begin
		inter_ram0_rdaddr = 0;
		inter_ram0_wraddr = 0;
		inter_ram0_wrdata = 0;
		inter_ram0_wren 	= 0;
		inter_ram1_rdaddr = 0;
		inter_ram1_wraddr = 0;
		inter_ram1_wrdata = 0;
		inter_ram1_wren 	= 0;
		case(state)
			CONV1:begin
				// TODO: remember to add reading for ram1 after the sample test
				inter_ram0_wraddr = c1_temp_wraddr;
				inter_ram0_wrdata = c1_temp_wrdata;
				inter_ram0_wren 	= c1_temp_wren;
			end
				
			S1:begin
				inter_ram0_rdaddr = s1_data_addr;
				inter_ram1_wraddr = s1_temp_wraddr;
				inter_ram1_wrdata = s1_temp_wrdata;
				inter_ram1_wren   = s1_temp_wren;
			end
			
			CONV2:begin
				inter_ram1_rdaddr = c2_data_addr;
				inter_ram0_wraddr = c2_temp_wraddr;
				inter_ram0_wrdata = c2_temp_wrdata;
				inter_ram0_wren 	= c2_temp_wren;
			end
			
			S2:begin
				inter_ram0_rdaddr = s2_data_addr;
				inter_ram1_wraddr = s2_temp_wraddr;
				inter_ram1_wrdata = s2_temp_wrdata;
				inter_ram1_wren   = s2_temp_wren;
			end
			
			CONV3:begin
				inter_ram1_rdaddr = c3_data_addr;
				inter_ram0_wraddr = c3_temp_wraddr;
				inter_ram0_wrdata = c3_temp_wrdata;
				inter_ram0_wren 	= c3_temp_wren;
			end
			
			F4:begin
				inter_ram0_rdaddr = f4_data_addr;
				inter_ram1_wraddr = f4_temp_wraddr;
				inter_ram1_wrdata = f4_temp_wrdata;
				inter_ram1_wren 	= f4_temp_wren;
			end
			
			F5:begin
				inter_ram1_rdaddr = f5_data_addr;
				inter_ram0_wraddr = f5_temp_wraddr;
				inter_ram0_wrdata = f5_temp_wrdata;
				inter_ram0_wren 	= f5_temp_wren;
			end
			
			INFERENCE:begin
				inter_ram0_rdaddr = find_max_data_addr;
			end
			
			DONE:;
			
			DEBUG:
				inter_ram0_rdaddr = test_rdaddr;
		
		endcase
	end



endmodule
