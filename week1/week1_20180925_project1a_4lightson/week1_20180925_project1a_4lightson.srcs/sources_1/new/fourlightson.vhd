
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fourlightson is
    Port ( led1 : out STD_LOGIC;
           led2 : out STD_LOGIC;
           led3 : out STD_LOGIC;
           led4 : out STD_LOGIC);
end fourlightson;

architecture Behavioral of fourlightson is

begin

led1 <= '1';
led2 <= '1';
led3 <= '1';
led4 <= '1';

end Behavioral;
