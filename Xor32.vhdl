library ieee;
use ieee.std_logic_1164.all;

entity Xor32 is
	port(	A, B:		in 	std_logic_vector(31 downto 0);
			Output:		out std_logic_vector(31 downto 0);
			Negative: 	out std_logic);
end Xor32;

architecture rtl of Xor32 is 
	signal TempOutput: std_logic_vector(31 downto 0);
begin
	-- takes 2 bits from both inputs and xor's them
	Xors: for i in 0 to 30 generate
		Xor2: entity work.Xor2 port map(A(i+1 downto i), B(i+1 downto i), TempOutput(i+1 downto i));
	end generate Xors;	
	Negative 	<= TempOutput(31);
	Output 		<= TempOutput;
end rtl;
