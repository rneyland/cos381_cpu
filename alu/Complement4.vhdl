library ieee;
use ieee.std_logic_1164.all;

entity Complement4 is
	port(	A:		in 	std_logic_vector(3 downto 0);
			Output:	out std_logic_vector(3 downto 0));
end Complement4;

architecture rtl of Complement4 is 
begin
	Output(0) <= (not A(0)) after 5 ps;	
	Output(1) <= (not A(1)) after 5 ps;	
	Output(2) <= (not A(2)) after 5 ps;	
	Output(3) <= (not A(3)) after 5 ps;	
end rtl;
