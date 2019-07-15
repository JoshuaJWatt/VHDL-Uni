# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/physics/Labs/week2/week2_20181002_project1_clkosc/week2_20181002_project1_clkosc.cache/wt [current_project]
set_property parent.project_path /home/physics/Labs/week2/week2_20181002_project1_clkosc/week2_20181002_project1_clkosc.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib /home/physics/Labs/week2/week2_20181002_project1_clkosc/week2_20181002_project1_clkosc.srcs/sources_1/new/clkosc.vhd
read_xdc /home/physics/Labs/week2/week2_20181002_project1_clkosc/week2_20181002_project1_clkosc.srcs/constrs_1/imports/Labs/Basys3_Master.xdc
set_property used_in_implementation false [get_files /home/physics/Labs/week2/week2_20181002_project1_clkosc/week2_20181002_project1_clkosc.srcs/constrs_1/imports/Labs/Basys3_Master.xdc]

synth_design -top clkosc -part xc7a35tcpg236-1
write_checkpoint -noxdef clkosc.dcp
catch { report_utilization -file clkosc_utilization_synth.rpt -pb clkosc_utilization_synth.pb }