library ieee;
use ieee.std_logic_1164.all;

entity reg32 is
	port
	(
		d:		in	std_logic_vector(31 downto 0);
		clock:	in 	std_logic;
		we:		in 	std_logic;
		q:		out	std_logic_vector(31 downto 0)
	);
end reg32;

architecture rtl of reg32 is
	component dflip
		port 
		(
			d:		in 	std_logic;
			clock:	in 	std_logic;
			we: 	in 	std_logic;
			q:		out std_logic

		);
	end component;

begin
	gen: for i in 0 to 31 generate
		flop: dflip port map
		(
			d 		=>	d(i),
			clock	=> 	clock,
			we		=>	we,
			q 		=>	q(i)
		);
	end generate gen;
end rtl;

