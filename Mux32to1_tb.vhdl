library ieee;
use ieee.std_logic_1164.all;

entity mux32to1_tb is
end mux32to1_tb;

architecture test of mux32to1_tb is
    signal input:	std_logic_vector(31 downto 0);
    signal sel:		std_logic_vector(4 downto 0);
    signal output:	std_logic;
    
begin
    mux: entity work.mux32to1(rtl) port map (input, sel, output);

    process
		type pattern_type is record
	    	input:	std_logic_vector(31 downto 0);
	    	sel:	std_logic_vector(4 downto 0);
	    	output:	std_logic;
		end record;
	
		type pattern_array is array (natural range <>) of pattern_type;
		
		constant patterns: pattern_array :=
			(("00000000000000000000000000000001", "00000", '1'),
			 ("00000000000000000000000000000010", "00001", '1'),
			 ("00000000000000000000000000000100", "00010", '0'),
			 ("00010000000000000000000000000000", "00011", '0'),
			 ("00001000000000000000000000000000", "00100", '0'),
			 ("00000100000000000000000000000000", "00101", '0'),
			 ("00000010000000000000000000000000", "00110", '0'),
			 ("00000001000000000000000000000000", "00111", '0'),
			 ("00000000100000000000000000000000", "01000", '0'),
			 ("00000000010000000000000000000000", "01001", '0'),
			 ("00000000001000000000000000000000", "01010", '0'),
			 ("00000000000100000000000000000000", "01011", '0'),
			 ("00000000000010000000000000000000", "01100", '0'),
			 ("00000000000001000000000000000000", "01101", '0'),
			 ("00000000000000100000000000000000", "01110", '0'),
			 ("00000000000000010000000000000000", "01111", '0'),
			 ("00000000000000001000000000000000", "10000", '0'),
			 ("00000000000000000100000000000000", "10001", '0'),
			 ("00000000000000000010000000000000", "10010", '0'),
			 ("00000000000000000001000000000000", "10011", '0'),
			 ("00000000000000000000100000000000", "10100", '0'),
			 ("00000000000000000000010000000000", "10101", '0'),
			 ("00000000000000000000001000000000", "10110", '0'),
			 ("00000000000000000000000100000000", "10111", '0'),
			 ("00000000000000000000000010000000", "11000", '0'),
			 ("00000000000000000000000001000000", "11001", '0'),
			 ("00000000000000000000000000100000", "11010", '0'),
			 ("00000000000000000000000000010000", "11011", '0'),
			 ("00000000000000000000000000001000", "11100", '0'),
			 ("00000000000000000000000000000100", "11101", '0'),
			 ("00000000000000000000000000000010", "11110", '0'),
			 ("00000000000000000000000000000001", "11111", '0'));
			 
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