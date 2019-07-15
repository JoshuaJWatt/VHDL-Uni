----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity xadc_block is
    Port ( clk : in STD_LOGIC;
           vauxp14 : in STD_LOGIC;
           vauxn14 : in STD_LOGIC;
           out_data : out STD_LOGIC_VECTOR(15 downto 0);
           data_ready : out STD_LOGIC);
end xadc_block;


architecture Behavioral of xadc_block is
signal den_enable, eoc_enable, ready:STD_LOGIC;
signal drpaddress: STD_LOGIC_VECTOR(6 downto 0);
signal dataread: STD_LOGIC_VECTOR(15 downto 0);
signal output_reg, output_next: STD_LOGIC_VECTOR(15 downto 0);
signal slow_clk_reg, slow_clk_next : unsigned(5 downto 0);


begin
myadc: entity work.xadc_wiz_0
port map (                     
    daddr_in => drpaddress,      
    dclk_in => clk,              
    den_in => den_enable,            
    di_in => "0000000000000000", 
    dwe_in => '0',              
    busy_out => open,            
    vauxp14 => vauxp14,          
    vauxn14 => vauxn14,         
    vn_in => '0',                
    vp_in => '0',               
    alarm_out => open,            
    do_out => dataread,          
    reset_in => '0',             
    eoc_out => eoc_enable,      
    drdy_out => ready);          

process(clk, output_next)
begin
    if(clk'event and clk='1')
    then
        output_reg <= output_next;
    end if;
    if(slow_clk_reg<50)then
        slow_clk_next<=slow_clk_reg+1;
    elsif(slow_clk_reg=50)then
        slow_clk_next<=to_unsigned(0,6);
    end if;
    if(slow_clk_reg<2)then
        den_enable<='1';
    else
        den_enable<='0';
    end if;
end process;

process(ready,output_reg, dataread)
begin
    if(ready='1')
    then
        output_next<=dataread;
    else
        output_next<=output_reg;
    end if;
end process;

drpaddress <="0011110";
out_data<=output_reg;
data_ready <= ready;

end Behavioral;