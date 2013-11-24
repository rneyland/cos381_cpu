library ieee;
use ieee.std_logic_1164.all;

entity Adder32 is
	port(	A, B:				in 	std_logic_vector(31 downto 0);
			CarryIn, Sig: 		in 	std_logic;
			Sum: 				out std_logic_vector(31 downto 0);
			Overflow, Negative, CarryOut:	out std_logic);
end Adder32;

architecture rtl of Adder32 is 
	signal TempSum, XorB, CarryLast:	std_logic_vector(31 downto 0);
begin
	-- generate chain of full adders
	Adders: for i in 0 to 31 generate
		XorB(i) <= B(i) xor CarryIn;
		-- first full adder to take CarryIn
		FirstAdder: if (i = 0) generate
			FullAdder: entity work.FullAdder port map(A(i), XorB(i), CarryIn, TempSum(i), CarryLast(i)); 
		end generate FirstAdder;
		-- remaining adders
		Adders: if (i > 0) generate 
			FullAdder: entity work.FullAdder port map(A(i), XorB(i), CarryLast(i-1), TempSum(i), CarryLast(i));
		end generate Adders;
	end generate Adders; 
	Overflow 	<= (CarryLast(31) xor (CarryLast(30) and Sig)) after 10 ps;
	CarryOut 	<= (CarryLast(31) and not Sig) or (CarryLast(30) and Sig) after 15 ps;
	Negative 	<= TempSum(31) and Sig after 5 ps;
	Sum 		<= TempSum;
end rtl;


