library ieee;
use ieee.std_logic_1164.all;

entity Less32_tb is
end Less32_tb;

architecture Test of Less32_tb is
    signal A, B, Output: std_logic_vector(31 downto 0);
begin
    Less32: entity work.Less32(rtl) port map (A, B, Output);
    process
        type PatternType is record
            A, B, Output:   std_logic_vector(31 downto 0);
        end record;
        type PatternArray is array (natural range <>) of PatternType;
        constant Patterns: PatternArray := 
            (("00000000000000000000000000000010", "00000000000000000000000000000001", "00000000000000000000000000000001"),
			 ("00000000000000000000000000000001", "00000000000000000000000000000010", "00000000000000000000000000000000"));
    begin
        for i in Patterns'range loop
            A <= Patterns(i).A;
			B <= Patterns(i).B;
			wait for 1 ns;
            assert Output = Patterns(i).Output
                report "bad Output bits" severity error;
        end loop;
        assert false report "end of test" severity note;
        wait;
    end process;
end Test;
