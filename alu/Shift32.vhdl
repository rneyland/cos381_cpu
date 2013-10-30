library ieee;
use ieee.std_logic_1164.all;

entity Shift32 is
    port(	Input, Amount:          in 	std_logic_vector(31 downto 0);
        	Right:			        in 	std_logic;
        	Output: 		        out std_logic_vector(31 downto 0);
			Negative, CarryOut:		out std_logic);
end Shift32;

architecture rtl of Shift32 is
    type 	LayerArray is array(6 downto 0) of std_logic_vector(31 downto 0);
    signal 	Layers:			LayerArray;
	signal 	AmountFlipped:	std_logic_vector(4 downto 0);
	signal 	TempCarryOut:	std_logic;
begin
	-- flip input if right shift
	MuxFlipStart: for h in 0 to 31 generate
		Mux2to1: entity work.Mux2to1 port map(
			Input(0)	=> Input(h), 
			Input(1)	=> Input(31-h),
			Sel			=> Right,
			Output		=> Layers(0)(h));
	end generate MuxFlipStart;
	-- first layer
    MuxLayer1: for i in 0 to 31 generate 
        MuxFirst: if (i = 0) generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(0)(i),
                Input(1)    =>  '0',
                Sel         =>  Amount(0),
                Output      =>  Layers(1)(i));
        end generate MuxFirst;
        MuxOther: if i > 0 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(0)(i),
                Input(1)    =>  Layers(0)(i-1),
                Sel         =>  Amount(0),
                Output      =>  Layers(1)(i));
        end generate MuxOther;
    end generate MuxLayer1;
    -- second layer
    MuxLayer2: for j in 0 to 31 generate 
        MuxFirst: if j < 2 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(1)(j),
                Input(1)    =>  '0',
                Sel         =>  Amount(1),
                Output      =>  Layers(2)(j));
        end generate MuxFirst;
        MuxOther: if j >= 2 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(1)(j),
                Input(1)    =>  Layers(1)(j-2),
                Sel         =>  Amount(1),
                Output      =>  Layers(2)(j));
        end generate MuxOther;
    end generate MuxLayer2;
    -- third layer
    MuxLayer3: for k in 0 to 31 generate 
        MuxFirst: if k < 4 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(2)(k),
                Input(1)    =>  '0',
                Sel         =>  Amount(2),
                Output      =>  Layers(3)(k));
        end generate MuxFirst;
        MuxOther: if k >= 4 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(2)(k),
                Input(1)    =>  Layers(2)(k-4),
                Sel         =>  Amount(2),
                Output      =>  Layers(3)(k));
        end generate MuxOther;
    end generate MuxLayer3;
    -- fourth layer
    MuxLayer4: for l in 0 to 31 generate 
        MuxFirst: if l < 8 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(3)(l),
                Input(1)    =>  '0',
                Sel         =>  Amount(3),
                Output      =>  Layers(4)(l));
        end generate MuxFirst;
        MuxOther: if l >= 8 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(3)(l),
                Input(1)    =>  Layers(3)(l-8),
                Sel         =>  Amount(3),
                Output      =>  Layers(4)(l));
        end generate MuxOther;
    end generate MuxLayer4;
    -- fifth layer
    MuxLayer5: for m in 0 to 31 generate 
        MuxFirst: if m < 16 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(4)(m),
                Input(1)    =>  '0',
                Sel         =>  Amount(4),
                Output      =>  Layers(5)(m));
        end generate MuxFirst;
        MuxOther: if m >= 16 generate
            Mux2to1: entity work.Mux2to1 port map(
                Input(0)    =>  Layers(4)(m),
                Input(1)    =>  Layers(4)(m-16),
                Sel         =>  Amount(4),
                Output      =>  Layers(5)(m));
        end generate MuxOther;
    end generate MuxLayer5;
    -- flip output if right shift
	MuxFlipEnd: for n in 0 to 31 generate
		Mux2to1: entity work.Mux2to1 port map(
			Input(0)	=>	Layers(5)(n),
			Input(1)	=>	Layers(5)(31-n),
			Sel			=>	Right,
			Output		=>	Layers(6)(n));
	end generate MuxFlipEnd;
	-- flip amount bits except for lsb
	AmountFlipped(0) <= Amount(0);
	AmountFlipped(1) <= not Amount(1);
	AmountFlipped(2) <= not Amount(2);
	AmountFlipped(3) <= not Amount(3);
	AmountFlipped(4) <= not Amount(4);
	-- find shifted lsb 
	Mux32to1: entity work.Mux32to1 port map(
		Input 	=> Layers(0), 
		Sel 	=> AmountFlipped,
		Output	=> TempCarryOut);
	-- no CarryOut when nothing is shifted
    Output      <= Layers(6);
    Negative    <= Layers(6)(31);
	CarryOut    <= (TempCarryOut and ((Amount(0) or Amount(1) or Amount(2)) or (Amount(3) or Amount(4)))) after 20 ps;
end rtl;
