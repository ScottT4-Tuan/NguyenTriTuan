
module final_soc (
	clk_clk,
	reset_reset_n,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	res_0_export,
	res_1_export,
	res_2_export,
	res_3_export,
	res_4_export,
	res_5_export,
	res_6_export,
	res_7_export,
	res_8_export,
	res_9_export,
	inference_export);	

	input		clk_clk;
	input		reset_reset_n;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input	[31:0]	res_0_export;
	input	[31:0]	res_1_export;
	input	[31:0]	res_2_export;
	input	[31:0]	res_3_export;
	input	[31:0]	res_4_export;
	input	[31:0]	res_5_export;
	input	[31:0]	res_6_export;
	input	[31:0]	res_7_export;
	input	[31:0]	res_8_export;
	input	[31:0]	res_9_export;
	output	[3:0]	inference_export;
endmodule
