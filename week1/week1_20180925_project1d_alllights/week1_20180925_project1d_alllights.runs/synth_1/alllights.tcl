# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /home/physics/Labs/week1lab/week1_20180925_project1d_alllights/week1_20180925_project1d_alllights.cache/wt [current_project]
set_property parent.project_path /home/physics/Labs/week1lab/week1_20180925_project1d_alllights/week1_20180925_project1d_alllights.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib /home/physics/Labs/week1lab/week1_20180925_project1d_alllights/week1_20180925_project1d_alllights.srcs/sources_1/new/alllights.vhd
read_xdc /home/physics/Labs/week1lab/week1_20180925_project1d_alllights/week1_20180925_project1d_alllights.srcs/constrs_1/imports/Labs/Basys3_Master.xdc
set_property used_in_implementation false [get_files /home/physics/Labs/week1lab/week1_20180925_project1d_alllights/week1_20180925_project1d_alllights.srcs/constrs_1/imports/Labs/Basys3_Master.xdc]

synth_design -top alllights -part xc7a35tcpg236-1
write_checkpoint -noxdef alllights.dcp
catch { report_utilization -file alllights_utilization_synth.rpt -pb alllights_utilization_synth.pb }
