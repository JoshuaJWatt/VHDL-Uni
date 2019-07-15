----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.02.2019 14:06:49
-- Design Name: 
-- Module Name: horowitz - Behavioral
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

entity horowitz is
  Port ( clk : in STD_LOGIC;
--         JC : out STD_LOGIC;
         led : out STD_LOGIC_VECTOR(7 downto 0));
end horowitz;

architecture Behavioral of horowitz is
--------Signals
signal HorowitzReg, CompVal : STD_LOGIC_VECTOR(31 downto 0) := "10010100101010011010011101001010";
signal HorowitzReg_next : STD_LOGIC_VECTOR(31 downto 0) := "10010100101010011010011101001010";
signal repcount, repcount_next : UNSIGNED(15 downto 0) := to_unsigned(0,16);
signal slwclk_reg, slwclk_next : UNSIGNED(63 downto 0) := to_unsigned(0,64);

begin
---32 Bit Reg
process(clk, HorowitzReg_next, repcount_next, slwclk_next)
begin
    if(clk'event and clk='1')
    then
        slwclk_reg <= slwclk_next;
        HorowitzReg <= HorowitzReg_next;
        repcount <= repcount_next;
    end if;
end process;

--Slow Clock
process(slwclk_reg)
begin
    if(slwclk_reg = 10000000)
    then
        slwclk_next <= to_unsigned(0,64);
    else
        slwclk_next <= slwclk_reg + 1;
    end if;
end process;

--Comparator function
process(CompVal, HorowitzReg)
begin
    if(HorowitzReg = CompVal) AND (slwclk_reg = 10000000)
    then
        repcount_next <= repcount + 1;
    else
        repcount_next <= repcount;
    end if;
end process;

--HorowitzReg_next <= STD_LOGIC_VECTOR(shift_right(HorowitzReg, 1));
-- SLow Horowitz
process(slwclk_reg, HorowitzReg)
begin
    if (slwclk_reg = 10000000)
    then       
        HorowitzReg_next(31 downto 1) <= HorowitzReg(30 downto 0);
        HorowitzReg_next(0) <= HorowitzReg(27) XNOR HorowitzReg(30);
    else
        HorowitzReg_next <= HorowitzReg;
    end if;
end process;


--JC <= HorowitzReg(30);
led <= STD_LOGIC_VECTOR(HorowitzReg(15 downto 8));
end Behavioral;