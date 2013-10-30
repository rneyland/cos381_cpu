library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
	port
	(
		input:	in std_logic_vector(3 downto 0);
		sel:	in std_logic_vector(1 downto 0);
		output:	out std_logic
	);
end mux4to1;

architecture rtl of mux4to1 is
	component mux2to1
		port
		(
			input:	in std_logic_vector(1 downto 0);
			sel:	in std_logic;
			output: out std_logic
		);
	end component;
	
	signal layer: std_logic_vector(1 downto 0);

begin
	muxa: mux2to1 port map
	(
		input 	=>	input(1 downto 0),
		sel 	=>	sel(0),
		output	=>	layer(0)	
	);
	
	muxb: mux2to1 port map
	(
		input	=>	input(3 downto 2),
		sel		=>	sel(0),
		output	=>	layer(1)
	);
	
	muxc: mux2to1 port map
	(
		input	=>	layer,
		sel		=>	sel(1),
		output	=> 	output
	);	
end rtl;
