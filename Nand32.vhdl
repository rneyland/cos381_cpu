library ieee;
use ieee.std_logic_1164.all;

entity Nand32 is
	port(	A, B:		in 	std_logic_vector(31 downto 0);
			Output:		out std_logic_vector(31 downto 0);
			Negative: 	out std_logic);
end Nand32;

architecture rtl of Nand32 is 
	signal TempOutput: std_logic_vector(31 downto 0);
begin
	-- takes 2 bits from both inputs and nand's them
	Nands: for i in 0 to 30 generate
		Nand2: entity work.Nand2 port map(A(i+1 downto i), B(i+1 downto i), TempOutput(i+1 downto i));
	end generate Nands;	
	Negative 	<= TempOutput(31);
	Output 		<= TempOutput;
end rtl;
