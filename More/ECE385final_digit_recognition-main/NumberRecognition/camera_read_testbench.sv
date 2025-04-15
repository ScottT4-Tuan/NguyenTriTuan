module camera_read_testbench();

// inputs 
logic p_clock;
logic vsync;
logic href;
logic [7:0] p_data;

//outputs 
logic [15:0] pixel_data;
logic [16:0] address;
logic pixel_valid;
logic frame_done;

 camera_read camera_read_1 (
        .p_clock(p_clock), 
        .vsync(vsync), 
        .href(href),
        .p_data(p_data), 
        .pixel_data(pixel_data), 
        .pixel_valid(pixel_valid),
        .frame_done(frame_done),
		  .address(address)
    );
    
    always #5 p_clock = ~p_clock;
    
    initial begin 
    
    p_clock = 0;
    vsync = 0;
    href = 0;
    p_data = 0;
    #5;
    #100;
    
    vsync = 1;
    #10;
    vsync = 0;
	 
    #10;
    href = 1; 
    p_data = 8'hFF;
    #10; 
    p_data = 8'h11;
    #10;
    href = 0;
     
	 #10;
    href = 1; 
    p_data = 8'hFF;
    #10; 
    p_data = 8'h11;
    #10;
    href = 0;
	 #10;
	 
    vsync = 1;
    #10;
    vsync = 0;
    
    
    end
    
endmodule
