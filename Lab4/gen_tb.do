set name gen_tb
set pass Lab4 
set mem_file memory.mem
#############Create work library#############
vlib work

#############Compile sources#############
vlog "../$pass/gen.v" 
vlog "../$pass/phacc.v" 
vlog "../$pass/sdmodb.v" 
vlog "../$pass/sine_rom.v"
vlog "../$pass/sine_rom_syn.v"
vlog "K:/intelFPGA_lite/18.1/modelsim_ase/altera/verilog/src/cycloneive_atoms.v" 
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
add wave -noupdate -divider {pa} 
add wave sim:/$name/dut/pa/*
add wave -noupdate -divider {sr} 
add wave sim:/$name/dut/sr/*
add wave -noupdate -divider {sdm} 
add wave sim:/$name/dut/sdm/*
run -all