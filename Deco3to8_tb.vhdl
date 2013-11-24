library ieee;
use ieee.std_logic_1164.all;

entity deco3to8_tb is
end deco3to8_tb;

architecture test of deco3to8_tb is
    signal input:   std_logic_vector(2 downto 0);
    signal enable:  std_logic;
    signal output:  std_logic_vector(7 downto 0);

begin
    deco: entity work.deco3to8(rtl) port map (input, enable, output);

    process
        type pattern_type is record
            input:  std_logic_vector(2 downto 0);
            enable: std_logic;
            output: std_logic_vector(7 downto 0);
        end record;

        type pattern_array is array (natural range <>) of pattern_type;

        constant patterns: pattern_array :=
            (("000", '1', "00000001"),
             ("001", '1', "00000010"),
             ("010", '1', "00000100"),
             ("011", '1', "00001000"),
             ("100", '1', "00010000"),
             ("101", '1', "00100000"),
             ("110", '1', "01000000"),
             ("111", '1', "10000000"));

    begin
        for i in patterns'range loop
            input   <=  patterns(i).input;
            enable  <=  patterns(i).enable;

            wait for 1 ns;

            assert output = patterns(i).output
                report "bad rtl output value" severity error;

        end loop;

        assert false report "end of test" severity note;

        wait;
    end process;
end test;
