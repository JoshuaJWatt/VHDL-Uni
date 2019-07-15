----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2018 14:58:42
-- Design Name: 
-- Module Name: timetodigitstate - Behavioral
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

entity timetodigitstate is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           btnC : in STD_LOGIC);
end timetodigitstate;

architecture Behavioral of timetodigitstate is
---Signals
type state is (BNpress, Bpress);
signal count_reg, count_next : UNSIGNED(31 downto 0) := to_unsigned(0,32);
signal state_reg, state_next : state := BNpress;

begin

--Flip flop
process(clk, count_next, state_next)
begin
if clk'event and clk='1'
    then
        count_reg <= count_next;
        state_reg <= state_next;
    end if;
end process;

process
begin
case state_reg is
    when BNpress => --State when button isn't pressed
        if btnC = '1' --If the button is pressed in this state
            then
                count_next <= to_unsigned(1,32); --Reset and set to 1 to account for current cycle
                state_next <= Bpress; --Change to pressed/counting state
        else
            count_next <= count_reg;
            state_next <= state_reg; 
        end if;
    when Bpress => --State when button is pressed
        if btnC = '1' --If button is still pressed
            then
                count_next <= count_reg + 1; --Increment counter and remain is state
                state_next <= state_reg;
        else
            count_next <= count_reg; --Stop counter & return to not pressed state
            state_next <= BNpress;
        end if;
end case;
end process;

led <= STD_LOGIC_VECTOR(count_reg(31 downto 16));
            

end Behavioral;
