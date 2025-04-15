 module  Color_Mapper (           // Whether current pixel belongs to ball 
                       input logic  [7:0] read_data,          //  read data from frame buffer
//							  input logic signed [31:0] sample_data[1023:0],
							  input logic 	[7:0] font_data,
							  input logic  [3:0] inference,
							  input logic 			activeArea,
                       input logic  [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input logic  [31:0]bg_data,
//							  input logic signed [31:0] testArea_data,
							  
//							  output logic [9:0] testArea_addr,
							  output logic [13:0] bg_addr,
							  output logic [7:0] font_address,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
	logic [7:0] Red, Green, Blue;
	logic signed [7:0] sample_pixel, testArea_pixel;

	// Output colors to VGA
	assign VGA_R = Red;
	assign VGA_G = Green;
	assign VGA_B = Blue;
	
	// background ram
	assign bg_addr = (DrawY * 640 + DrawX)/32;

	// Assign color based on is_ball signal
	always_comb
	begin
	
		// draw background color
		Red = 8'h25;
		Green = 8'h25;
		Blue = 8'h25;
		
		// draw background
		if(bg_data[31-(DrawY * 640 + DrawX)%32] == 1'b1)begin // be aware of the index direction!!
			Red = 8'hff;
			Green = 8'hff;
			Blue = 8'hff;
		end
		
		// draw camera content
		if(activeArea)begin
			Red = read_data;
			Green = read_data;
			Blue = read_data;
		end

		// draw green borders
		if((DrawX>140 && DrawX<144)&&(DrawY<140 && DrawY>100) || 
			(DrawX>176 && DrawX<180)&&(DrawY<140 && DrawY>100) ||
			(DrawX>140 && DrawX<180)&&(DrawY<104 && DrawY>100) ||
			(DrawX>140 && DrawX<180)&&(DrawY<140 && DrawY>136))
		begin
				Red = 8'hd2;
				Green = 8'he6;
				Blue = 8'h03;
		end
		
		// draw image inside the border
		sample_pixel = (read_data>8'b01001000)? 8'b00000000 : 8'b11111111;
		if(DrawX>=144 && DrawX<176 && DrawY>=104 && DrawY<136)begin
//			sample_pixel = sample_data[(DrawY-344)*32+(DrawX-144)];
			Red = sample_pixel;
			Green = sample_pixel;
			Blue = sample_pixel;
		end
		
		// draw the number
		font_address = 160-(inference*16 + (DrawY-120)/4); // draw number four times as big. address here is also read from right to left
		if(DrawX>=400 && DrawX<432 && DrawY>=120 && DrawY<184)begin
			if(font_data[8-(DrawX-400)/4] == 1'b1)begin  // index of data is from right to left!!
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;
			end
		end
		
		// draw the test area
//		testArea_addr = (DrawY-344)*32 + (DrawX-144);
//		testArea_pixel = (testArea_data[24] == 1'b1)? 8'hff : 8'h00;
//		if(DrawX>=144 && DrawX<176 && DrawY>=344 && DrawY<376)begin
//			Red = testArea_pixel;
//			Green = testArea_pixel;
//			Blue = testArea_pixel;
//		end

	end 
 
endmodule
