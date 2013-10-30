library ieee;
use ieee.std_logic_1164.all;

entity Nor2 is
	port(	A, B:	in 	std_logic_vector(1 downto 0);
			Output:	out std_logic_vector(1 downto 0));
end Nor2;

architecture rtl of Nor2 is 
begin
	Output(0) <= not (A(0) or B(0)) after 10 ps;
	Output(1) <= not (A(1) or B(1)) after 10 ps;	
end rtl;
