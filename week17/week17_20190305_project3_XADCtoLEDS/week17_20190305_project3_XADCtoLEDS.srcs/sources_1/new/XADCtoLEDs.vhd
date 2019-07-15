----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.03.2019 15:33:47
-- Design Name: 
-- Module Name: XADCtoLEDs - Behavioral
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

entity XADCtoLEDs is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (7 downto 0);
           AD8N_N : in STD_LOGIC;
           AD8P_R : in STD_LOGIC);
end XADCtoLEDs;

architecture Behavioral of XADCtoLEDs is
--Signals
signal enable, ready: STD_LOGIC; --internal wiring between pins of ADC device
signal drpaddress: STD_LOGIC_VECTOR(6 downto 0);
signal dataread: STD_LOGIC_VECTOR(15 downto 0);
signal output_reg, output_next: STD_LOGIC_VECTOR(15 downto 0);
begin

--Registers
process(clk, output_next)
begin
    if(clk'event and clk='1')
    then
        output_reg <= output_next;
    end if;
end process;

--detect and respond to drdy_out signal
process(ready, output_reg, dataread)
begin
    if(ready='1')
    then
        output_next<=dataread;
    else
        output_next<=output_reg;
    end if;
end process;


-- use port map to connect XADC device
myadc: entity work.xadc_wiz_0
port map (                     --NOTICE that connections in a port map are COMMA separated!
    daddr_in => drpaddress,      --ADDRESS OF DATA CHANNEL (14)
    dclk_in => clk,              --100MHz clock into ADC divided down to 1MHz ADC sampling rate
    den_in => enable,            --wire connecting 'data enable in' to 'end of conversion out'
    di_in => "0000000000000000", --input data bus to dynamically reconfigure XADC (unused)
    dwe_in => '0',               --write enable for dynamically reconfiguring XADC (unused)
    busy_out => open,            --the 'open' keyword in VHDL means leave unconnected. 
    vauxp8 => AD8P_R,             --connect non­inverting input of XADC device to constraint file port
    vauxn8 => AD8N_N,             --connect inverting input of XADC device to constraint file port
    vn_in => '0',                 --an unused input ­ inverting side
    vp_in => '0',                 --an unused input ­ non inverting side
    alarm_out => open,            --output for alarms, but we disabled them all, so leave open.
    do_out => dataread,           --DIGITIZED DATA OUTPUT
    reset_in => '0',              --disable facility for asynchronous ADC reset
    eoc_out => enable,            --wire connecting 'data enable in' to 'end of conversion out'
    drdy_out => ready);           --SIGNAL WHEN DATA IS READY TO BE READ

-- wire ports to pins or values
led <= output_reg(15 downto 8);
drpaddress <= "0011000";    --this is binary for 8 with 001 appended
                            --to the most significant bits, 
                            --corresponding to VAUXP8 and VAUXN8

end Behavioral;
