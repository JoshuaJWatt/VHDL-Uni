proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  debug::add_scope template.lib 1
  create_project -in_memory -part xc7a35tcpg236-1
  set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.cache/wt [current_project]
  set_property parent.project_path /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.xpr [current_project]
  set_property ip_repo_paths {
  /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.cache/ip
  {/home/physics/Labs/week22/External IPs}
} [current_project]
  set_property ip_output_repo /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.cache/ip [current_project]
  add_files -quiet /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.runs/synth_1/passthrough1_wrapper.dcp
  read_xdc -ref passthrough1_xadc_block_0_0 -cells U0 /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/ipshared/user.org/xadc_block_v1_0/836f3f48/src/Basys3_Master.xdc
  set_property processing_order EARLY [get_files /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/ipshared/user.org/xadc_block_v1_0/836f3f48/src/Basys3_Master.xdc]
  read_xdc -ref xadc_wiz_0 -cells U0 /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/bd/passthrough1/ip/passthrough1_xadc_block_0_0/src/xadc_wiz_0/xadc_wiz_0.xdc
  set_property processing_order EARLY [get_files /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/bd/passthrough1/ip/passthrough1_xadc_block_0_0/src/xadc_wiz_0/xadc_wiz_0.xdc]
  read_xdc -ref passthrough1_DAC_0_0 -cells U0 /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/ipshared/user.org/dac_v1_0/361bfde4/src/Basys3_Master.xdc
  set_property processing_order EARLY [get_files /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/ipshared/user.org/dac_v1_0/361bfde4/src/Basys3_Master.xdc]
  read_xdc -prop_thru_buffers -ref passthrough1_clk_wiz_0_0 -cells U0 /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/bd/passthrough1/ip/passthrough1_clk_wiz_0_0/passthrough1_clk_wiz_0_0_board.xdc
  set_property processing_order EARLY [get_files /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/bd/passthrough1/ip/passthrough1_clk_wiz_0_0/passthrough1_clk_wiz_0_0_board.xdc]
  read_xdc -ref passthrough1_clk_wiz_0_0 -cells U0 /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/bd/passthrough1/ip/passthrough1_clk_wiz_0_0/passthrough1_clk_wiz_0_0.xdc
  set_property processing_order EARLY [get_files /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/sources_1/bd/passthrough1/ip/passthrough1_clk_wiz_0_0/passthrough1_clk_wiz_0_0.xdc]
  read_xdc /home/physics/Labs/week22/20190430_project2_passthroughdiag/20190430_project2_passthroughdiag.srcs/constrs_1/imports/Labs/Basys3_Master.xdc
  link_design -top passthrough1_wrapper -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force passthrough1_wrapper_opt.dcp
  catch {report_drc -file passthrough1_wrapper_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file passthrough1_wrapper.hwdef}
  place_design 
  write_checkpoint -force passthrough1_wrapper_placed.dcp
  catch { report_io -file passthrough1_wrapper_io_placed.rpt }
  catch { report_utilization -file passthrough1_wrapper_utilization_placed.rpt -pb passthrough1_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file passthrough1_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force passthrough1_wrapper_routed.dcp
  catch { report_drc -file passthrough1_wrapper_drc_routed.rpt -pb passthrough1_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file passthrough1_wrapper_timing_summary_routed.rpt -rpx passthrough1_wrapper_timing_summary_routed.rpx }
  catch { report_power -file passthrough1_wrapper_power_routed.rpt -pb passthrough1_wrapper_power_summary_routed.pb }
  catch { report_route_status -file passthrough1_wrapper_route_status.rpt -pb passthrough1_wrapper_route_status.pb }
  catch { report_clock_utilization -file passthrough1_wrapper_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force passthrough1_wrapper.bit 
  catch { write_sysdef -hwdef passthrough1_wrapper.hwdef -bitfile passthrough1_wrapper.bit -meminfo passthrough1_wrapper.mmi -ltxfile debug_nets.ltx -file passthrough1_wrapper.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

