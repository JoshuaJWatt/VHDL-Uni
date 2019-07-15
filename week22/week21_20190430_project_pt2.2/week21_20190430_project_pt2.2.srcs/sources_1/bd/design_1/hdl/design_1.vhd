--Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2015.1 (lin64) Build 1215546 Mon Apr 27 19:07:21 MDT 2015
--Date        : Tue May  7 14:11:04 2019
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
    DATA : out STD_LOGIC;
    SCLK : out STD_LOGIC;
    SYNC : out STD_LOGIC;
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    vauxn14 : in STD_LOGIC;
    vauxp14 : in STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of design_1 : entity is "design_1,IP_Integrator,{x_ipProduct=Vivado 2015.1,x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=7,numReposBlks=7,numNonXlnxBlks=2,numHierBlks=0,maxHierDepth=0,da_board_cnt=2,synth_mode=Global}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of design_1 : entity is "design_1.hwdef";
end design_1;

architecture STRUCTURE of design_1 is
  component design_1_clk_wiz_0_0 is
  port (
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component design_1_clk_wiz_0_0;
  component design_1_xadc_block_0_1 is
  port (
    clk : in STD_LOGIC;
    vauxp14 : in STD_LOGIC;
    vauxn14 : in STD_LOGIC;
    out_data : out STD_LOGIC_VECTOR ( 15 downto 0 );
    data_ready : out STD_LOGIC
  );
  end component design_1_xadc_block_0_1;
  component design_1_DAC_0_1 is
  port (
    clk : in STD_LOGIC;
    sw : in STD_LOGIC_VECTOR ( 15 downto 0 );
    SYNC : out STD_LOGIC;
    DATA : out STD_LOGIC;
    SCLK : out STD_LOGIC
  );
  end component design_1_DAC_0_1;
  component design_1_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component design_1_xlslice_0_0;
  component design_1_xlslice_1_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 15 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 14 downto 0 )
  );
  end component design_1_xlslice_1_0;
  component design_1_xlconcat_0_0 is
  port (
    In0 : in STD_LOGIC_VECTOR ( 14 downto 0 );
    In1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    dout : out STD_LOGIC_VECTOR ( 22 downto 0 )
  );
  end component design_1_xlconcat_0_0;
  component design_1_util_vector_logic_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    Res : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component design_1_util_vector_logic_0_0;
  signal DAC_0_DATA : STD_LOGIC;
  signal DAC_0_SCLK : STD_LOGIC;
  signal DAC_0_SYNC : STD_LOGIC;
  signal clk_1 : STD_LOGIC;
  signal reset_1 : STD_LOGIC;
  signal sys_clock_1 : STD_LOGIC;
  signal util_vector_logic_0_Res : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal vauxn14_1 : STD_LOGIC;
  signal vauxp14_1 : STD_LOGIC;
  signal xadc_block_0_out_data : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal xlconcat_0_dout : STD_LOGIC_VECTOR ( 22 downto 0 );
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal xlslice_1_Dout : STD_LOGIC_VECTOR ( 14 downto 0 );
  signal NLW_clk_wiz_0_locked_UNCONNECTED : STD_LOGIC;
  signal NLW_util_vector_logic_0_Op1_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal NLW_xadc_block_0_data_ready_UNCONNECTED : STD_LOGIC;
begin
  DATA <= DAC_0_DATA;
  SCLK <= DAC_0_SCLK;
  SYNC <= DAC_0_SYNC;
  reset_1 <= reset;
  sys_clock_1 <= sys_clock;
  vauxn14_1 <= vauxn14;
  vauxp14_1 <= vauxp14;
DAC_0: component design_1_DAC_0_1
     port map (
      DATA => DAC_0_DATA,
      SCLK => DAC_0_SCLK,
      SYNC => DAC_0_SYNC,
      clk => clk_1,
      sw(15 downto 0) => xlconcat_0_dout(15 downto 0)
    );
clk_wiz_0: component design_1_clk_wiz_0_0
     port map (
      clk_in1 => sys_clock_1,
      clk_out1 => clk_1,
      locked => NLW_clk_wiz_0_locked_UNCONNECTED,
      reset => reset_1
    );
util_vector_logic_0: component design_1_util_vector_logic_0_0
     port map (
      Op1(7 downto 1) => NLW_util_vector_logic_0_Op1_UNCONNECTED(7 downto 1),
      Op1(0) => xlslice_0_Dout(0),
      Res(7 downto 0) => util_vector_logic_0_Res(7 downto 0)
    );
xadc_block_0: component design_1_xadc_block_0_1
     port map (
      clk => clk_1,
      data_ready => NLW_xadc_block_0_data_ready_UNCONNECTED,
      out_data(15 downto 0) => xadc_block_0_out_data(15 downto 0),
      vauxn14 => vauxn14_1,
      vauxp14 => vauxp14_1
    );
xlconcat_0: component design_1_xlconcat_0_0
     port map (
      In0(14 downto 0) => xlslice_1_Dout(14 downto 0),
      In1(7 downto 0) => util_vector_logic_0_Res(7 downto 0),
      dout(22 downto 0) => xlconcat_0_dout(22 downto 0)
    );
xlslice_0: component design_1_xlslice_0_0
     port map (
      Din(15 downto 0) => xadc_block_0_out_data(15 downto 0),
      Dout(0) => xlslice_0_Dout(0)
    );
xlslice_1: component design_1_xlslice_1_0
     port map (
      Din(15 downto 0) => xadc_block_0_out_data(15 downto 0),
      Dout(14 downto 0) => xlslice_1_Dout(14 downto 0)
    );
end STRUCTURE;
