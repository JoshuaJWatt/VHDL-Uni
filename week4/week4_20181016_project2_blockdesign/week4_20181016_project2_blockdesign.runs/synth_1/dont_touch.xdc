# This file is automatically generated.
# It contains project source information necessary for synthesis and implementation.

# XDC: imports/Labs/Basys3_Master.xdc

# Block Designs: bd/design_1/design_1.bd
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==design_1 || ORIG_REF_NAME==design_1}]

# IP: bd/design_1/ip/design_1_Sevbittwo_0_0/design_1_Sevbittwo_0_0.xci
set_property DONT_TOUCH TRUE [get_cells -hier -filter {REF_NAME==design_1_Sevbittwo_0_0 || ORIG_REF_NAME==design_1_Sevbittwo_0_0}]

# XDC: ipshared/user.org/sevbittwo_v1_0/a896de47/src/Basys3_Master.xdc
set_property DONT_TOUCH TRUE [get_cells [split [join [get_cells -hier -filter {REF_NAME==design_1_Sevbittwo_0_0 || ORIG_REF_NAME==design_1_Sevbittwo_0_0}] {/U0 }]/U0 ]]

# XDC: bd/design_1/design_1_ooc.xdc