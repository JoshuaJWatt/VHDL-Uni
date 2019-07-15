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
ExecStep $xv_path/bin/xelab -wto 906e983e41c9426e9633dfeb5e39cb30 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot horowitz_behav xil_defaultlib.horowitz -log elaborate.log
