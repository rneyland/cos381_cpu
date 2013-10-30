library ieee;
use ieee.std_logic_1164.all;

entity mux4to1_tb is
end mux4to1_tb;

architecture test of mux4to1_tb is
    signal input:   std_logic_vector(3 downto 0);
    signal sel:     std_logic_vector(1 downto 0);
    signal output:  std_logic;

begin
    mux: entity work.mux4to1(rtl) port map (input, sel, output);

    process
        type pattern_type is record
            input:  std_logic_vector(3 downto 0);
            sel:  std_logic_vector(1 downto 0);
            output: std_logic;
        end record;

        type pattern_array is array (natural range <>) of pattern_type;

        constant patterns: pattern_array :=
            (("1000", "00", '0'),
             ("0100", "01", '0'),
             ("0010", "10", '0'),
             ("0001", "11", '0'));

    begin
        for i in patterns'range loop
            input <= patterns(i).input;
            sel <= patterns(i).sel;

            wait for 1 ns;

            assert output = patterns(i).output
                report "bad rtl output value" severity error;

        end loop;

        assert false report "end of test" severity note;

        wait;
    end process;
end test;
