library ieee;
use ieee.std_logic_1164.all;

entity Mux32_2to1 is
	port(	input: in std_logic_vector(63 downto 0);
			sel:	in std_logic;
			output:	out std_logic_vector(31 downto 0));
end Mux32_2to1;

architecture rtl of Mux32_2to1 is

begin
	gen: for i in 0 to 1 generate
		Mux2to1: entity work.Mux2to1 port map(	
			input(0)	=>	input(i),
			input(1)	=>	input(i+32),
			sel			=>	sel,
			output		=>	output(i));
	end generate gen;
end rtl;
