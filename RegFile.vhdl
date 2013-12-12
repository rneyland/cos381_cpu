library ieee;
use ieee.std_logic_1164.all;

entity RegFile is
	port(	Reg1, Reg2, WriteReg: in std_logic_vector(4 downto 0);
			WE, Clock: in std_logic;
			WriteData: in std_logic_vector(31 downto 0);
			Read1Data, Read2Data: out std_logic_vector(31 downto 0));
end RegFile;

architecture rtl of RegFile is
	signal Data:	std_logic_vector(1023 downto 0);
	signal Decoded: std_logic_vector(31 downto 0);
	
begin
	Reg32: entity work.Reg32 port map(
		D		=>	"00000000000000000000000000000000",
		Clock	=> 	Clock,
		We		=>	'1',
		Q		=>	Data(31 downto 0));

	gen: for i in 1 to 31 generate
		Reg32: entity work.Reg32 port map(
			D 		=> 	WriteData,
			Clock	=>	Clock,
			We 		=>	Decoded(i),
			Q		=>	Data((((i+1)*32)-1) downto (i*32)));
	end generate gen;
	
	Deco5to32: entity work.Deco5to32 port map(
		Input 	=> 	WriteReg,
		Enable	=> 	WE,
		Output	=>	Decoded);

	Mux3232to1: entity work.Mux32_32to1 port map(
		Input	=>	Data,
		Sel		=>	Reg1,
		Output	=>	Read1Data);

	Mux3232to1: Mux3232to1 port map(
		Input	=>	Data,
		Sel		=>	Reg2,
		Output	=>	Read2Data);		
end rtl;


