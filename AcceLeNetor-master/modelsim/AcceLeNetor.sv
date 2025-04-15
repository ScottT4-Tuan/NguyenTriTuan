module AcceLeNetor(clk,led);

    parameter top_bitwidth = 8;

    reg signed [top_bitwidth-1:0] image [27:0][27:0];  // Sửa từ wire -> reg để gán từ file SV
    input clk;
    reg signed [top_bitwidth-1:0] conv1_kernel [1:0][4:0][4:0];
    reg signed [top_bitwidth-1:0] conv2_kernel [1:0][1:0][4:0][4:0];
    reg signed [top_bitwidth-1:0] conv3_kernel [9:0][1:0][4:0][4:0];
    wire signed [top_bitwidth-1:0] connect_matrix [9:0][9:0];
    wire signed [top_bitwidth-1:0] output_vector [9:0];

    reg signed [top_bitwidth-1:0] output_vector_converted [9:0];
    reg [top_bitwidth-1:0] comparator;
    reg [3:0] index;
    output reg [9:0] led;
    int i;
	image_rom image_rom_inst(.image(image));  // gán giá trị từ ROM
	kernel_matrix_trained kernel_rom_inst(	.conv1_kernel(conv1_kernel), 
											.conv2_kernel(conv2_kernel),
											.conv3_kernel(conv3_kernel),
											.connect_matrix(connect_matrix));
    // Instantiate LeNet
    Lenet_accelerator #(top_bitwidth) Lenet_accelerator_instance (
        .clk(clk),
        .image(),  // Gán bằng generate bên dưới
        .conv1_kernel(conv1_kernel),
        .conv2_kernel(conv2_kernel),
        .conv3_kernel(conv3_kernel),
        .connect_matrix(connect_matrix),
        .output_vector(output_vector)
    );

    // Gán từng hàng ảnh vào instance theo cách generate (để tránh lỗi truyền mảng wire 2D)
    genvar gi;
    generate
        for (gi = 0; gi < 28; gi = gi + 1) begin : gen_image_assign
            assign Lenet_accelerator_instance.image[gi] = image[gi];
        end
    endgenerate

    always @(*) begin
        for (i = 0; i < 10; i = i + 1) begin
            output_vector_converted[i] = (output_vector[i][top_bitwidth-1]) ? 0 : output_vector[i];
        end
        comparator = output_vector_converted[0];
        index = 0;
        led = 10'b0;
        for (i = 1; i < 10; i = i + 1) begin
            if (output_vector_converted[i] > comparator) begin
                comparator = output_vector_converted[i];
                index = i;
            end
        end
        led[index] = 1;
    end
endmodule
