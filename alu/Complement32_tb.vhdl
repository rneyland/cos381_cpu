library ieee;
use ieee.std_logic_1164.all;

entity Complement32_tb is
end Complement32_tb;

architecture Test of Complement32_tb is
    signal A, Output: std_logic_vector(31 downto 0);
    signal Negative: std_logic;
begin
    Complement: entity work.Complement32(rtl) port map (A, Output, Negative);
    process
        type PatternType is record
            A, Output:  std_logic_vector(31 downto 0);
            Negative:   std_logic;

        end record;
        type PatternArray is array (natural range <>) of PatternType;
        constant Patterns: PatternArray := 
            (("00000000000000000000000000000000", "11111111111111111111111111111111", '1'),
			 ("11111111111111111111111111111111", "00000000000000000000000000000000", '0'),
			 ("00000000000000000000000000000001", "11111111111111111111111111111110", '1'),
			 ("00000000000000001111111111111111", "11111111111111110000000000000000", '1'));
    begin
        for i in Patterns'range loop
            A   <=  Patterns(i).A;
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
