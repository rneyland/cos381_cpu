library ieee;
use ieee.std_logic_1164.all;

entity RegFile_tb is
end RegFile_tb;

architecture test of RegFile_tb is
    signal reg1, reg2, writeReg: std_logic_vector(4 downto 0);
    signal we, clock: std_logic;
    signal writeData, read1Data, read2Data: std_logic_vector(31 downto 0);

begin
    regfile: entity work.RegFile(rtl) port map (reg1, reg2, writeReg, we, clock, writeData, read1Data, read2Data);

    process  
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;

    process
        type pattern_type is record
            reg1, reg2, writeReg: std_logic_vector(4 downto 0);
            we, clock: std_logic;
            writeData, read1Data, read2Data: std_logic_vector(31 downto 0);
        end record;

        type pattern_array is array (natural range <>) of pattern_type;

        constant patterns: pattern_array :=
            (("00000", "00000", "00001", '1', '1', "00000000000000000000000000000001", "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU", "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU"),
             ("00001", "00001", "00010", '1', '1', "00000000000000000000000000000010", "00000000000000000000000000000001", "00000000000000000000000000000001"),
             ("00001", "00010", "00011", '1', '1', "00000000000000000000000000000011", "00000000000000000000000000000001", "00000000000000000000000000000010"));

    begin
        for i in patterns'range loop
            reg1  <=  patterns(i).reg1;
            reg2  <=  patterns(i).reg2;
            writeReg  <=  patterns(i).writeReg;
            we    <=  patterns(i).we;
            writeData <=  patterns(i).writeData;
        
            wait for 10 ns;

            assert read1Data = patterns(i).read1Data and read2Data = patterns(i).read2Data
                report "bad rtl output value" severity error;

        end loop;

        assert false report "end of test" severity note;  
    
        wait;   
    end process;    
end test;
