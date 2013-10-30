library ieee;
use ieee.std_logic_1164.all;

entity mux32to1 is
	port
	(
		input:	in std_logic_vector(31 downto 0);
		sel:	in std_logic_vector(4 downto 0);
		output:	out std_logic
	);
end mux32to1;

architecture rtl of mux32to1 is
	component mux16to1
		port
		(
			input:	in std_logic_vector(15 downto 0);
			sel:	in std_logic_vector(3 downto 0);
			output: out std_logic
		);
	end component;
	
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
	muxa: mux16to1 port map
	(
		input 	=>	input(15 downto 0),
		sel		=>	sel(3 downto 0),
		output	=>	layer(0)	
	);
	
	muxb: mux16to1 port map
	(
		input	=>	input(31 downto 16),
		sel		=>	sel(3 downto 0),
		output	=>	layer(1)
	);
	
	muxc: mux2to1 port map
	(
		input	=>	layer,
		sel		=>	sel(4),
		output	=> 	output
	);
end rtl;
