module f4_weight_ram(
	input logic 						Clk,
	input logic [13:0]				addr,
	output logic signed [31:0] 	read_data
);

	logic signed [31:0] mem [2880];
	
	initial
	begin
		$readmemb("weights/tiny_f4/f4_weight.txt", mem);
	end
	
	always_ff@(negedge Clk)
	begin
		read_data <= mem[addr];
	end

endmodule
