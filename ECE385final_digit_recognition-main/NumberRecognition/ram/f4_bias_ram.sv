module f4_bias_ram(
	input logic 					Clk,
	input logic [9:0]				addr,
	output logic signed [31:0] read_data
);

	logic signed [31:0] mem [48];
	
	initial
	begin
		$readmemb("weights/tiny_f4/f4_bias.txt", mem);
	end
	
	always_ff@(negedge Clk)
	begin
		read_data <= mem[addr];
	end

endmodule