module sample_data_ram(
	input logic 					Clk, wren,
	input logic [9:0]				wraddr,
	input logic [9:0]				rdaddr,
	input logic signed [31:0]  wrdata,
	output logic signed [31:0] rddata
);

	logic signed [31:0] mem [1024];
	
//	initial
//	begin
//		$readmemb("D:/Projects/ECE385Labs/final/final_code/weights/input_2.txt", mem);
//	end
	
	always_ff@(negedge Clk)
	begin
		rddata <= mem[rdaddr];
		if(wren)
			mem[wraddr] <= wrdata;
	end

endmodule