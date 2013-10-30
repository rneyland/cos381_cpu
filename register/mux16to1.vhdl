library ieee;
use ieee.std_logic_1164.all;

entity mux16to1 is
	port
	(
		input:	in std_logic_vector(15 downto 0);
		sel:	in std_logic_vector(3 downto 0);
		output:	out std_logic
	);
end mux16to1;

architecture rtl of mux16to1 is
	component mux4to1
		port
		(
			input:	in std_logic_vector(3 downto 0);
			sel:	in std_logic_vector(1 downto 0);
			output: out std_logic
		);
	end component;
	
	signal layer: std_logic_vector(3 downto 0);

begin
	muxa: mux4to1 port map
	(
		input 	=>	input(3 downto 0),
		sel		=>	sel(1 downto 0),
		output	=>	layer(0)	
	);
	
	muxb: mux4to1 port map
	(
		input	=>	input(7 downto 4),
		sel		=>	sel(1 downto 0),
		output	=>	layer(1)
	);
	
	muxc: mux4to1 port map
	(
		input	=>	input(11 downto 8),
		sel		=>	sel(1 downto 0),
		output	=>  layer(2)
	);
	
	muxd: mux4to1 port map
	(
		input	=>	input(15 downto 12),
		sel		=>	sel(1 downto 0),
		output	=>	layer(3)
	);
	
	muxe: mux4to1 port map
	(
		input	=>	layer,
		sel		=>	sel(3 downto 2),
		output	=>	output
	);
end rtl;
