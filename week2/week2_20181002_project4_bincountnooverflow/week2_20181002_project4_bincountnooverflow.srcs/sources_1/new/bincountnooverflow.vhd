----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2018 15:04:39
-- Design Name: 
-- Module Name: bincountnooverflow - Behavioral
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

entity bincountnooverflow is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end bincountnooverflow;

architecture Behavioral of bincountnooverflow is
signal counter_reg, counter_next : UNSIGNED(31 downto 0);
begin

process(clk,counter_next)
begin
if (clk'event and clk='1') then
counter_reg <= counter_next;
end if;
end process;

process(counter_reg)
begin
-- 536870912 is 2^29
  if counter_reg<536870912 then
    counter_next <= counter_reg + 1;
  else
    counter_next <= counter_reg;
  end if;
end process;

led <= STD_LOGIC_VECTOR(counter_reg(31 downto 16));
end Behavioral;

