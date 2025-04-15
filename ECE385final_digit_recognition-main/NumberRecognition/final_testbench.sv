module final_testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
				// This is the amount of time represented by #1

timeprecision 1ns;


logic Clk, VGA_Clk, Reset, start, done;
logic [3:0] state, inference;


always #1 Clk = ~Clk;
always #2 VGA_Clk = ~VGA_Clk;

Retrieve_Data(
	clk,
	pixel_data,
	detectArea,
	display_data,
	retrieve_data,
	retrieve_data_addr,
	retrieve_data_wren,
	retrieve_done
);

//always begin
//	#1
//	state = net.state;
//	counter1 = net.c1.counter_step;
//	counter2 = net.c2.counter_step;
//	counter3 = net.f5.counter;
//	f5_res = net.f5_res;
//	res0 = f5_res[0];
//	res1 = f5_res[1];
//	res2 = f5_res[2];
//	res3 = f5_res[3];
//	res4 = f5_res[4];
//	res5 = f5_res[5];
//	res6 = f5_res[6];
//	res7 = f5_res[7];
//	res8 = f5_res[8];
//	res9 = f5_res[9];
//end


initial
begin
	Clk = 0;
	VGA_Clk = 0;
	Reset = 1;
	
	#2
	Reset = 0;
	start = 1;
	#2
	start = 0;

end


endmodule
