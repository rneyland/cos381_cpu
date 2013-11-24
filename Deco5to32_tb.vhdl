library ieee;
use ieee.std_logic_1164.all;

entity deco5to32_tb is
end deco5to32_tb;

architecture test of deco5to32_tb is
    signal input:	std_logic_vector(4 downto 0);
    signal enable:	std_logic;
    signal output:	std_logic_vector(31 downto 0);
   
begin
	deco: entity work.deco5to32(rtl) port map (input, enable, output);

    process
		type pattern_type is record
	    	input:	std_logic_vector(4 downto 0);
	    	enable: std_logic;
	    	output:	std_logic_vector(31 downto 0);
		end record;
	
		type pattern_array is array (natural range <>) of pattern_type;
		
		constant patterns: pattern_array :=
			(("00000", '1', "00000000000000000000000000000001"),
			 ("00001", '1', "00000000000000000000000000000010"),
			 ("00010", '1', "00000000000000000000000000000100"),
			 ("00011", '1', "00000000000000000000000000001000"),
			 ("00100", '1', "00000000000000000000000000010000"),
			 ("00101", '1', "00000000000000000000000000100000"),
			 ("00110", '1', "00000000000000000000000001000000"),
			 ("00111", '1', "00000000000000000000000010000000"),
			 ("01000", '1', "00000000000000000000000100000000"),
			 ("01001", '1', "00000000000000000000001000000000"),
			 ("01010", '1', "00000000000000000000010000000000"),
			 ("01011", '1', "00000000000000000000100000000000"),
			 ("01100", '1', "00000000000000000001000000000000"),
			 ("01101", '1', "00000000000000000010000000000000"),
			 ("01110", '1', "00000000000000000100000000000000"),
			 ("01111", '1', "00000000000000001000000000000000"),
			 ("10000", '1', "00000000000000010000000000000000"),
			 ("10001", '1', "00000000000000100000000000000000"),
			 ("10010", '1', "00000000000001000000000000000000"),
			 ("10011", '1', "00000000000010000000000000000000"),
			 ("10100", '1', "00000000000100000000000000000000"),
			 ("10101", '1', "00000000001000000000000000000000"),
			 ("10110", '1', "00000000010000000000000000000000"),
			 ("10111", '1', "00000000100000000000000000000000"),
			 ("11000", '1', "00000001000000000000000000000000"),
			 ("11001", '1', "00000010000000000000000000000000"),
			 ("11010", '1', "00000100000000000000000000000000"),
			 ("11011", '1', "00001000000000000000000000000000"),
			 ("11100", '1', "00010000000000000000000000000000"),
			 ("11101", '1', "00100000000000000000000000000000"),
			 ("11110", '1', "01000000000000000000000000000000"),
			 ("11111", '1', "10000000000000000000000000000000"));
    
    begin	
  		for i in patterns'range loop
  			input 	<=	patterns(i).input;
  			enable	<=	patterns(i).enable;
 
  			wait for 1 ns;
  			
  			assert output = patterns(i).output
    			report "bad rtl output value" severity error;
    		
  		end loop;
  		
  		assert false report "end of test" severity note;	
  		
  		wait;   
    end process;
end test;