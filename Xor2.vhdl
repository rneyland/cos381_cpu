library ieee;
use ieee.std_logic_1164.all;

entity Xor2 is
	port(	A, B:	in 	std_logic_vector(1 downto 0);
			Output:	out std_logic_vector(1 downto 0));
end Xor2;

architecture rtl of Xor2 is 
begin
	Output(0) <= (A(0) and not B(0)) or (not A(0) and B(0)) after 15 ps;	
	Output(1) <= (A(1) and not B(1)) or (not A(1) and B(1)) after 15 ps;
end rtl;
