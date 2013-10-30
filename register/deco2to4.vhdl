library ieee;
use ieee.std_logic_1164.all;

entity deco2to4 is
	port
	(
		input:	in 	std_logic_vector(1 downto 0);
		enable:	in 	std_logic;
		output:	out std_logic_vector(3 downto 0)
	);
end deco2to4;

architecture rtl of deco2to4 is
	begin
		output(0)	<=	(not input(0) and not input(1) and enable) after 10 ps;
		output(1)	<=	(input(0) and not input(1) and enable) after 10 ps;
		output(2)	<=	(not input(0) and input(1) and enable) after 10 ps; 
		output(3)	<=	(input(0) and input(1) and enable) after 5 ps;
end rtl;

