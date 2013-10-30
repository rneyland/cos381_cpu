library ieee;
use ieee.std_logic_1164.all;

entity mux2to1_tb is
end mux2to1_tb;

architecture test of mux2to1_tb is
    signal input:	std_logic_vector(1 downto 0);
    signal sel:		std_logic;
    signal output:	std_logic;
    
begin
    mux: entity work.mux2to1(rtl) port map (input, sel, output);

    process
		type pattern_type is record
	    	input:	std_logic_vector(1 downto 0);
	    	sel:	std_logic;
	    	output:	std_logic;
		end record;
	
		type pattern_array is array (natural range <>) of pattern_type;
		
		constant patterns: pattern_array :=
			(("00", '0', '0'),
			 ("00", '1', '0'),
			 ("01", '0', '1'),
			 ("01", '1', '0'),
			 ("10", '0', '0'),
			 ("10", '1', '1'),
			 ("11", '0', '1'),
			 ("11", '1', '1'));
			 
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
