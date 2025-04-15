module  bram_conv1_bias( 
		input [10:0] ADDR,
		input Clk,

		output logic [31:0] out
);

// the largest possible number of parameters is 1600, so 11-bit addressability is enough.
logic signed [31:0] mem [5:0];

initial
begin
	 $readmemb("D:/Projects/ECE385Labs/final/final_code/weights/c1_c1_bias.txt", mem);
end


always_ff @ (negedge Clk) begin
	out <= mem[ADDR];
end

endmodule