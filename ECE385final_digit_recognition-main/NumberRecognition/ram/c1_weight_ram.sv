module c1_weight_ram(
	input logic 					Clk,
	input logic [9:0]				addr,
	output logic signed [31:0] read_data
);

	logic signed [31:0] mem [150];
	
	initial
	begin
		$readmemb("weights/tiny_c1/c1_weight.txt", mem);
	end
	
	always_ff@(negedge Clk)
	begin
		read_data <= mem[addr];
	end

endmodule