library ieee;
use ieee.std_logic_1164.all;

entity Or4 is
	port(	Input:	in 	std_logic_vector(31 downto 0);
			Output:	out std_logic);
end Or4;

architecture rtl of Or4 is 
begin
	Output <= Input(0) or Input(1) or Input(2) or Input(3) after 5 ps;	
end rtl;