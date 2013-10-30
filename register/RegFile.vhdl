library ieee;
use ieee.std_logic_1164.all;

entity RegFile is
	port
	(
		reg1, reg2, writeReg: in std_logic_vector(4 downto 0);
		we, clock: in std_logic;
		writeData: in std_logic_vector(31 downto 0);
		read1Data, read2Data: out std_logic_vector(31 downto 0)
	);
end RegFile;

architecture rtl of RegFile is
	component deco5to32
		port
		(
			input:	in std_logic_vector(4 downto 0);
			enable:	in std_logic;
			output:	out std_logic_vector(31 downto 0)
		);
	end component;

	component mux3232to1 
		port
		(
			input:	in std_logic_vector(1023 downto 0);
			sel:	in std_logic_vector(4 downto 0);
			output:	out std_logic_vector(31 downto 0)
		);
	end component;
	
	component reg32
		port
		(
			d:		in	std_logic_vector(31 downto 0);
			clock:	in 	std_logic;
			we:		in 	std_logic;
			q:		out	std_logic_vector(31 downto 0)
		);
	end component;
	
	signal qArray:	std_logic_vector(1023 downto 0);
	signal decoded: std_logic_vector(31 downto 0);
	
begin
	reg0: reg32 port map
	(
		d		=>	"00000000000000000000000000000000",
		clock	=> 	clock,
		we		=>	'1',
		q		=>	qArray(31 downto 0)
	);

	gen: for i in 1 to 31 generate
		registers: reg32 port map
		(
			d 		=> 	writeData,
			clock	=>	clock,
			we 		=>	decoded(i),
			q		=>	qArray((((i+1)*32)-1) downto (i*32))
		);
	end generate gen;
	
	decoA: deco5to32 port map
	(
		input 	=> 	writeReg,
		enable	=> 	we,
		output	=>	decoded
	);

	muxA: mux3232to1 port map
	(
		input	=>	qArray,
		sel		=>	reg1,
		output	=>	read1Data
	);

	muxB: mux3232to1 port map
	(
		input	=>	qArray,
		sel		=>	reg2,
		output	=>	read2Data
	);		
end rtl;


