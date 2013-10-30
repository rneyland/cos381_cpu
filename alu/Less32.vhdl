library ieee;
use ieee.std_logic_1164.all;

entity Less32 is
	port(	A, B:		in 	std_logic_vector(31 downto 0);
			Output:		out std_logic_vector(31 downto 0);
			Negative:	out std_logic);
end Less32;

architecture rtl of Less32 is 
	signal Difference: 	std_logic_vector(31 downto 0);
	-- signal Overflow:	std_logic;	
begin
	-- subtract A and B, append (not) result onto 31 bits 
	Adder32: entity work.Adder32 port map(A, B, '1', '0', Difference); 
	Negative 	<= '0';
	Output		<= "0000000000000000000000000000000" & (not Difference(31)) after 10 ps;
end rtl;
