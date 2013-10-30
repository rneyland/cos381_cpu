library ieee;
use ieee.std_logic_1164.all;

entity mux16to1_tb is
end mux16to1_tb;

architecture test of mux16to1_tb is
    signal input:	std_logic_vector(15 downto 0);
    signal sel:		std_logic_vector(3 downto 0);
    signal output:	std_logic;
    
begin
    mux: entity work.mux16to1(rtl) port map (input, sel, output);

    process
		type pattern_type is record
	    	input:	std_logic_vector(15 downto 0);
	    	sel:	std_logic_vector(3 downto 0);
	    	output:	std_logic;
		end record;
	
		type pattern_array is array (natural range <>) of pattern_type;
		
		constant patterns: pattern_array :=
			(("1000000000000000", "0000", '0'),
			 ("0100000000000000", "0001", '0'),
			 ("0010000000000000", "0010", '0'),
			 ("0001000000000000", "0011", '0'),
			 ("0000100000000000", "0100", '0'),
			 ("0000010000000000", "0101", '0'),
			 ("0000001000000000", "0110", '0'),
			 ("0000000100000000", "0111", '0'),
			 ("0000000010000000", "1000", '0'),
			 ("0000000001000000", "1001", '0'),
			 ("0000000000100000", "1010", '0'),
			 ("0000000000010000", "1011", '0'),
			 ("0000000000001000", "1100", '0'),
			 ("0000000000000100", "1101", '0'),
			 ("0000000000000010", "1110", '0'),
			 ("0000000000000001", "1111", '0'));

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
