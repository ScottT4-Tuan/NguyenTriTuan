`timescale 1ns / 1ps
module camera_configure_testbench();

    // inputs

    logic clk;
    logic start;
    
    //outputs 
    
    logic done;
    logic sioc;
    logic siod;
    
    camera_configure dut1
        (
        .clk(clk),
        .start(start),
        .sioc(sioc),
        .siod(siod),
        .done(done)
        );
        
        always #5 clk = ~ clk;
        
        initial begin
        clk = 0;
        start = 0;
        #100;
        start = 1;
        #10;
        start = 0;
        @(posedge done) $finish;
        end
endmodule