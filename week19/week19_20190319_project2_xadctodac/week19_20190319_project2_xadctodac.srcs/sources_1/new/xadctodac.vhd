----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2018 14:31:46
-- Design Name: 
-- Module Name: potdriv - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity xadctodac is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           vauxn14 : in STD_LOGIC;
           vauxp14 : in STD_LOGIC;
--           JC1 : out STD_LOGIC;
--           JC3 : out STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(15 downto 0); --DAC
           CS : out STD_LOGIC;
           data1 : out STD_LOGIC;
           data2 : out STD_LOGIC;
           dclk : out STD_LOGIC);
end xadctodac;

architecture Behavioral of xadctodac is
---signals
signal enable, ready, eoc_out: STD_LOGIC;
signal drpaddress: STD_LOGIC_VECTOR(6 downto 0);
signal dataread: STD_LOGIC_VECTOR(15 downto 0);
signal output_reg, output_next: STD_LOGIC_VECTOR(15 downto 0);
--ADC Slow Clock
signal slw_clk, slw_clk_next : UNSIGNED(0 downto 0) := to_unsigned(1,1);
signal clk_reg, clk_next : UNSIGNED(15 downto 0);
--DAC Slow Clock
signal slwclk_reg, slwclk_next : UNSIGNED(4 downto 0) := to_unsigned(0,5);
signal binclk_reg, binclk_next : UNSIGNED (1 downto 0) := to_unsigned(0,2);
signal bin_clk_out : STD_LOGIC_VECTOR(1 downto 0);
signal slwclk_out : STD_LOGIC_VECTOR(4 downto 0);
signal SYNC : STD_LOGIC;
signal DAC_reg1, DAC_next1, DAC_reg2, DAC_next2 : UNSIGNED(15 downto 0) := to_unsigned(0,16);

begin

-- use port map to connect XADC device
myadc: entity work.xadc_wiz_0
port map (                       --NOTICE that connections in a port map are COMMA separated!
    daddr_in => drpaddress,      --ADDRESS OF DATA CHANNEL (14)
    dclk_in => clk,              --100MHz clock into ADC divided down to 1MHz ADC sampling rate
    den_in => enable,            --wire connecting 'data enable in' to 'end of conversion out'
    di_in => "0000000000000000", --input data bus to dynamically reconfigure XADC (unused)
    dwe_in => '0',               --write enable for dynamically reconfiguring XADC (unused)
    busy_out => open,            --the 'open' keyword in VHDL means leave unconnected. 
    vauxp14 => vauxp14,              --connect non­inverting input of XADC device to constraint file port
    vauxn14 => vauxn14,              --connect inverting input of XADC device to constraint file port
    vn_in => '0',                --an unused input ­ inverting side
    vp_in => '0',                --an unused input ­ non inverting side
    alarm_out => open,           --output for alarms, but we disabled them all, so leave open.
    do_out => dataread,          --DIGITIZED DATA OUTPUT
    reset_in => '0',             --disable facility for asynchronous ADC reset
    eoc_out => eoc_out,           --wire connecting 'data enable in' to 'end of conversion out' Ready to take data
    drdy_out => ready);          --SIGNAL WHEN DATA IS READY TO BE READ

--counstruct a reg to hold data between reads
process(clk, output_next)
begin
    if(clk'event and clk='1')
    then
        output_reg <= output_next;
        clk_reg <= clk_next;
        slw_clk <= slw_clk_next;
        binclk_reg <= binclk_next;
        slwclk_reg <= slwclk_next;
        DAC_reg1 <= DAC_next1;
    end if;
end process;

--ADC Processes

binclk_next <= binclk_reg + 1;

slw_clk_next <= "0" when (clk_reg = 1) or (clk_reg = 0)
    else "1";
clk_next <= to_unsigned(0,16) when clk_reg = 49
    else clk_reg + 1;
    
process(clk, slw_clk)
begin
    if (slw_clk = 1)
        then
                enable <= '1';
        else
                enable <= '0';
        end if;
end process;            
        
-- det and resp to drdy_out signal
process(ready, output_reg, dataread)
begin
    if(ready='1')
    then
        output_next<=dataread;
    else
        output_next<=output_reg;
    end if;
end process;

--DAC Processes
process(binclk_reg, slwclk_reg)
begin
    if binclk_reg = 3
    then
        if slwclk_reg = 16
            then slwclk_next <= to_unsigned(0,5);
        else slwclk_next <= slwclk_reg +1;
        end if;
    else
        slwclk_next <= slwclk_reg;
    end if;
end process;

---DAC register stuff
process(slwclk_reg, binclk_reg, DAC_reg1)
begin
    if slwclk_reg = 16 AND binclk_reg = 3
    then
        DAC_next1 <= UNSIGNED(sw);
    elsif binclk_reg = 3 AND NOT(slwclk_reg = 16)
    then 
        DAC_next1 <= shift_left(DAC_reg1, 1);
    else
        DAC_next1 <= DAC_reg1;
    end if;
end process;

--wire ports to pins
led <= output_reg;
drpaddress <= "0011110";

--JC1 <= enable;
--JC3 <= eoc_out;

--DAC
--Set SYNC high every 16x4 cycles
SYNC <= '1' when slwclk_reg = 16 else '0';


bin_clk_out <= STD_LOGIC_VECTOR(binclk_reg);
slwclk_out <= STD_LOGIC_VECTOR(slwclk_reg);

------Various Data outputs 
--data1 <= bin_clk_out(1);
data1 <=  DAC_reg1(15);
--data2 <= slwclk_out(4);
--data2<=  STD_LOGIC(SYNC);
data2 <= '0';
CS <= SYNC;
dclk <= not binclk_reg(1);
end Behavioral;