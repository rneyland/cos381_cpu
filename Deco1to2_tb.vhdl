library ieee;
use ieee.std_logic_1164.all;

entity deco1to2_tb is
end deco1to2_tb;

architecture test of deco1to2_tb is
    signal input:   std_logic;
    signal output:  std_logic_vector(1 downto 0);

begin
    deco: entity work.deco1to2(rtl) port map (input, output);

    process
        type pattern_type is record
            input:  std_logic;
            output: std_logic_vector(1 downto 0);
        end record;

        type pattern_array is array (natural range <>) of pattern_type;

        constant patterns: pattern_array := 
            (('0', "01"),
             ('1', "10"));

    begin
        for i in patterns'range loop
            input <= patterns(i).input;

            wait for 1 ns;

            assert output = patterns(i).output
                report "bad rtl output value" severity error;

        end loop;

        assert false report "end of test" severity note;

        wait;
    end process;
end test;
