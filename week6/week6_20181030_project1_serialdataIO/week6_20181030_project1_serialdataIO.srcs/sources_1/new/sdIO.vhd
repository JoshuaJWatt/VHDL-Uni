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

begin
--bin clock 1
process(clk, binclk_next)
begin
    if(clk'event and clk='1')
    then
        binclk_reg <= binclk_next;
    end if;
end process;
binclk_next <= binclk_reg + 1;

--slow clock
process(clk, slwclk_next)
begin
    if(clk'event and binclk_reg(1)='1')
    then 
        slwclk_reg <= slwclk_next;
    end if;
end process;
slwclk_next <= slwclk_reg + 1;


bin_clk_out <= std_logic_vector(binclk_reg);
slwclk_out <= STD_LOGIC_VECTOR(slwclk_reg);

data1 <= bin_clk_out(1);
data2 <= slwclk_out(4);
led(13 downto 9) <= slwclk_out;

end Behavioral;
