transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/vga_clock.v}
vlog -vlog01compat -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/ram_dual_port.v}
vlog -vlog01compat -work work +incdir+D:/Projects/ECE385Labs/final/final_code/db {D:/Projects/ECE385Labs/final/final_code/db/vga_clock_altpll.v}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/Color_Mapper.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/VGA_controller.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/HexDriver.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/font_rom.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/Mult.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/camera {D:/Projects/ECE385Labs/final/final_code/camera/ov7670_capture.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/rgb2gray.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/max.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/kernel_1x5x5.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/framebuffer.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/address_generator.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/intermediate_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/fullyconnect_4.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/fullyconnect_5.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/find_max.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/sample_data_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/c1_weight_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/c1_bias_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/c2_weight_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/c2_bias_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/convolution_1.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/convolution_2.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/pooling_1.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/pooling_2.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/c3_weight_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/c3_bias_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/convolution_3.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/f4_weight_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/f4_bias_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/f5_weight_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code/ram {D:/Projects/ECE385Labs/final/final_code/ram/f5_bias_ram.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/LeNet.sv}
vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/final_toplevel.sv}
vcom -93 -work work {D:/Projects/ECE385Labs/final/final_code/camera/ov7670_registers.vhd}
vcom -93 -work work {D:/Projects/ECE385Labs/final/final_code/camera/ov7670_controller.vhd}
vcom -93 -work work {D:/Projects/ECE385Labs/final/final_code/camera/i2c_sender.vhd}
vlib final_soc
vmap final_soc final_soc

vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/testbench_convolution1.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L final_soc -voptargs="+acc"  testbench_convolution1

add wave *
view structure
view signals
run 3000 us
