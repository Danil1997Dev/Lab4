set name sdmodb_tb
set pass Lab4 
set mem_file memory.mem
#############Create work library#############
vlib work

#############Compile sources#############
vlog "../$pass/sdmodb.v"   
vlog "../$pass/$name.sv"  
vsim -voptargs=+acc work.$name

# Set the window types
#mem load -i D:/intelFPGA/18.1/MIPS_CPU/itmo-comp-arch-2021/cpu_template/memory_simulation/$mem_file /cpu_test/cpu_instruction_memory/ram
view wave
view structure
view signals
#add wave 
add wave -noupdate -divider {all}
add wave sim:/$name/*
add wave -noupdate -divider {dut} 
add wave sim:/$name/dut/* 
run -all