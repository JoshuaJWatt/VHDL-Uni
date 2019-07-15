----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2018 16:44:54
-- Design Name: 
-- Module Name: eightleds - Behavioral
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

entity eightleds is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (14 downto 7));
end eightleds;

architecture Behavioral of eightleds is

-----signals
signal slowclk : std_logic;
signal count, count_reg : unsigned(31 downto 0) := to_unsigned(0, 31);
-----/signals

begin
-----clock
process(clk,count)
begin
if clk'event and clk = '1' then
    count_reg <= count;
end if;
end process;
count <= count_reg + 1;

--begin

led <= STD_LOGIC_VECTOR(count_reg(31 downto 24));

end Behavioral;
