# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.cache/wt [current_project]
set_property parent.project_path /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
read_ip /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.xci
set_property is_locked true [get_files /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.xci]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top xadc_wiz_0 -part xc7a35tcpg236-1 -mode out_of_context
rename_ref -prefix_all xadc_wiz_0_
write_checkpoint -noxdef xadc_wiz_0.dcp
catch { report_utilization -file xadc_wiz_0_utilization_synth.rpt -pb xadc_wiz_0_utilization_synth.pb }
if { [catch {
  file copy -force /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.runs/xadc_wiz_0_synth_1/xadc_wiz_0.dcp /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.dcp
} _RESULT ] } { 
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}
if { [catch {
  write_verilog -force -mode synth_stub /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode synth_stub /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}
if { [catch {
  write_verilog -force -mode funcsim /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_funcsim.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
if { [catch {
  write_vhdl -force -mode funcsim /home/physics/Labs/week19/week19_20190319_project2_xadctodac/week19_20190319_project2_xadctodac.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0_funcsim.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}
