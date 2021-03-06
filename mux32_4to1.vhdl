library ieee;
use ieee.std_logic_1164.all;

entity Mux32_4to1 is
	port(	input: 	in 	std_logic_vector(128 downto 0);
			sel:	in 	std_logic_vector(1 downto 0);
			output:	out std_logic_vector(31 downto 0));
end Mux32_4to1;

architecture rtl of Mux32_4to1 is

begin
	gen: for i in 0 to 3 generate
		Mux4to1: entity work.Mux4to1 port map(	
			input(0)	=> input(i),
			input(1)	=> input(i+32),
			input(2)	=> input(i+64),
			input(3)	=> input(i+96),
			sel			=> sel,
			output		=> output(i));
	end generate gen;
end rtl;
