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
         JC : out STD_LOGIC;
         led : out STD_LOGIC_VECTOR(15 downto 0));
end horowitz;

architecture Behavioral of horowitz is
--------Signals
signal HorowitzReg, CompVal : STD_LOGIC_VECTOR(31 downto 0) := "10010100101010011010011101001010";
signal HorowitzReg_next : STD_LOGIC_VECTOR(31 downto 0) := "10010100101010011010011101001010";
signal repcount, repcount_next : UNSIGNED(15 downto 0) := to_unsigned(0,16);
signal clkreg, clk_next : UNSIGNED(31 downto 0) := to_unsigned(0,32);
--signal clkreg, clk_next : UNSIGNED(15 downto 0) := to_unsigned(0,16);
signal ledval, ledval_next : STD_LOGIC_VECTOR(15 downto 0);
begin
---32 Bit Reg
process(clk, HorowitzReg_next, repcount_next)
begin
    if(clk'event and clk='1')
    then
        HorowitzReg <= HorowitzReg_next;
        repcount <= repcount_next;
        clkreg <= clk_next;
        ledval <= ledval_next;
    end if;
end process;

--Comparator function
process(CompVal, HorowitzReg)
begin
    if (clk'event and clk='0') AND (HorowitzReg = CompVal)
    then
        repcount_next <= repcount + 1;
    end if;
end process;

--HorowitzReg_next <= STD_LOGIC_VECTOR(shift_right(HorowitzReg, 1));

clk_next <= clkreg + 1;
HorowitzReg_next(31 downto 1) <= HorowitzReg(30 downto 0);
HorowitzReg_next(0) <= HorowitzReg(27) XNOR HorowitzReg(30);

ledval_next <= HorowitzReg(31 downto 16) when clkreg(25) = '1' else
               ledval;
JC <= HorowitzReg(30);
--when clkreg(6) = '1';
--    led <= STD_LOGIC_VECTOR(HorowitzReg(15 downto 0));
led <= ledval;
end Behavioral;
