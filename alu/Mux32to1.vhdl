library ieee;
use ieee.std_logic_1164.all;

entity Mux32to1 is
	port(	Input:	in 	std_logic_vector(31 downto 0);
			Sel:	in 	std_logic_vector(4 downto 0);
			Output:	out std_logic);
end Mux32to1;

architecture rtl of Mux32to1 is
	signal Layer: std_logic_vector(1 downto 0);
begin
	MuxA: entity work.Mux16to1 port map(Input(15 downto  0), Sel(3 downto 0), Layer(0));
	MuxB: entity work.Mux16to1 port map(Input(31 downto 16), Sel(3 downto 0), Layer(1));
	MuxC: entity work.Mux2to1  port map(Layer, Sel(4), Output);
end rtl;
