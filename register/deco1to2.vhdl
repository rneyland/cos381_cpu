library ieee;
use ieee.std_logic_1164.all;

entity deco1to2 is
	port
	(
		input:	in 	std_logic;
		output:	out std_logic_vector(1 downto 0)
	);
end deco1to2;

architecture rtl of deco1to2 is
	begin
		output(0)	<=	not input after 5 ps;
		output(1)	<=	input;
end rtl;

