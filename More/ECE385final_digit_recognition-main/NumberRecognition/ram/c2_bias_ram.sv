module c2_bias_ram(
	input logic 					Clk,
	input logic [9:0]				addr,
	output logic signed [31:0] read_data
);

	logic signed [31:0] mem [10];
	
	initial
	begin
		$readmemb("weights/tiny_c2/c2_bias.txt", mem);
	end
	
	always_ff@(negedge Clk)
	begin
		read_data <= mem[addr];
	end

endmodule