library ieee;
use ieee.std_logic_1164.all;

entity Nor4 is
	port(	A, B:	in 	std_logic_vector(3 downto 0);
			Output:	out std_logic_vector(3 downto 0));
end Nor4;

architecture rtl of Nor4 is 
begin
	Output(0) <= not (A(0) or B(0)) after 10 ps;
	Output(1) <= not (A(1) or B(1)) after 10 ps;
	Output(2) <= not (A(2) or B(2)) after 10 ps;
	Output(3) <= not (A(3) or B(3)) after 10 ps;	
end rtl;
