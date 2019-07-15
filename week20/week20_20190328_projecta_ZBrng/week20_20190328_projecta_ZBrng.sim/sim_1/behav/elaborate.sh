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
ExecStep $xv_path/bin/xelab -wto d1660b8bf4f94a6e9e027580d9f7eb91 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot horowitz_behav xil_defaultlib.horowitz -log elaborate.log
