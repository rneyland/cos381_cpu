library ieee;
use ieee.std_logic_1164.all;

entity Mux4to1 is
	port(	Input:	in 	std_logic_vector(3 downto 0);
			Sel:	in 	std_logic_vector(1 downto 0);
			Output:	out std_logic);
end Mux4to1;

architecture rtl of Mux4to1 is
	signal Layer: std_logic_vector(1 downto 0);
begin
	MuxA: entity work.Mux2to1 port map(Input(1 downto 0), Sel(0), Layer(0));	
	MuxB: entity work.Mux2to1 port map(Input(3 downto 2), Sel(0), Layer(1));
	MuxC: entity work.Mux2to1 port map(Layer, Sel(1), Output);	
end rtl;
