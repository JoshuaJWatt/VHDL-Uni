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
signal DACslwclk_reg, DACslwclk_next : UNSIGNED(4 downto 0) := to_unsigned(0,5);
signal DACbinclk_reg, DACbinclk_next : UNSIGNED (1 downto 0) := to_unsigned(0,2);
signal DACbinclk_out : STD_LOGIC_VECTOR(1 downto 0);
signal DACslwclk_out : STD_LOGIC_VECTOR(4 downto 0);
signal DACSync : STD_LOGIC;
signal DAC_reg1, DAC_next1, DAC_reg2, DAC_next2 : UNSIGNED(15 downto 0) := to_unsigned(0,16);
signal debugcounter_reg, debugcounter_next : UNSIGNED(11 downto 0) := to_unsigned(0,12);
signal debugcounter_out : UNSIGNED(15 downto 0) := to_unsigned(0,16);

begin
--bin clock 1
process(clk, DACbinclk_next)
begin
    if(clk'event and clk='1')
    then
        DACbinclk_reg <= DACbinclk_next;
        DACslwclk_reg <= DACslwclk_next;
        DAC_reg1 <= DAC_next1;
--        debugcounter_reg <= debugcounter_next;
    end if;
end process;
DACbinclk_next <= DACbinclk_reg + 1;
--debugcounter_next <= debugcounter_reg + 1;

--slow clock
process(DACbinclk_reg, DACslwclk_reg)
begin
    if DACbinclk_reg = 3
    then
        if DACslwclk_reg = 16
            then DACslwclk_next <= to_unsigned(0,5);
        else DACslwclk_next <= DACslwclk_reg +1;
        end if;
    else
        DACslwclk_next <= DACslwclk_reg;
    end if;
end process;

---DAC register stuff
process(DACslwclk_reg, DACbinclk_reg, DAC_reg1)
begin
    if DACslwclk_reg = 16 AND DACbinclk_reg = 3
    then
        DAC_next1 <= UNSIGNED(sw);
    elsif DACbinclk_reg = 3 AND NOT(DACslwclk_reg = 16)
    then 
        DAC_next1 <= shift_left(DAC_reg1, 1);
    else
        DAC_next1 <= DAC_reg1;
    end if;
end process;

--Set DACSync high every 16x4 cycles
DACSync <= '1' when DACslwclk_reg = 16 else '0';


DACbinclk_out <= STD_LOGIC_VECTOR(DACbinclk_reg);
DACslwclk_out <= STD_LOGIC_VECTOR(DACslwclk_reg);

--debugcounter_out(15 downto 12) <= "0000";
--debugcounter_out(11 downto 0) <= debugcounter_reg;

------Various Data outputs
--data1 <= DACbinclk_out(1);
data1 <=  DAC_reg1(15);
--data2 <= debugcounter_reg(12);
--data2 <= DACslwclk_out(4);
--data2<=  STD_LOGIC(DACSync);
--data2 <= '0';
CS <= DACSync;
dclk <= not DACbinclk_reg(1);
led(13 downto 9) <= DACslwclk_out;

end Behavioral;