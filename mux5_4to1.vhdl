library ieee;
use ieee.std_logic_1164.all;

entity Mux5_4to1 is
	port(	input: 	in 	std_logic_vector(95 downto 0);
			sel:	in 	std_logic_vector(1 downto 0);
			output:	out std_logic_vector(31 downto 0));
end Mux5_4to1;

architecture rtl of Mux5_4to1 is

begin
	gen: for i in 0 to 3 generate
		Mux4to1: entity work.Mux4to1 port map(	
			input(0)	=> input(i),
			input(1)	=> input(i+5),
			input(2)	=> input(i+10),
			input(3)	=> "00000",
			sel			=> sel,
			output		=> output(i));
	end generate gen;
end rtl;
