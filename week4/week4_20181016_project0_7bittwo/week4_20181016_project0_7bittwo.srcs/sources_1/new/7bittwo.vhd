----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.10.2018 11:15:07
-- Design Name: 
-- Module Name: 7bittwo - Behavioral
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

entity Sevbittwo is
    Port ( led : out STD_LOGIC_VECTOR (5 downto 0);
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           dp : out STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0));
end Sevbittwo;

architecture Behavioral of Sevbittwo is

-----signals
signal slowclk, result : STD_LOGIC;
signal count, count_reg : UNSIGNED(31 downto 0) := to_unsigned(0, 32);
signal fourbit : STD_LOGIC_VECTOR(3 downto 0);
signal twobit : STD_LOGIC_VECTOR(1 downto 0);
signal sevenbit : STD_LOGIC_VECTOR(6 downto 0);
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
--slowclk <= STD_LOGIC(count_reg(21));
twobit <= STD_LOGIC_VECTOR(count_reg(18 downto 17));

--Two bit -> Four bit
fourbit <= "0111" when twobit = "00" else
           "1011" when twobit = "01" else
           "1101" when twobit = "10" else
           "1110";
           
sevenbit <= "0001000" when twobit = "00" else
            "1001100" when twobit = "01" else
            "1101100" when twobit = "10" else
            "0011010" when twobit = "11";
         
led(3 downto 0) <= fourbit;
led(5 downto 4) <= twobit;

an <= fourbit;
seg <= sevenbit;

end Behavioral;
