# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/physics/Labs/week2/week2_20181002_project3_binarycount/week2_20181002_project3_binarycount.cache/wt [current_project]
set_property parent.project_path /home/physics/Labs/week2/week2_20181002_project3_binarycount/week2_20181002_project3_binarycount.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib /home/physics/Labs/week2/week2_20181002_project3_binarycount/week2_20181002_project3_binarycount.srcs/sources_1/new/binarycount.vhd
read_xdc /home/physics/Labs/week2/week2_20181002_project3_binarycount/week2_20181002_project3_binarycount.srcs/constrs_1/imports/Labs/Basys3_Master.xdc
set_property used_in_implementation false [get_files /home/physics/Labs/week2/week2_20181002_project3_binarycount/week2_20181002_project3_binarycount.srcs/constrs_1/imports/Labs/Basys3_Master.xdc]

synth_design -top binarycount -part xc7a35tcpg236-1
write_checkpoint -noxdef binarycount.dcp
catch { report_utilization -file binarycount_utilization_synth.rpt -pb binarycount_utilization_synth.pb }