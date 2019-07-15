--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.1 (lin64) Build 1215546 Mon Apr 27 19:07:21 MDT 2015
--Date        : Tue Apr 30 16:39:36 2019
--Host        : physics-ThinkPad-13-2nd-Gen running 64-bit Ubuntu 16.04.5 LTS
--Command     : generate_target passthrough1_wrapper.bd
--Design      : passthrough1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity passthrough1_wrapper is
  port (
    DATA : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    SYNC : out STD_LOGIC;
    sys_clock : in STD_LOGIC;
    vauxn14 : in STD_LOGIC;
    vauxp14 : in STD_LOGIC
  );
end passthrough1_wrapper;

architecture STRUCTURE of passthrough1_wrapper is
  component passthrough1 is
  port (
    SYNC : out STD_LOGIC;
    DATA : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    vauxn14 : in STD_LOGIC;
    vauxp14 : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
  end component passthrough1;
begin
passthrough1_i: component passthrough1
     port map (
      DATA => DATA,
      SCLK => SCLK,
      SYNC => SYNC,
      sys_clock => sys_clock,
      vauxn14 => vauxn14,
      vauxp14 => vauxp14
    );
end STRUCTURE;
