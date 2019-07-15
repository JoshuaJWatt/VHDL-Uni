--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.1 (lin64) Build 1215546 Mon Apr 27 19:07:21 MDT 2015
--Date        : Tue Oct 16 16:11:48 2018
--Host        : physics-ThinkPad-13-2nd-Gen running 64-bit Ubuntu 16.04.5 LTS
--Command     : generate_target design_1.bd
--Design      : design_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1 is
  port (
    an : out STD_LOGIC_VECTOR ( 3 downto 0 );
    clk : in STD_LOGIC;
    dp : out STD_LOGIC;
    led : out STD_LOGIC_VECTOR ( 15 downto 0 );
    seg : out STD_LOGIC_VECTOR ( 6 downto 0 );
    sw : in STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_Sevbittwo_0_0 is
  port (
    led : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sw : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    seg : out STD_LOGIC_VECTOR ( 6 downto 0 );
    dp : out STD_LOGIC;
    an : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component design_1_Sevbittwo_0_0;
  signal Sevbittwo_0_an : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal Sevbittwo_0_dp : STD_LOGIC;
  signal Sevbittwo_0_led : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal Sevbittwo_0_seg : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal clk_1 : STD_LOGIC;
  signal sw_1 : STD_LOGIC_VECTOR ( 15 downto 0 );
begin
  an(3 downto 0) <= Sevbittwo_0_an(3 downto 0);
  clk_1 <= clk;
  dp <= Sevbittwo_0_dp;
  led(15 downto 0) <= Sevbittwo_0_led(15 downto 0);
  seg(6 downto 0) <= Sevbittwo_0_seg(6 downto 0);
  sw_1(15 downto 0) <= sw(15 downto 0);
Sevbittwo_0: component design_1_Sevbittwo_0_0
     port map (
      an(3 downto 0) => Sevbittwo_0_an(3 downto 0),
      clk => clk_1,
      dp => Sevbittwo_0_dp,
      led(15 downto 0) => Sevbittwo_0_led(15 downto 0),
      seg(6 downto 0) => Sevbittwo_0_seg(6 downto 0),
      sw(15 downto 0) => sw_1(15 downto 0)
    );
end STRUCTURE;
