library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(	A, B, CarryIn: in std_logic;
			Sum, CarryOut: out std_logic);
end FullAdder;

architecture rtl of FullAdder is 
begin
		Sum			<= A xor B xor CarryIn after 10 ps;	 	
		CarryOut 	<= ((A xor B) and CarryIn) or (A and B) after 15 ps;
end rtl;