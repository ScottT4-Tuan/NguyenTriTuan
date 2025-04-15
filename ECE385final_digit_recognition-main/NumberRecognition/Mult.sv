module Mult #(
	Bitwidth = 32
)(
    input signed [31:0] a, b,
    output signed [31:0] c
);
	 
//	 logic [Bitwidth*2-1:0] ab;
//	 assign ab = a * b;
//	 assign c = ab[Bitwidth/2+31 : Bitwidth/2];
//	 
	 logic signed [63:0] ab; // 64 bit
	 assign ab = a * b;
	 assign c = ab[55:24];

    
endmodule
