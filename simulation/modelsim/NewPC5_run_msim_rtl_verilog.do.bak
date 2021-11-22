transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/clk_div3.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/freqBy2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/clkDiv4.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/skeleton.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/imem.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/dmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/alu.v}

vlog -vlog01compat -work work +incdir+C:/Users/Suryansh\ Jain/Desktop/Duke\ ECE/Semester\ 1/ECE\ 550D/Project\ Checkpoints/NewPC5 {C:/Users/Suryansh Jain/Desktop/Duke ECE/Semester 1/ECE 550D/Project Checkpoints/NewPC5/basic_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  basic_tb

add wave *
view structure
view signals
run -all
