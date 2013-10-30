library ieee;
use ieee.std_logic_1164.all;

entity Complement32 is
	port(	A:		in 	std_logic_vector(31 downto 0);
			Output:	out std_logic_vector(31 downto 0);
			Negative:	out std_logic);
end Complement32;

architecture rtl of Complement32 is
	signal TempOutput: std_logic_vector(31 downto 0); 
begin
	Complements: for i in 0 to 28 generate
		Complement4: entity work.Complement4 port map(A(i+3 downto i), TempOutput(i+3 downto i));
	end generate Complements;	
	Negative	<= TempOutput(31);
	Output 		<= TempOutput;
end rtl;
