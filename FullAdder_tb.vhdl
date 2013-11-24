library ieee;
use ieee.std_logic_1164.all;

entity FullAdder_tb is
end FullAdder_tb;

architecture Test of FullAdder_tb is
    signal A, B, CarryIn, Sum, CarryOut: std_logic;
begin
    FullAdder: entity work.FullAdder(rtl) port map (A, B, CarryIn, Sum, CarryOut);
    process
        type PatternType is record
            A, B, CarryIn, Sum, CarryOut: std_logic;
        end record;
        type PatternArray is array (natural range <>) of PatternType;
        constant Patterns: PatternArray := 
            (('0', '0', '0', '0', '0'),
             ('0', '0', '1', '1', '0'),
             ('0', '1', '0', '1', '0'),
             ('0', '1', '1', '0', '1'),
             ('1', '0', '0', '1', '0'),
             ('1', '0', '1', '0', '1'),
             ('1', '1', '0', '0', '1'),
             ('1', '1', '1', '1', '1'));
    begin
        for i in Patterns'range loop
            A       <= Patterns(i).A;
            B       <= Patterns(i).B;
            CarryIn <= Patterns(i).CarryIn;
            wait for 1 ns;
            assert Sum = Patterns(i).Sum
                report "bad Sum bit" severity error;
            assert CarryOut = Patterns(i).CarryOut
                report "bad CarryOut bit" severity error;
        end loop;
        assert false report "end of test" severity note;
        wait;
    end process;
end Test;
