library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity rom is

	port
	(
		-- Input ports
			address: in  std_logic_vector(7 downto 0);
			clock : in  std_logic;
		-- Output ports
		data_out	: out  std_logic_vector(7 downto 0)
	
	);
end rom;
architecture arch_rom of rom is
constant LDA_IMM : std_logic_vector(7 downto 0):=x"86";
constant STA_DIR : std_logic_vector(7 downto 0):=x"96";
constant BRA : std_logic_vector(7 downto 0):=x"20";
signal EN:std_logic;

type rom_type is array (0 to 127 ) of std_logic_vector (7 downto 0);
signal ROM: rom_type :=( 0=> LDA_IMM,
                         1=> x"AA",
								 2=> STA_DIR,
								 3=> x"E0",
								 4=> BRA,
								 5=> x"00",
								 others=> x"00"
							);
begin

enable : process (address)
begin
if ((to_integer(unsigned(address)) >= 0) and
(to_integer(unsigned(address)) <=127)) then
EN <= '1';
else
EN <= '0';
end if;
end process;

memory :process(clock) 
begin	
	if(clock' event and clock='1') then
	if(EN='1')then
		data_out <= ROM(to_integer(unsigned(address)));
	end if;
	end if;
end process;
	
end arch_rom;
