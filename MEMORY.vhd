library ieee;
use ieee.std_logic_1164.all;

entity MEMORY is
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
end MEMORY;

architecture arch_MEMORY of MEMORY is

    component rw
        port
        (
            clock: in std_logic;
            address: in std_logic_vector(7 downto 0);
            data_in: in std_logic_vector(7 downto 0);
            writen: in std_logic;
            data_out: out std_logic_vector(7 downto 0)
        );
    end component rw ;

    component rom
        port
        (
            address: in std_logic_vector(7 downto 0);
            clock: in std_logic;
            data_out: out std_logic_vector(7 downto 0)
        );
    end component;

    component OUTPUT_PORTS
        port
        (
            clock, reset, writen: in std_logic;
            address: in std_logic_vector(7 downto 0);
            data_in: in std_logic_vector(7 downto 0);
            port_out_00, port_out_01: out std_logic_vector(7 downto 0)
           
        );
    end component OUTPUT_PORTS;
    signal rom_out, rw_out: std_logic_vector(7 downto 0);

begin

    R: rom
        port map (
            address => ADDRESS,
            clock => CLOCK,
            data_out => rom_out
        );


   w : rw
        port map (
            clock => CLOCK,
            address => ADDRESS,
            data_in => DATA_IN,
            writen => WRITEN,
            data_out => rw_out
        );
    OUTS: OUTPUT_PORTS
        port map (
            address => ADDRESS,
            clock => CLOCK,
            reset => RESET,
            writen => WRITEN,
            data_in => DATA_IN,
            port_out_00 => PORT_OUT_00,
            port_out_01 => PORT_OUT_01
            
        );

    DATA_OUT <= rom_out when ADDRESS < x"80" else  
                rw_out when ADDRESS < x"E0" else  
                PORT_IN_00 when ADDRESS = x"F0" else  
                PORT_IN_01 when ADDRESS = x"F1" else   
                x"00";
					 
	

end arch_MEMORY;
