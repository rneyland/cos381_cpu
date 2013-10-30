library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end ALU_tb;

architecture test of ALU_tb is
    signal Value1, Value2, ValueOut: std_logic_vector(31 downto 0);
	signal Operation: std_logic_vector(3 downto 0);
	signal Overflow, Negative, Zero, CarryOut: std_logic;
begin
    ALU: entity work.ALU(rtl) port map(Value1, Value2, Operation, ValueOut, Overflow, Negative, Zero, CarryOut);
    process
        type PatternType is record
            Value1, Value2: std_logic_vector(31 downto 0);
			Operation: 		std_logic_vector(3 	downto 0);
			ValueOut: 		std_logic_vector(31 downto 0);
			Overflow, Negative, Zero, CarryOut: std_logic;
        end record;
        type PatternArray is array (natural range <>) of PatternType;
        constant Patterns: PatternArray := 
        	 -- adds/subs
            (("00000000000000000000000000000001", "00000000000000000000000000000001", "0000", "00000000000000000000000000000010", '0', '0', '0', '0'),
			 ("10000000000000000000000000000000", "10000000000000000000000000000000", "0000", "00000000000000000000000000000000", '1', '0', '1', '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000001", "0001", "00000000000000000000000000000010", '0', '0', '0', '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000010", "0100", "11111111111111111111111111111111", '0', '1', '0', '0'),


			 ("00000000000000000000000000000001", "10000000000000000000000000000000", "0100", "10000000000000000000000000000001", '1', '1', '0', '1'),
			 ("11111111111111111111111111111111", "00000000000000000000000000000001", "0100", "11111111111111111111111111111110", '0', '0', '0', '1'),
			 -- shifts
			 ("00000000000000000000000000000001", "00000000000000000000000000000001", "0010", "00000000000000000000000000000010", '0', '0', '0', '0'),
			 ("00100000000000000000000000000000", "00000000000000000000000000000011", "0010", "00000000000000000000000000000000", '0', '0', '1', '1'),
			 ("00000000000000000000000000000010", "00000000000000000000000000000001", "0011", "00000000000000000000000000000001", '0', '0', '0', '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000001", "0011", "00000000000000000000000000000000", '0', '0', '1', '1'),


			 ("00000000000000000000000000000010", "00000000000000000000000000000001", "0101", "00000000000000000000000000000001", '0', '0', '0', '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000010", "0101", "00000000000000000000000000000000", '0', '0', '1', '0'),
			 ("10000000000000000000000000000000", "00000000000000000000000000000000", "1000", "10000000000000000000000000000000", '0', '1', '0', '0'),
			 ("00000000000000000000000000000000", "00000000000000000000000000000001", "1001", "11111111111111111111111111111110", '0', '1', '0', '0'),
			 ("10000000000000000000000000000000", "10000000000000000000000000000000", "1010", "01111111111111111111111111111111", '0', '0', '0', '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000000", "1100", "11111111111111111111111111111110", '0', '1', '0', '0'));
    begin
        for i in Patterns'range loop
            Value1   	<= Patterns(i).Value1;
			Value2   	<= Patterns(i).Value2;
			Operation	<= Patterns(i).Operation;
            wait for 1 ns;
            assert ValueOut = Patterns(i).ValueOut
                report "bad ValueOut bits" severity error;
            assert Overflow = Patterns(i).Overflow
            	report "bad Overflow bit" severity error;
			assert Negative = Patterns(i).Negative
				report "bad Negative bit" severity error;
			assert Zero = Patterns(i).Zero
				report "bad Zero bit" severity error;
			assert CarryOut = Patterns(i).CarryOut
				report "bad CarryOut bit" severity error;
        end loop;
        assert false report "end of test" severity note;
        wait;
    end process;
end test;
