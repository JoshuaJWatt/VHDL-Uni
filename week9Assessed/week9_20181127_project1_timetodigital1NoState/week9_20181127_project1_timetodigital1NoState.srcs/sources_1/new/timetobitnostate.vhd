----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2018 14:12:28
-- Design Name: 
-- Module Name: timetobitnostate - Behavioral
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

entity timetobitnostate is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           btnC : in STD_LOGIC);
end timetobitnostate;

architecture Behavioral of timetobitnostate is
----Signals
signal clk_reg, clk_next, count_reg, count_next : UNSIGNED(31 downto 0) := to_unsigned(0,32);
signal bpress_reg, bpress_next : UNSIGNED(0 downto 0) := to_unsigned(0,1);
begin

--Flip-flop
process(clk, clk_next, count_next, bpress_next)
begin
    if(clk'event and clk='1')
    then
        clk_reg <= clk_next;
        count_reg <= count_next;
        bpress_reg <= bpress_next;
    end if;
end process;
clk_next <= clk_reg + 1;

--Count up every clock cycle whilst button is pressed
process(btnC, bpress_reg, count_reg)
begin
if btnC = '1' 
    then
        if bpress_reg = "0" --Check whether this is the button first being pressed
            then
                count_next <= to_unsigned(1,32); --set to 1, taking into account the cycle that the button is first pressed
                bpress_next <= "1";
            else if bpress_reg = "1" --When button is still being held
                then
                    count_next <= count_reg + 1; 
            end if;
        end if;
    else --When button is not pressed
        count_next <= count_reg;
        bpress_next <= "0";
end if;
end process;

led <= STD_LOGIC_VECTOR(count_reg(31 downto 16)); --Reading top 16 bits

end Behavioral;
