library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DAC is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR(15 downto 0);
           SYNC : out STD_LOGIC;
           DATA: out STD_LOGIC;
           SCLK : out STD_LOGIC);
end DAC;

architecture Behavioral of DAC is

signal fastcount_reg, fastcount_next: UNSIGNED(1 downto 0);
signal twobit_count: STD_LOGIC_VECTOR (1 downto 0);
signal slowcount_reg, slowcount_next: UNSIGNED(1 downto 0);
signal fivebitcount_reg,fivebitcount_next: UNSIGNED(4 downto 0);

signal syncresult: STD_LOGIC;
signal DAC_reg, DAC_next: UNSIGNED(15 downto 0);


begin

process(clk,fastcount_next, slowcount_next, fivebitcount_next, DAC_next)
begin
if (clk'event and clk='1') then
    fastcount_reg <= fastcount_next;
    slowcount_reg <= slowcount_next;
    fivebitcount_reg <= fivebitcount_next;
    DAC_reg <= DAC_next;
    end if;
end process;

--counter running at 10ns 
fastcount_next <= fastcount_reg + 1;

-- speed of this counter can be adjusted as necessary
slowcount_next <= slowcount_reg + 1;

twobit_count <= std_logic_vector(slowcount_reg);

-- to unsigned creates a 0 value 
fivebitcount_next <= to_unsigned(0,5) when fivebitcount_reg=16 and fastcount_reg=3 else
                fivebitcount_reg + 1 when fastcount_reg=3 else
                fivebitcount_reg;

    
syncresult <= '1' when fivebitcount_reg=16 else
    '0';
    
DAC_next <= UNSIGNED("0000" & sw(15 downto 4)) when fivebitcount_reg=16 and fastcount_reg=3 else
               shift_left(DAC_reg,1) when fastcount_reg=3 else
               DAC_reg;
    

SYNC <= syncresult;  
SCLK <= not twobit_count(1);
DATA <= DAC_reg(15);

end Behavioral;
