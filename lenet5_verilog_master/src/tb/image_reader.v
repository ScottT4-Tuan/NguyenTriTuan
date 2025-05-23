module image_reader #(parameter NUMPIXELS, PIXELWIDTH = 8, FILE = "d:/Coding/lenet5-verilog-master/image32x32.list")(
	input clk, rst,
	output reg [7:0] nextPixel
);

reg [PIXELWIDTH-1:0] image[0:NUMPIXELS-1];	// temporary representation of image
integer i = 0;

initial begin
	$readmemh(FILE, image);
end

always @ (posedge clk or rst) begin
/*	if (rst) begin
		i <= 0;	// actually don't care
	end
	else begin*/
		nextPixel <= image[i];
		i <= i + 1;
//	end
end

endmodule
