transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/final_toplevel.sv}

vlog -sv -work work +incdir+D:/Projects/ECE385Labs/final/final_code {D:/Projects/ECE385Labs/final/final_code/fixed_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  fixed_testbench

add wave *
view structure
view signals
run 100 ns
