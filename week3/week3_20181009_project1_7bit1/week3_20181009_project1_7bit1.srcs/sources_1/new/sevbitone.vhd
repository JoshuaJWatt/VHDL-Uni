----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.10.2018 16:23:55
-- Design Name: 
-- Module Name: sevbitone - Behavioral
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

entity sevbitone is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(15 downto 0));
end sevbitone;

architecture Behavioral of sevbitone is

-----signals
signal slowclk : STD_LOGIC;
signal count, count_reg : UNSIGNED(31 downto 0) := to_unsigned(0, 32);
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
--slow clock
slowclk <= STD_LOGIC(count_reg(25));

led(11 downto 2) <= STD_LOGIC_VECTOR(count_reg(30 downto 21));
--led(10) <= count_reg(29);
--led(9) <= count_reg(28);
--led(8) <= count_reg(27);
--led(7) <= count_reg(26);
--led(6) <= count_reg(25);
--led(5) <= count_reg(24);
--led(4) <= count_reg(23);
--led(3) <= count_reg(22);

end Behavioral;
