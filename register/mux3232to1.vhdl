library ieee;
use ieee.std_logic_1164.all;

entity mux3232to1 is
	port
	(
		input:	in std_logic_vector(1023 downto 0);
		sel:	in std_logic_vector(4 downto 0);
		output:	out std_logic_vector(31 downto 0)
	);
end mux3232to1;

architecture rtl of mux3232to1 is
	component mux32to1
		port
		(
			input:	in std_logic_vector(31 downto 0);
			sel:	in std_logic_vector(4 downto 0);
			output: out std_logic
		);
	end component;

begin
	gen: for i in 0 to 31 generate
		muxi: mux32to1 port map
		(
			input(0)	=>	input(i+0),
			input(1)	=>	input(i+32),
			input(2)	=>	input(i+64),
			input(3)	=>	input(i+96),
			input(4)	=>	input(i+128),
			input(5)	=>	input(i+160),
			input(6)	=>	input(i+192),
			input(7)	=>	input(i+224),
			input(8)	=>	input(i+256),
			input(9)	=>	input(i+288),
			input(10)	=>	input(i+320),
			input(11)	=>	input(i+352),
			input(12)	=>	input(i+384),
			input(13)	=>	input(i+416),
			input(14)	=>	input(i+448),
			input(15)	=>	input(i+480),
			input(16)	=>	input(i+512),
			input(17)	=>	input(i+544),
			input(18)	=>	input(i+576),
			input(19)	=>	input(i+608),
			input(20)	=>	input(i+640),
			input(21)	=>	input(i+672),
			input(22)	=>	input(i+704),
			input(23)	=>	input(i+736),
			input(24)	=>	input(i+768),
			input(25)	=>	input(i+800),
			input(26)	=>	input(i+832),
			input(27)	=>	input(i+864),
			input(28)	=>	input(i+896),
			input(29)	=>	input(i+928),
			input(30)	=>	input(i+960),
			input(31)	=>	input(i+992),
			sel		=>	sel,
			output	=>	output(i)
		);
	end generate gen;
end rtl;
