----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.10.2018 14:44:51
-- Design Name: 
-- Module Name: binarycount - Behavioral
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

entity binarycount is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(15 downto 0));
end binarycount;

architecture Behavioral of binarycount is
signal counter_reg, counter_next : UNSIGNED(31 downto 0);
begin

process  (clk, counter_next)
begin
  if (clk'event and clk = '1') then
    counter_reg <= counter_next;
  end if;
end process;


counter_next <= counter_reg + 1;

LED <= STD_LOGIC_VECTOR(counter_reg(31 downto 16)); 

end Behavioral;
