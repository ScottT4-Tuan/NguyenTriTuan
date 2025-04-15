module max #(
	Bitwidth = 32
)(
	input logic signed [Bitwidth-1 : 0] data1,
	input logic signed [Bitwidth-1 : 0] data2,
	input logic signed [Bitwidth-1 : 0] data3,
	input logic signed [Bitwidth-1 : 0] data4,
	
	output logic signed [Bitwidth-1 : 0] result
);

	logic signed [Bitwidth-1 : 0] temp1;
	logic signed [Bitwidth-1 : 0] temp2;
	
	always_comb
	begin
		temp1 = (data1 > data2) ? data1 : data2;
			
		temp2 = (data3 > data4) ? data3 : data4;
			
		result = (temp1 > temp2) ? temp1 : temp2;
	end
	

endmodule
