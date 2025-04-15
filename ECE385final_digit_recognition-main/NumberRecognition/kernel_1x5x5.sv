module kernel_1x5x5(
    input logic signed [31 : 0]data[24 : 0],
	input logic signed [31 : 0]weight[24 : 0],
	input logic signed [31 : 0] bias,
	input logic reluEnable,

	output logic signed [31 : 0]result
);
    
    logic signed [31 : 0] out [24 : 0];
    logic signed [31 : 0] sum;

   Mult #(32) mult0(.a(data[0]), .b(weight[0]), .c(out[0]));
   Mult #(32) mult1(.a(data[1]), .b(weight[1]), .c(out[1]));
   Mult #(32) mult2(.a(data[2]), .b(weight[2]), .c(out[2]));
   Mult #(32) mult3(.a(data[3]), .b(weight[3]), .c(out[3]));
   Mult #(32) mult4(.a(data[4]), .b(weight[4]), .c(out[4]));
   Mult #(32) mult5(.a(data[5]), .b(weight[5]), .c(out[5]));
   Mult #(32) mult6(.a(data[6]), .b(weight[6]), .c(out[6]));
   Mult #(32) mult7(.a(data[7]), .b(weight[7]), .c(out[7]));
   Mult #(32) mult8(.a(data[8]), .b(weight[8]), .c(out[8]));
   Mult #(32) mult9(.a(data[9]), .b(weight[9]), .c(out[9]));
   Mult #(32) mult10(.a(data[10]), .b(weight[10]), .c(out[10]));
   Mult #(32) mult11(.a(data[11]), .b(weight[11]), .c(out[11]));
   Mult #(32) mult12(.a(data[12]), .b(weight[12]), .c(out[12]));
   Mult #(32) mult13(.a(data[13]), .b(weight[13]), .c(out[13]));
   Mult #(32) mult14(.a(data[14]), .b(weight[14]), .c(out[14]));
   Mult #(32) mult15(.a(data[15]), .b(weight[15]), .c(out[15]));
   Mult #(32) mult16(.a(data[16]), .b(weight[16]), .c(out[16]));
   Mult #(32) mult17(.a(data[17]), .b(weight[17]), .c(out[17]));
   Mult #(32) mult18(.a(data[18]), .b(weight[18]), .c(out[18]));
   Mult #(32) mult19(.a(data[19]), .b(weight[19]), .c(out[19]));
   Mult #(32) mult20(.a(data[20]), .b(weight[20]), .c(out[20]));
   Mult #(32) mult21(.a(data[21]), .b(weight[21]), .c(out[21]));
   Mult #(32) mult22(.a(data[22]), .b(weight[22]), .c(out[22]));
   Mult #(32) mult23(.a(data[23]), .b(weight[23]), .c(out[23]));
   Mult #(32) mult24(.a(data[24]), .b(weight[24]), .c(out[24]));

always_comb
begin
    sum =out[0] + out[1] + out[2] + out[3] + out[4] + 
     out[5] + out[6] + out[7] + out[8] + out[9] + 
     out[10] + out[11] + out[12] + out[13] + out[14] + 
     out[15] + out[16] + out[17] + out[18] + out[19] + 
     out[20] + out[21] + out[22] + out[23] + out[24] + 
     bias;

    if(reluEnable)begin
        if(sum < 0)
            sum = 0;
    end  
    
end
assign result = sum;

endmodule
