module final_toplevel (
	input  logic        CLOCK_50,
	input  logic [3:0]  KEY,
	output logic [7:0]  LEDG = 0,
	output logic [17:0] LEDR,
	output logic [6:0]  HEX0,
	output logic [6:0]  HEX1,
	output logic [6:0]  HEX2,
	output logic [6:0]  HEX3,
	output logic [6:0]  HEX4,
	output logic [6:0]  HEX5,
	output logic [6:0]  HEX6,
	output logic [6:0]  HEX7,
	output logic [12:0] DRAM_ADDR,
	output logic [1:0]  DRAM_BA,
	output logic        DRAM_CAS_N,
	output logic        DRAM_CKE,
	output logic        DRAM_CS_N,
	inout  logic [31:0] DRAM_DQ,
	output logic [3:0]  DRAM_DQM,
	output logic        DRAM_RAS_N,
	output logic        DRAM_WE_N,
	output logic        DRAM_CLK,
	// VGA Interface 
	output logic [7:0]  	VGA_R,        //VGA Red
								VGA_G,        //VGA Green
								VGA_B,        //VGA Blue
	output logic        	VGA_CLK,      //VGA Clock
								VGA_SYNC_N,   //VGA Sync signal
								VGA_BLANK_N,  //VGA Blank signal
								VGA_VS,       //VGA virtical sync signal
								VGA_HS,       //VGA horizontal sync signal
								
	input logic        	ov7670_pclk,
   output logic       	ov7670_xclk,
   input logic        	ov7670_vsync,
   input logic        	ov7670_href,
   input logic [7:0]  	ov7670_data,
   output logic       	ov7670_sioc,
   inout logic        	ov7670_siod,
   output logic       	ov7670_pwdn,
   output logic       	ov7670_reset,
	
	
	input logic [16:0]	SW				// Switches
);	
	
	
	logic Clk, Reset;
	
	assign Clk = CLOCK_50;
	assign Reset = ~KEY[0];
	
	// camera parameters
	assign ov7670_pwdn = 1'b0;
	assign ov7670_reset = 1'b1;
	assign ov7670_xclk = VGA_CLK;


//	// Instantiation of Qsys design
//	final_soc final_qsystem (
//		.clk_clk(CLOCK_50),								// Clock input
//		.reset_reset_n(KEY[0]),							// Reset key
//	   .res_0_export(f5_res[0]),						// input PIO
//		.res_1_export(f5_res[1]),
//		.res_2_export(f5_res[2]),
//		.res_3_export(f5_res[3]),
//		.res_4_export(f5_res[4]),
//		.res_5_export(f5_res[5]),
//		.res_6_export(f5_res[6]),
//		.res_7_export(f5_res[7]),
//		.res_8_export(f5_res[8]),
//		.res_9_export(f5_res[9]),
//		.inference_export(inference),					// output PIO
//		.sdram_wire_addr(DRAM_ADDR),					// sdram_wire.addr
//		.sdram_wire_ba(DRAM_BA),						// sdram_wire.ba
//		.sdram_wire_cas_n(DRAM_CAS_N),				// sdram_wire.cas_n
//		.sdram_wire_cke(DRAM_CKE),						// sdram_wire.cke
//		.sdram_wire_cs_n(DRAM_CS_N),					// sdram.cs_n
//		.sdram_wire_dq(DRAM_DQ),						// sdram.dq
//		.sdram_wire_dqm(DRAM_DQM),						// sdram.dqm
//		.sdram_wire_ras_n(DRAM_RAS_N),				// sdram.ras_n
//		.sdram_wire_we_n(DRAM_WE_N),					// sdram.we_n
//		.sdram_clk_clk(DRAM_CLK)						// Clock out to SDRAM
//	);

	logic 			config_start, config_done, pixel_valid, frame_done;
	logic 			activeArea, detectArea, wren_capture, wren_test;
	logic [16:0] 	rdaddress, wraddress;
	logic [9:0] 	DrawX, DrawY;
	logic [15:0] 	pixel_data;
	logic [7:0]	 	read_data, gray_data, font_address, font_data;
	logic [3:0]  	hex0_in, hex1_in, hex2_in, hex3_in, hex4_in, hex5_in, hex6_in, hex7_in;

	logic [3:0] 	inference, stored_inference;
	logic 			retrieve_done, net_start, net_done;
	logic signed [31:0] test_msg;
	logic 		 [9:0]  sample_data_addr, retrieve_data_addr, testArea_addr;
	logic signed [31:0] sample_data_data, retrieve_data, testArea_data;
	logic 				  retrieve_data_wren, hold_retrieve;
	logic signed [31:0] test_rddata;
	logic [13:0]   bg_addr;
	logic [31:0]	bg_data;
	
//	initial begin
//		$readmemb("D:/Projects/ECE385Labs/final/final_code/weights/input_2.txt", test_data);
//	end
	
	
	vga_clock inst_vgaclk(.inclk0(Clk), .c0(VGA_CLK));
	


	ov7670_controller inst_configure(
							.clk(Clk),
							.resend(Reset),
							.config_finished(config_done),
							.sioc(ov7670_sioc),
							.siod(ov7670_siod));


	ov7670_capture cam_read(
							.pclk(ov7670_pclk),
							.vsync(ov7670_vsync),
							.href(ov7670_href),
							.d(ov7670_data),
							.addr(wraddress),
							.dout(pixel_data),
							.we(wren_capture));
							
	rgb2gray rgb_to_grey(
							.pixel_data(pixel_data),
							.gray_data(gray_data));
							
	framebuffer buffer(
							.data(gray_data),
							.rdaddress(rdaddress),
							.rdclock(VGA_CLK),
							.wraddress(wraddress),
							.wrclock(ov7670_pclk),
							.wren(wren_capture),
							.q(read_data));
							
							
	VGA_controller inst_vga(
							.*,
							.Clk,
							.DrawX,
							.DrawY,
							.activeArea,
							.detectArea);
							
	background_ram bg(
							.Clk,
							.addr(bg_addr),
							.read_data(bg_data));
	
	Color_Mapper inst_mapper(
//							.testArea_addr(testArea_addr), // for test
//							.testArea_data(testArea_data), // for test
							.bg_addr,  // draw background
							.bg_data,
							.read_data(read_data),
//							.sample_data(retrieve_data),
							.font_address(font_address),
							.font_data(font_data),
							.inference(stored_inference),
							.activeArea,
							.VGA_R, .VGA_G, .VGA_B,
							.DrawX, .DrawY);
							
	
	address_generator addr_gen(
							.CLK25(VGA_CLK),
							.enable(activeArea),
							.vsync(VGA_VS),
							.address(rdaddress));
							
	Retrieve_Data inst_retrieve_data(
							.clk(VGA_CLK),
							.pixel_data(read_data),
							.detectArea(detectArea),
							.frame_done(VGA_VS),
							.retrieve_data(retrieve_data),
							.retrieve_data_addr(retrieve_data_addr),
							.retrieve_data_wren(retrieve_data_wren),
							.retrieve_done(retrieve_done),
							.hold(hold_retrieve)
							);
							
	
	sample_data_ram data_ram(
							.Clk,
//							.rdaddr(SW[9:0]), // for debug mode
							.rdaddr(sample_data_addr),
							.rddata(sample_data_data),
//							.rdaddr(testArea_addr), // for test
//							.rddata(testArea_data), // for test
							.wraddr(retrieve_data_addr),
							.wrdata(retrieve_data),
							.wren(retrieve_data_wren)
							);
				
	
	font_rom inst_font_rom(
							.addr(font_address),
							.data(font_data));


	LeNet net(
							.Clk,
							.Reset,
							.start(net_start),
							.done(net_done),
							.inference(inference),
							.test_rdaddr(SW[13:0]), // these two signals are for test
							.test_rddata(test_msg),
							.sample_data_addr,
							.sample_data_data
							);
	
	
	
	HexDriver hex0(.In0(hex0_in), .Out0(HEX0));
	HexDriver hex1(.In0(hex1_in), .Out0(HEX1));
	HexDriver hex2(.In0(hex2_in), .Out0(HEX2));
	HexDriver hex3(.In0(hex3_in), .Out0(HEX3));
	HexDriver hex4(.In0(hex4_in), .Out0(HEX4));
	HexDriver hex5(.In0(hex5_in), .Out0(HEX5));
	HexDriver hex6(.In0(hex6_in), .Out0(HEX6));
	HexDriver hex7(.In0(hex7_in), .Out0(HEX7));
		

// main FSM
enum logic [3:0] {CONFIG, CONFIG_DONE, IDLE, CHECK_SECOND, WAIT_FRAME, INFERENCE, DONE, DEBUG} state;
integer frame = 0;
// Test signals
logic [7:0]  read_data_test;
logic [15:0] test_retrieve_count;
logic 		 net_worklight, retrieve_worklight, debug_mode;
 
always_comb
begin
//	LEDG[3] = stored_inference[3];
//	LEDG[2] = stored_inference[2];
//	LEDG[1] = stored_inference[1];
//	LEDG[0] = stored_inference[0];

	LEDG[0] = net_worklight;
	LEDG[1] = retrieve_worklight;
	LEDR[0] = debug_mode;
	
	hex0_in = stored_inference;
	hex7_in = sample_data_data[23:20]; // sample data
	hex5_in = state;

//	hex0_in = test_msg[3:0];
//	hex1_in = test_msg[7:4];
//	hex2_in = test_msg[11:8];
//	hex3_in = test_msg[15:12];
//	hex4_in = test_msg[19:16];
//	hex5_in = test_msg[23:20];
//	hex6_in = test_msg[27:24];
//	hex7_in = test_msg[31:28];
end

always_ff@(posedge Clk)
begin
	if(Reset)begin
		stored_inference <= 0;
		frame <= 0;
		state <= CONFIG;
		net_worklight <= 1'b0;
		retrieve_worklight <= 1'b0;
	end else
		unique case(state)
			CONFIG:begin
				state <= CONFIG_DONE;
			end

			CONFIG_DONE:
				if(config_done)
					state <= IDLE;
					
			IDLE:begin
				if(~KEY[2])
					state <= CHECK_SECOND;
//					state <= INFERENCE;
			end
			
			CHECK_SECOND:begin
				if(frame == 60)
					state <= WAIT_FRAME;
				if(VGA_VS == 1'b0)
					frame <= frame + 1;
			end
			
			WAIT_FRAME:
				if(retrieve_done)begin
					state <= INFERENCE;
//					state <= DEBUG;
					retrieve_worklight <= ~retrieve_worklight;
				end
			
			INFERENCE:begin
				if(net_done)begin
					state <= DONE;
//					state <= DEBUG;
					stored_inference <= inference;
					net_worklight <= ~net_worklight;
				end
			end
			
			DONE:
				if(VGA_VS == 1'b0)begin // inference once in one frame
					state <= CHECK_SECOND;
					frame <= 0;
				end
					
			DEBUG:
				if(KEY[2])
					state <= IDLE;
			
			default:
				state <= IDLE;
		
		endcase
end
	
always_comb
begin
	config_start = 0;
	net_start = 0;
	debug_mode = 1'b0;
	hold_retrieve = 1'b1; // active low
	
	case(state)
		CONFIG:
			config_start = 1;
		
		CONFIG_DONE:;
		
		IDLE:;
		
		WAIT_FRAME:;
		
		INFERENCE:begin
			net_start = 1;
			hold_retrieve = 1'b0; // DEBUG
		end
			
		DONE:;
		
		DEBUG:begin
			debug_mode = 1'b1;
			hold_retrieve = 1'b0;
			
		end
		
		default:;
		
	endcase
end



endmodule 