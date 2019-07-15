----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.10.2018 15:42:59
-- Design Name: 
-- Module Name: sdIO - Behavioral
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

entity sdIO is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(15 downto 0);
           CS : out STD_LOGIC;
           data1 : out STD_LOGIC;
           data2 : out STD_LOGIC;
           dclk : out STD_LOGIC;
           led : out STD_LOGIC_VECTOR(15 downto 0));
end sdIO;

architecture Behavioral of sdIO is
----signals
signal slwclk_reg, slwclk_next : UNSIGNED(4 downto 0) := to_unsigned(0,5);
signal binclk_reg, binclk_next : UNSIGNED (1 downto 0) := to_unsigned(0,2);
signal bin_clk_out : STD_LOGIC_VECTOR(1 downto 0);
signal slwclk_out : STD_LOGIC_VECTOR(4 downto 0);
signal SYNC : STD_LOGIC;
signal DAC_reg1, DAC_next1, DAC_reg2, DAC_next2 : UNSIGNED(15 downto 0) := to_unsigned(0,16);

begin
--bin clock 1
process(clk, binclk_next)
begin
    if(clk'event and clk='1')
    then
        binclk_reg <= binclk_next;
        slwclk_reg <= slwclk_next;
        DAC_reg1 <= DAC_next1;
    end if;
end process;
binclk_next <= binclk_reg + 1;

--slow clock
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
led(13 downto 9) <= slwclk_out;

end Behavioral;
