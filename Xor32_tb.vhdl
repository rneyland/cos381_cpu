library ieee;
use ieee.std_logic_1164.all;

entity Xor32_tb is
end Xor32_tb;

architecture Test of Xor32_tb is
    signal A, B, Output: std_logic_vector(31 downto 0);
    signal Negative: std_logic;
begin
    Xor32: entity work.Xor32(rtl) port map (A, B, Output, Negative);
    process
        type PatternType is record
            A, B, Output:   std_logic_vector(31 downto 0);
            Negative:       std_logic;
        end record;
        type PatternArray is array (natural range <>) of PatternType;
        constant Patterns: PatternArray := 
            (("00000000000000000000000000000000", "00000000000000000000000000000000", "00000000000000000000000000000000", '0'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000000", "00000000000000000000000000000001", '0'),
			 ("10000000000000000000000000000000", "00000000000000000000000000000000", "10000000000000000000000000000000", '1'),
			 ("00000000000000000000000000000001", "00000000000000000000000000000001", "00000000000000000000000000000000", '0'),
			 ("11111111111111111111111111111111", "00000000000000000000000000000000", "11111111111111111111111111111111", '1'),
			 ("11111111111111111111111111111111", "11111111111111111111111111111111", "00000000000000000000000000000000", '0'));
    begin
        for i in Patterns'range loop
            A   <=  Patterns(i).A;
            B   <=  Patterns(i).B;
            wait for 1 ns;
            assert Output = Patterns(i).Output
                report "bad Output bits" severity error;
            assert Negative = Patterns(i).Negative
                report "bad Negative bit" severity error;
        end loop;
        assert false report "end of test" severity note;
        wait;
    end process;
end Test;
