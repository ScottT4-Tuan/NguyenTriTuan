module convKernel#(
	parameter integer BITWIDTH = 32,   

	parameter integer INPUTCHANNEL = 1, 

	parameter integer FILTERHEIGHT = 5,
	parameter integer FILTERWIDTH = 5
	)
	(
	input logic signed [BITWIDTH-1 : 0]data[INPUTCHANNEL * FILTERHEIGHT * FILTERWIDTH - 1 : 0],
	input logic signed [BITWIDTH-1 : 0]weight[INPUTCHANNEL * FILTERHEIGHT * FILTERWIDTH - 1 : 0],
	input logic signed [BITWIDTH - 1 : 0] bias,
	input logic reluEnable,

	output logic signed [BITWIDTH - 1 : 0]result
	);

	logic signed [BITWIDTH - 1 : 0] out [INPUTCHANNEL * FILTERHEIGHT * FILTERWIDTH - 1 : 0];
	logic signed [BITWIDTH - 1 : 0] sum [FILTERHEIGHT:0];
 
	// multiplication
	generate
		genvar i;
		for(i = 0; i < FILTERHEIGHT * FILTERWIDTH * INPUTCHANNEL; i = i + 1) 
		begin : mult_insts  // must give this block a name 
			Mult#(BITWIDTH) mult(
			.a(data[i]), 
			.b(weight[i]), 
			.c(out[i])
			);
		end
	endgenerate

	
	always_comb
	begin

		sum[0] = out[0] + out[1] + out[2] + out[3] + out[4];		
		sum[1] = out[5] + out[6] + out[7] + out[8] + out[9];
		sum[2] = out[10] + out[11] + out[12] + out[13] + out[14];
		sum[3] = out[15] + out[16] + out[17] + out[18] + out[19];
		sum[4] = out[20] + out[21] + out[22] + out[23] + out[24];
		
		sum[5] = sum[0] + sum[1] + sum[2] + sum[3] + sum[4] + bias;
		
		// ReLU
		if(reluEnable)begin
			if(sum[5] < 0)
				sum[5] = 0;
		end
	end

	// output
	assign result = sum[5];


    
endmodule
