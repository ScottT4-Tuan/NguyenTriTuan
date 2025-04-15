module bram_testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
				// This is the amount of time represented by #1

timeprecision 1ns;

logic Clk = 0;


logic [10:0] ADDR;
logic [31:0] out;

bram_conv1_weight u0(.*);

always #1 Clk = ~Clk;

initial 
begin
	ADDR = 149;
	#3
	ADDR = 10;

end

endmodule
