library ieee;
use ieee.std_logic_1164.all;

entity Nor32 is
	port(	A, B:		in 	std_logic_vector(31 downto 0);
			Output:		out std_logic_vector(31 downto 0);
			Negative:	out std_logic);
end Nor32;

architecture rtl of Nor32 is 
	signal TempOutput: std_logic_vector(31 downto 0);
begin
	-- takes 2 bits from both inputs and nor's them
	Nors: for i in 0 to 30 generate
		Nor2: entity work.Nor2 port map(A(i+1 downto i), B(i+1 downto i), TempOutput(i+1 downto i));
	end generate Nors;	
	Negative	<= TempOutput(31);
	Output 		<= TempOutput;
end rtl;
