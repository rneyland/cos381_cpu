library ieee;
use ieee.std_logic_1164.all;

entity ALU is
	port(	Value1, Value2:	in 	std_logic_vector(31 downto 0);
			Operation: 		in 	std_logic_vector(3  downto 0);
			ValueOut:		out std_logic_vector(31 downto 0);
			Overflow, Negative, Zero, CarryOut: out std_logic);
end ALU;

architecture rtl of ALU is 
    signal Outputs: 			std_logic_vector(511 downto 0);
   	signal Negatives, Carries:	std_logic_vector(15  downto 0);
	signal FinalOutput:			std_logic_vector(31  downto 0);
	signal ZeroOut16: 			std_logic_vector(15  downto 0);
	signal ZeroOut8: 			std_logic_vector(7   downto 0);
	signal ZeroOut4: 			std_logic_vector(3 	 downto 0);
	signal FlipSig:				std_logic;
begin
	FlipSig <= not Operation(0) after 5 ps;
	Adder32: entity work.Adder32 port map(Value1, Value2, Operation(2), FlipSig, Outputs(31 downto 0), Overflow, Negatives(0), Carries(0));
	Shift32: entity work.Shift32 port map(Value1, Value2, Operation(0), Outputs(95 downto 64), Negatives(2), Carries(2));
	Less32: entity work.Less32 port map(Value1, Value2, Outputs(191 downto 160), Negatives(5));
	Xor32: entity work.Xor32 port map(Value1, Value2, Outputs(287 downto 256), Negatives(8));
	Nor32: entity work.Nor32 port map(Value1, Value2, Outputs(319 downto 288), Negatives(9));
	Nand32: entity work.Nand32 port map(Value1, Value2, Outputs(351 downto 320), Negatives(10));
	Complement32: entity work.Complement32 port map(Value1, Outputs(415 downto 384), Negatives(12));

	Outputs(63  downto 32)	<= Outputs(31 downto 0);
	Outputs(159 downto 128) <= Outputs(31 downto 0);
	Outputs(127 downto 96) 	<= Outputs(95 downto 64);
	-- Outputs(223 downto 192) <= "0000000000000000000000000000000000000000000000000000000000000000";
	-- Outputs(511 downto 416) <= "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";

	Carries(1) <= Carries(0);
	Carries(3) <= Carries(2);
	Carries(4) <= Carries(0);
	Carries(15 downto 5) <= "00000000000";


	Negatives(1) <= Negatives(0);
	Negatives(3) <= Negatives(2);
	Negatives(4) <= Negatives(0);

	MuxOutputs: entity work.Mux512to32 port map(Outputs, Operation, FinalOutput);
	MuxCarries: entity work.Mux16to1 port map(Carries, Operation, CarryOut);
	MuxNegatives: entity work.Mux16to1 port map(Negatives, Operation, Negative);


	-- Checks if output value is zero
	ZeroCheck: for i in 0 to 31 generate
		-- 32 to 16 bits
		NorsA: if (i < 15) generate
			Nor2: entity work.Nor2 port map(FinalOutput(i+1 downto i), FinalOutput(i+17 downto i+16), ZeroOut16(i+1 downto i));
		end generate NorsA;
		-- 16 to 8 bits
		Nands: if (i < 7) generate
			Nand2: entity work.Nand2 port map(ZeroOut16(i+1 downto i), ZeroOut16(i+9 downto i+8), ZeroOut8(i+1 downto i));
		end generate Nands;
		-- 8 to 4 bits
		NorsB: if (i < 3) generate
			Nor2: entity work.Nor2 port map(ZeroOut8(i+1 downto i), ZeroOut8(i+5 downto i+4), ZeroOut4(i+1 downto i));
		end generate NorsB;
	end generate ZeroCheck;

	Zero <= ZeroOut4(0) and ZeroOut4(1) and ZeroOut4(2) and ZeroOut4(3);
	ValueOut <= FinalOutput;

end rtl;

