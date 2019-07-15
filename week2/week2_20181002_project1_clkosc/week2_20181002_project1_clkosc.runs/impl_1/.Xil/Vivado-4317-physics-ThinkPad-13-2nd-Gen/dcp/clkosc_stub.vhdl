-- Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clkosc is
  Port ( 
    clk : in STD_LOGIC;
    JB : out STD_LOGIC
  );

end clkosc;

architecture stub of clkosc is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
begin
end;
