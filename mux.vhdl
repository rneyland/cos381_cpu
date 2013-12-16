library ieee;
use ieee.std_logic_1164.all;

entity mux is 
	generic (	width: 	in integer;
				size: 	in integer);

	port(	input: in std_logic_vector((width*size) downto 0));
end mux;

architecture rtl of mux is 
begin

end rtl;