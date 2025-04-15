module c3_weight_ram(
	input logic 						Clk,
	input logic [13:0]				addr,
	output logic signed [31:0] 	read_data
);

	logic signed [31:0] mem [15000];
	
	initial
	begin
		$readmemb("weights/tiny_c3/c3_weight.txt", mem);
	end
	
	always_ff@(negedge Clk)
	begin
		read_data <= mem[addr];
	end

endmodule
