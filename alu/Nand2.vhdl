library ieee;
use ieee.std_logic_1164.all;

entity Nand2 is
	port(	A, B:	in 	std_logic_vector(1 downto 0);
			Output:	out std_logic_vector(1 downto 0));
end Nand2;

architecture rtl of Nand2 is 
begin
	Output(0) <= not (A(0) and B(0)) after 10 ps;
	Output(1) <= not (A(1) and B(1)) after 10 ps;	
end rtl;
