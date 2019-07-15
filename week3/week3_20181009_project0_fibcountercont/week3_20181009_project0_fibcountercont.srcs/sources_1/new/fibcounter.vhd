----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2018 15:23:23
-- Design Name: 
-- Module Name: fibcounter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fibcounter is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end fibcounter;

architecture Behavioral of fibcounter is
------
signal firstfib_reg: UNSIGNED (31 downto 0) := to_unsigned(0,32);
signal secondfib_reg: UNSIGNED (31 downto 0) := to_unsigned(1,32);
signal firstfib_next: UNSIGNED (31 downto 0) := to_unsigned(0,32);
signal secondfib_next: UNSIGNED (31 downto 0) := to_unsigned(1,32);

begin
process(clk,firstfib_next,secondfib_next)
begin
if (clk'event and clk='1') then
firstfib_reg <=  secondfib_next;
end if;
if (clk'event and clk='0') then
secondfib_reg <= firstfib_next;
end if;
end process;

process(firstfib_reg)
begin
    --if firstfib_reg < VAL then --test with arbitrary fib number
      firstfib_next <= firstfib_reg + secondfib_reg;
      secondfib_next <= firstfib_reg + secondfib_reg;
    --else
    --  firstfib_next <= firstfib_reg;
    --  secondfib_next <= secondfib_reg;
    --end if;
end process;

led <= STD_LOGIC_VECTOR(firstfib_reg(31 downto 16)); -- reading bits 32-17
--led <= STD_LOGIC_VECTOR(firstfib_reg(15 downto 0)); --reading first 16 bits
--process(firstfib_next,secondfib_next)
--begin
--if (firstfib_reg != secondfib_reg) then
--firstfib_next <= firstfib_reg + secondfib_reg

--firstfib_next <= fistfib_reg + secondfib_reg

end Behavioral;
