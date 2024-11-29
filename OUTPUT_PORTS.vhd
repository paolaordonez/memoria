library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity OUTPUT_PORTS is

	port
	(
		-- Input ports
		clock,reset, writen: in std_logic;
		address	: in  std_logic_vector(7 downto 0);
		data_in : in  std_logic_vector(7 downto 0);
		
		-- Output ports
	   	port_out_00: out std_logic_vector(7 downto 0); 
         port_out_01: out std_logic_vector(7 downto 0)
         
	);
end OUTPUT_PORTS;


architecture arch_OUTPUT_PORTS of OUTPUT_PORTS is

begin
U1 : process (clock, reset)
begin
if (reset ='0') then
port_out_00 <= x"00";
elsif (clock'event and clock ='1') then
if (address = x"E0" and writen = '1') then
port_out_00 <= data_in;
end if;
end if;
end process;

U2 : process (clock, reset)
begin
if (reset ='0') then
port_out_01 <= x"00";
elsif (clock'event and clock ='1') then
if (address = x"E1" and writen = '1') then
port_out_01 <= data_in;
end if;
end if;
end process;



end arch_OUTPUT_PORTS;
