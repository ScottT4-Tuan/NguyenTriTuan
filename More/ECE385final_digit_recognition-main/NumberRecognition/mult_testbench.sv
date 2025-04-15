module mult_testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
				// This is the amount of time represented by #1

timeprecision 1ns;

// These signals are internal because the processor will be
// instantiated as a submodule in testbench.
logic Clk = 0;
logic signed [31:0] a;
logic signed [31:0] b;
logic signed [31:0] c;


Mult u0(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always #1 Clk = ~Clk;

// Testing begins here
// The initial block is not synthesizable
// Everything happens sequentially inside an initial block
// as in a software program
initial begin
	a = 32'h03400000; // 3.25
	b = 32'h02100000; // 2.0625
	// 0006.B400: 6.703125
	#2 
	a = 32'hFCC00000; // -3.25
	b = 32'h02100000; // 2.0625
	
	
end

endmodule
