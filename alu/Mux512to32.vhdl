library ieee;
use ieee.std_logic_1164.all;

entity Mux512to32 is
	port(	Input:	in 	std_logic_vector(511 downto 0);
			Sel:	in 	std_logic_vector(3 downto 0);
			Output:	out std_logic_vector(31 downto 0));
end Mux512to32;

architecture rtl of Mux512to32 is
begin
	Muxes: for i in 0 to 31 generate
		Mux16to1: entity work.Mux16to1 port map(
			Input(0)	=>	Input(i+0),
			Input(1)	=>	Input(i+32),
			Input(2)	=>	Input(i+64),
			Input(3)	=>	Input(i+96),
			Input(4)	=>	Input(i+128),
			Input(5)	=>	Input(i+160),
			Input(6)	=>	Input(i+192),
			Input(7)	=>	Input(i+224),
			Input(8)	=>	Input(i+256),
			Input(9)	=>	Input(i+288),
			Input(10)	=>	Input(i+320),
			Input(11)	=>	Input(i+352),
			Input(12)	=>	Input(i+384),
			Input(13)	=>	Input(i+416),
			Input(14)	=>	Input(i+448),
			Input(15)	=>	Input(i+480),
			Sel			=> 	Sel,
			Output		=>	Output(i));
	end generate Muxes;
end rtl;
