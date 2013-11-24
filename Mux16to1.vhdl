library ieee;
use ieee.std_logic_1164.all;

entity Mux16to1 is
	port(	Input:	in 	std_logic_vector(15 downto 0);
			Sel:	in 	std_logic_vector(3 downto 0);
			Output:	out std_logic);
end Mux16to1;

architecture rtl of Mux16to1 is
	signal Layer: std_logic_vector(3 downto 0);
begin
	MuxA: entity work.Mux4to1 port map(Input(3 	downto 	0), Sel(1 downto 0), Layer(0));
	MuxB: entity work.Mux4to1 port map(Input(7 	downto 	4), Sel(1 downto 0), Layer(1));
	MuxC: entity work.Mux4to1 port map(Input(11 downto 	8), Sel(1 downto 0), Layer(2));
	MuxD: entity work.Mux4to1 port map(Input(15 downto 12), Sel(1 downto 0), Layer(3));
	MuxE: entity work.Mux4to1 port map(Layer, Sel(3 Downto 2), Output);
end rtl;
