----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.05.2019 14:49:08
-- Design Name: 
-- Module Name: gaincontrol - Behavioral
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

entity gaincontrol is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           datain : in STD_LOGIC_VECTOR (15 downto 0);
           dataout : out STD_LOGIC_VECTOR (15 downto 0));
end gaincontrol;

architecture Behavioral of gaincontrol is
signal gain_next, gain_reg : STD_LOGIC_VECTOR (15 downto 0);
signal datain_sign, gain_sign : SIGNED (15 downto 0);
signal datain_ext, gain_ext : SIGNED(31 downto 0);
signal data_full :  SIGNED (63 downto 0);
--signal dataout : STD_LOGIC_VECTOR (32 downto 0);
begin

--process(clk, gain_next)
--begin
--    if(clk'event and clk='1')
--    then
--        gain_reg <= gain_next;
--    end if;
--end process;

gain_reg<= sw;

gain_sign <= signed(gain_reg);
datain_sign <= signed(datain);
gain_ext <= resize(gain_sign, 32);
datain_ext <= resize(datain_sign, 32);

data_full <= datain_ext * gain_ext;
dataout(15 downto 12) <= "0000";
dataout(11 downto 0) <= STD_LOGIC_VECTOR(data_full(27 downto 16));


end Behavioral;
