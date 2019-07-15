----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 17:24:06
-- Design Name: 
-- Module Name: updowncount - Behavioral
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

entity updowncount is
    Port ( clk : in STD_LOGIC;
           btnC : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0));
end updowncount;

architecture Behavioral of updowncount is
--Types and Signals
type state_type is (Cup, Cdown);
signal clk_reg, clk_next : UNSIGNED(31 downto 0) := to_unsigned(0,32);
signal state_reg, state_next : state_type := Cup;
signal counter_reg, counter_next : UNSIGNED(31 downto 0) := to_unsigned(0,32);

begin

--Clock
process(clk)
begin
if (clk'event and clk='1')
    then
    	clk_reg <= clk_next;
    	state_reg <= state_next;
    	counter_reg <= counter_next;
    end if;
end process;

process
begin
case state_reg is
    when Cup =>
        counter_next <= counter_reg + 1;
        if btnC = '1'
            then
            state_next <= Cdown;
        else
            state_next <= Cup;
        end if;
    when Cdown =>
        counter_next <= counter_reg -1; -- This line won't work as '-' operator isn't a thing we can do
        if btnC = '1'
            then
            state_next <= Cup;
        else
            state_next <= Cdown;
        end if;
    end case;
end process;

led <= STD_LOGIC_VECTOR(counter_reg(31 downto 16));

end Behavioral;
