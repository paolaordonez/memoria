library ieee;
use ieee.std_logic_1164.all;

entity MEMORY_TEST is
	
	port
	(
		 -- Input ports
        writen, clock, reset: std_logic;
        address: in std_logic_vector(7 downto 0);
        data_in: in std_logic_vector(7 downto 0);
        port_in_00, port_in_01: in std_logic_vector(7 downto 0);
        -- Output ports
		  DISPLAY_1, DISPLAY_2, DISPLAY_3, DISPLAY_4 : out std_logic_vector(6 downto 0)
	);
end MEMORY_TEST;

architecture arch_MEMORY_TEST of MEMORY_TEST is
signal data_out : std_logic_vector(7 downto 0);
signal address_high, address_low, data_high, data_low : std_logic_vector(3 downto 0);

component MEMORY
	port
	(
	 -- Input ports
        WRITEN, CLOCK, RESET: std_logic;
        ADDRESS: in std_logic_vector(7 downto 0);
        DATA_IN: in std_logic_vector(7 downto 0);
        PORT_IN_00, PORT_IN_01: in std_logic_vector(7 downto 0);
        -- Output ports
        DATA_OUT: out std_logic_vector(7 downto 0);
        PORT_OUT_00, PORT_OUT_01: out std_logic_vector(7 downto 0)
	);

end component;
component decobcda7segmentos

	port
	(
	-- Input ports
	A,B,C,D	: in  std_logic;
		-- Output ports
		S : out std_logic_vector(  6 downto 0 )
	);

end component;
begin
address_high <= address(7 downto 4);
address_low  <= address(3 downto 0);
data_high    <= DATA_OUT(7 downto 4);
data_low     <= DATA_OUT(3 downto 0);
MEM: MEMORY port map ( WRITEN => writen, CLOCK => clock,RESET => reset,ADDRESS => address, DATA_IN => DATA_IN,PORT_IN_00 => port_in_00,PORT_IN_01 => port_in_01,DATA_OUT => data_out, PORT_OUT_00 => open,PORT_OUT_01 => open);
DEC1: decobcda7segmentos port map ( A => address_high(3), B => address_high(2),C => address_high(1),D => address_high(0),S => DISPLAY_1 );

DEC2: decobcda7segmentos port map ( A => address_low(3), B => address_low(2),C => address_low(1),D => address_low(0),S => DISPLAY_2 );

DEC3: decobcda7segmentos port map (A => data_high(3), B => data_high(2),C => data_high(1),D => data_high(0),S => DISPLAY_3);

DEC4: decobcda7segmentos port map (A => data_low(3), B => data_low(2), C => data_low(1),D => data_low(0),S => DISPLAY_4);
end arch_MEMORY_TEST;
