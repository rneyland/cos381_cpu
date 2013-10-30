library ieee;
use ieee.std_logic_1164.all;

entity deco2to4_tb is
end deco2to4_tb;

architecture test of deco2to4_tb is
    signal input:   std_logic_vector(1 downto 0);
    signal enable:  std_logic;
    signal output:  std_logic_vector(3 downto 0);

begin
    deco: entity work.deco2to4(rtl) port map (input, enable, output);

    process
        type pattern_type is record
            input:  std_logic_vector(1 downto 0);
            enable: std_logic;
            output: std_logic_vector(3 downto 0);
        end record;

        type pattern_array is array (natural range <>) of pattern_type;

        constant patterns: pattern_array :=
            (("00", '1', "0001"),
             ("01", '1', "0010"),
             ("10", '1', "0100"),
             ("11", '1', "1000"));

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
