----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2018 14:05:52
-- Design Name: 
-- Module Name: buttonstatemachine1 - Behavioral
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

entity buttonstatemachine1 is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC;
           btnC : in STD_LOGIC);
end buttonstatemachine1;

architecture Behavioral of buttonstatemachine1 is
--Signals
type state_type is (Vlow, Vhigh);
signal clk_reg, clk_next : UNSIGNED (35 downto 0) := to_unsigned(0,36); ---This needs changing/doesn't need to be so long
signal state_reg, state_next : state_type := Vlow;

begin
--Clock
process(clk, clk_next)
begin
if( clk'event and clk='1') 
    then
    clk_reg<= clk_next;
    state_reg <= state_next;
end if;
end process;



process(clk_reg, state_reg)
begin
case state_reg is
    when Vlow =>
    clk_next <= to_unsigned(0,36); --This needs changing
        if btnC = '1' 
            then 
            state_next <= Vhigh;
        else
            state_next <= Vlow;
        end if;
        led <= '0';
    when Vhigh =>
        led <= '1';
        clk_next <= clk_reg + 1;
        if btnC = '0' 
            then
            if clk_reg = 67108863
                then
                state_next <= Vlow;
            else 
                state_next <= Vhigh;
            end if;  
        else
            clk_next <= to_unsigned(0,36); --This needs changing
            state_next <= Vhigh;
        end if;
    end case;
end process;

end Behavioral;
