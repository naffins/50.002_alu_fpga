set projDir "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/vivado"
set projName "ALU_FPGA"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/au_top_0.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/alu_1.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/autotester_2.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/reset_conditioner_3.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/mux4_4.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/mux2_5.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/adder16_6.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/multiplier16_7.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/boolean16_8.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/shifter16_9.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/divider16_10.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/compare16_11.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/counter_12.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/equal16_13.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/basic_add6_14.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/full_adder_15.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/and2_16.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/basic_add16_17.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/two_compliment16_18.v" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/verilog/xor2_19.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/work/constraint/custom.xdc" "C:/Users/USER/Documents/GitHub/naffins/50.002_alu_fpga/ALU_FPGA/constraint/custom.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
