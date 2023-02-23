transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/sub_rca_32.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/reg_32_bits.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/mux_32_to_1.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/mux_2_to_1.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/encoder_32_to_5.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/divider.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/cpu.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/Booth_Mult_32.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/ALU.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/Add_rca_32.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/Add_rca_16.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/Add_rca_4.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/Add_half.v}
vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/Add_full.v}

vlog -vlog01compat -work work +incdir+C:/altera/Verilog\ Proj\ 374 {C:/altera/Verilog Proj 374/and_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  and_tb

add wave *
view structure
view signals
run 500 ns
