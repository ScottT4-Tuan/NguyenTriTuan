module rgb2gray(
	input logic [15:0] 	pixel_data,
	output logic [7:0]	gray_data
);
	logic [5:0] R, G, B;
	assign R = {1'b0, pixel_data[15:11]};
	assign G = pixel_data[10:5];
	assign B = {1'b0, pixel_data[4:0]};
	// a famous psychological formula
//	assign gray_data = (R*255/32*299 + G*255/65*587 + B*255/32*114 + 500) / 1000;
	assign gray_data = G * 255 / 64;


endmodule
