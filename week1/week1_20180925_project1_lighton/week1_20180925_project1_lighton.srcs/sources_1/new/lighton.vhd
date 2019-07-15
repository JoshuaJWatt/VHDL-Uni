library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lighton is
    Port ( led : out STD_LOGIC);
end lighton;

architecture Behavioral of lighton is

begin

led <= '1';

end Behavioral;
