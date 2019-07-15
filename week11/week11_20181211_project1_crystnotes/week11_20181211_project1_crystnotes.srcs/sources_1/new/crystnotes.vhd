----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2018 14:22:51
-- Design Name: 
-- Module Name: crystnotes - Behavioral
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

entity crystnotes is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           JC1 : out STD_LOGIC);
end crystnotes;

architecture Behavioral of crystnotes is
--Types and Signals
type note_type is (waitn, A, C, En, G);
signal counter_reg, counter_next : UNSIGNED(31 downto 0) := to_unsigned(0,32);
signal note_reg, note_next : note_type := waitn;

begin
--Clock
process(clk, counter_next, note_next)
begin
if( clk'event and clk='1') 
    then
    counter_reg<= counter_next;
    note_reg <= note_next;
end if;
end process;

process
begin
case note_reg is
    when waitn =>
        counter_next <= to_unsigned(0,32);
        JC1 <= '0';
        if (sw(15) = '1')  AND (sw(14) = '1')
            then
            note_next <= A;
        elsif (sw(15) = '1') AND (sw(14) = '0')
            then
            note_next <= C;
        elsif (sw(15) = '0') AND (sw(14) = '1')
            then
            note_next <= En;
        elsif (sw(15) = '0') AND (sw(14) = '0')
            then
            note_next <= G;
        end if;
        
    when A =>
        if counter_reg >= 114000
        then
            if counter_reg >= 228000
                then
                counter_next <= to_unsigned(0,32);
            else
                JC1 <= '1';
                counter_next <= counter_reg + 1;
            end if;
        else
            JC1 <= '0';
            counter_next <= counter_reg + 1;
        end if;
        if (sw(15) = '1')  AND (sw(14) = '1')
                    then
                    note_next <= A;
                elsif (sw(15) = '1') AND (sw(14) = '0')
                    then
                    note_next <= C;
                elsif (sw(15) = '0') AND (sw(14) = '1')
                    then
                    note_next <= En;
                elsif (sw(15) = '0') AND (sw(14) = '0')
                    then
                    note_next <= G;
                end if;
        
    when C =>
        if counter_reg >= 92000
            then
            if counter_reg >= 184000
                then
                counter_next <= to_unsigned(0,32);
            else
                JC1 <= '1';
                counter_next <= counter_reg + 1;
            end if;
        else
            JC1 <= '0';
            counter_next <= counter_reg + 1;
        end if;
        if (sw(15) = '1')  AND (sw(14) = '1')
                    then
                    note_next <= A;
                elsif (sw(15) = '1') AND (sw(14) = '0')
                    then
                    note_next <= C;
                elsif (sw(15) = '0') AND (sw(14) = '1')
                    then
                    note_next <= En;
                elsif (sw(15) = '0') AND (sw(14) = '0')
                    then
                    note_next <= G;
                end if;
        
    when En =>
        if counter_reg >= 76000
            then
            if counter_reg >= 152000
                then
                counter_next <= to_unsigned(0,32);
            else
                JC1 <= '1';
                counter_next <= counter_reg + 1;
            end if;
        else
            JC1 <= '0';
            counter_next <= counter_reg + 1;
        end if;
        if (sw(15) = '1')  AND (sw(14) = '1')
                     then
                     note_next <= A;
                 elsif (sw(15) = '1') AND (sw(14) = '0')
                     then
                     note_next <= C;
                 elsif (sw(15) = '0') AND (sw(14) = '1')
                     then
                     note_next <= En;
                 elsif (sw(15) = '0') AND (sw(14) = '0')
                     then
                     note_next <= G;
                 end if;
         
    when G =>
         if counter_reg >= 128000
             then
             if counter_reg >= 256000
                then
                counter_next <= to_unsigned(0,32);
             else 
                JC1 <= '1';
                counter_next <= counter_reg + 1;
             end if;             
         else
             JC1 <= '0';
             counter_next <= counter_reg + 1;
         end if;
         if (sw(15) = '1')  AND (sw(14) = '1')
                     then
                     note_next <= A;
                 elsif (sw(15) = '1') AND (sw(14) = '0')
                     then
                     note_next <= C;
                 elsif (sw(15) = '0') AND (sw(14) = '1')
                     then
                     note_next <= En;
                 elsif (sw(15) = '0') AND (sw(14) = '0')
                     then
                     note_next <= G;
                 end if;
    end case;
end process;
        
    
end Behavioral;
