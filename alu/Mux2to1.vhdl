library ieee;
use ieee.std_logic_1164.all;

entity Mux2to1 is
	port(	Input:	in 	std_logic_vector(1 downto 0);
			Sel:	in 	std_logic;
			Output:	out std_logic);
end Mux2to1;

architecture rtl of Mux2to1 is
begin
	Output <= (Input(0) and not Sel) or (Input(1) and Sel) after 15 ps;
end rtl;

