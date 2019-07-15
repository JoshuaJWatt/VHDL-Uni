--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.1 (lin64) Build 1215546 Mon Apr 27 19:07:21 MDT 2015
--Date        : Tue Apr 30 16:39:36 2019
--Host        : physics-ThinkPad-13-2nd-Gen running 64-bit Ubuntu 16.04.5 LTS
--Command     : generate_target passthrough1.bd
--Design      : passthrough1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity passthrough1 is
  port (
    DATA : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    SYNC : out STD_LOGIC;
    sys_clock : in STD_LOGIC;
    vauxn14 : in STD_LOGIC;
    vauxp14 : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of passthrough1 : entity is "passthrough1,IP_Integrator,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=passthrough1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=3,numReposBlks=3,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of passthrough1 : entity is "passthrough1.hwdef";
end passthrough1;

architecture STRUCTURE of passthrough1 is
  component passthrough1_xadc_block_0_0 is
  port (
    clk : in STD_LOGIC;
    vauxp14 : in STD_LOGIC;
    vauxn14 : in STD_LOGIC;
    out_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    data_ready : out STD_LOGIC
  );
  end component passthrough1_xadc_block_0_0;
  component passthrough1_DAC_0_0 is
  port (
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 15 downto 0 );
    SYNC : out STD_LOGIC;
    DATA : out STD_LOGIC;
    SCLK : out STD_LOGIC
  );
  end component passthrough1_DAC_0_0;
  component passthrough1_clk_wiz_0_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component passthrough1_clk_wiz_0_0;
  signal DAC_0_DATA : STD_LOGIC;
  signal DAC_0_SCLK : STD_LOGIC;
  signal DAC_0_SYNC : STD_LOGIC;
  signal GND_1 : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal sys_clock_1 : STD_LOGIC;
  signal vauxn14_1 : STD_LOGIC;
  signal vauxp14_1 : STD_LOGIC;
  signal xadc_block_0_out_data : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_clk_wiz_0_locked_UNCONNECTED : STD_LOGIC;
  signal NLW_xadc_block_0_data_ready_UNCONNECTED : STD_LOGIC;
begin
  DATA <= DAC_0_DATA;
  SCLK <= DAC_0_SCLK;
  SYNC <= DAC_0_SYNC;
  sys_clock_1 <= sys_clock;
  vauxn14_1 <= vauxn14;
  vauxp14_1 <= vauxp14;
DAC_0: component passthrough1_DAC_0_0
     port map (
      DATA => DAC_0_DATA,
      SCLK => DAC_0_SCLK,
      SYNC => DAC_0_SYNC,
      clk => clk_wiz_0_clk_out1,
      sw(15 downto 0) => xadc_block_0_out_data(15 downto 0)
    );
GND: unisim.vcomponents.GND
     port map (
      G => GND_1
    );
clk_wiz_0: component passthrough1_clk_wiz_0_0
     port map (
      clk_in1 => sys_clock_1,
      clk_out1 => clk_wiz_0_clk_out1,
      locked => NLW_clk_wiz_0_locked_UNCONNECTED,
      reset => GND_1
    );
xadc_block_0: component passthrough1_xadc_block_0_0
     port map (
      clk => clk_wiz_0_clk_out1,
      data_ready => NLW_xadc_block_0_data_ready_UNCONNECTED,
      out_data(15 downto 0) => xadc_block_0_out_data(15 downto 0),
      vauxn14 => vauxn14_1,
      vauxp14 => vauxp14_1
    );
end STRUCTURE;
