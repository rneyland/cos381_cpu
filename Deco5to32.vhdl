library ieee;
use ieee.std_logic_1164.all;

entity deco5to32 is
	port
	(
		input:	in 	std_logic_vector(4 downto 0);
		enable:	in 	std_logic;
		output:	out std_logic_vector(31 downto 0)
	);
end deco5to32;

architecture rtl of deco5to32 is
	component deco2to4
		port
		(
			input:	in 	std_logic_vector(1 downto 0);
			enable:	in 	std_logic;
			output:	out std_logic_vector(3 downto 0)
		);
	end component;
	
	component deco3to8
		port 
		(
			input:	in 	std_logic_vector(2 downto 0);
			enable:	in 	std_logic;
			output:	out std_logic_vector(7 downto 0)
		);
	end component;
	
	signal enabledout: std_logic_vector(3 downto 0);
	
begin
	decoa: deco2to4 port map
	(
		input	=>	input(4 downto 3),
		enable	=> 	enable,
		output	=>	enabledout	
	);
	
	decob: deco3to8 port map
	(
		input	=>	input(2 downto 0),
		enable	=>	enabledout(0),
		output	=>	output(7 downto 0)
	);
	
	decoc: deco3to8 port map
	(
		input	=>	input(2 downto 0),
		enable	=> 	enabledout(1),
		output	=>	output(15 downto 8)
	);
	
	decod: deco3to8 port map
	(
		input	=>	input(2 downto 0),
		enable	=> 	enabledout(2),
		output	=>	output(23 downto 16)
	);
	
	decoe: deco3to8 port map
	(
		input	=>	input(2 downto 0),
		enable	=> 	enabledout(3),
		output	=>	output(31 downto 24)
	);	
end rtl;
