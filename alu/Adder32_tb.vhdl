library ieee;
use ieee.std_logic_1164.all;

entity Adder32_tb is
end Adder32_tb;

architecture Test of Adder32_tb is
    signal A, B, Sum: std_logic_vector(31 downto 0);
    signal CarryIn, Sig, Overflow, Negative, CarryOut:	std_logic;


begin
    Adder32: entity work.Adder32(rtl) port map (A, B, CarryIn, Sig, Sum, Overflow, Negative, CarryOut);
    process
        type PatternType is record
            A, B: 				std_logic_vector(31 downto 0);
			CarryIn, Sig:		std_logic;
			Sum:				std_logic_vector(31 downto 0);
            Overflow, Negative, CarryOut: std_logic;
        end record;
        type PatternArray is array (natural range <>) of PatternType;
        constant Patterns: PatternArray := 
            (("00000000000000000000000000000000", "00000000000000000000000000000000", '0', '0', "00000000000000000000000000000000", '0', '0', '0'),
             ("00000000000000000000000000000000", "00000000000000000000000000000001", '0', '0', "00000000000000000000000000000001", '0', '0', '0'),
             ("00000000000000000000000000000001", "00000000000000000000000000000001", '0', '0', "00000000000000000000000000000010", '0', '0', '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000001", '1', '1', "00000000000000000000000000000000", '0', '0', '0'),
			 ("00000000000000000000000000000011", "00000000000000000000000000000001", '1', '1', "00000000000000000000000000000010", '0', '0', '0'),
             ("01000000000000000000000000000000", "00000000000000000000000000000001", '1', '1', "00111111111111111111111111111111", '0', '0', '0'),
			 ("00000000000000000000000000000000", "00000000000000000000000000000001", '1', '1', "11111111111111111111111111111111", '0', '1', '0'),
			 ("10000000000000000000000000000000", "10000000000000000000000000000000", '0', '1', "00000000000000000000000000000000", '1', '0', '0'),
			 ("11111111111111111111111111111111", "00000000000000000000000000000001", '0', '0', "00000000000000000000000000000000", '1', '0', '0'));
	begin
        for i in Patterns'range loop
            A       <= Patterns(i).A;
            B       <= Patterns(i).B;
            CarryIn <= Patterns(i).CarryIn;
			Sig     <= Patterns(i).Sig;
            wait for 1 ns;
            assert Sum = Patterns(i).Sum
                report "bad Sum bits" severity error;
            assert Overflow = Patterns(i).Overflow
                report "bad Overflow bit" severity error;
            assert Negative = Patterns(i).Negative
                report "bad Negative bit" severity error;
        end loop;
        assert false report "end of test" severity note;
        wait;
    end process;
end Test;
