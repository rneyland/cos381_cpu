library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port
	(
		input:	in std_logic_vector(1 downto 0);
		sel:	in std_logic;
		output:	out std_logic
	);
end mux2to1;

architecture rtl of mux2to1 is
	begin
		output	<=	(input(0) and not sel) or (input(1) and sel) after 15 ps;
end rtl;

