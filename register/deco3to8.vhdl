library ieee;
use ieee.std_logic_1164.all;

entity deco3to8 is
	port
	(
		input:	in 	std_logic_vector(2 downto 0);
		enable:	in 	std_logic;
		output:	out std_logic_vector(7 downto 0)
	);
end deco3to8;

architecture rtl of deco3to8 is
	component deco2to4
		port
		(
			input:	in 	std_logic_vector(1 downto 0);
			enable:	in 	std_logic;
			output:	out std_logic_vector(3 downto 0)
		);
	end component;
	
	signal enable1, enable2: std_logic;
	
begin
	enable1	<=	not input(2) and enable after 10 ps;
	enable2	<=	input(2) and enable after 5 ps;
		
	decoa: deco2to4 port map
	(
		input	=>	input(1 downto 0),
		enable	=> 	enable1,
		output	=>	output(3 downto 0)	
	);
	
	decob: deco2to4 port map
	(
		input	=>	input(1 downto 0),
		enable 	=>	enable2,
		output	=>	output(7 downto 4)
	);	
end rtl;

