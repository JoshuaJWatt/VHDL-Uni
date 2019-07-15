#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.1"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim horowitz_behav -key {Behavioral:sim_1:Functional:horowitz} -tclbatch horowitz.tcl -log simulate.log
