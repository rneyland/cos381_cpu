library ieee;
use ieee.std_logic_1164.all;

entity Extend_tb is
end Extend_tb;

architecture test of Extend_tb is 
	signal Size: 	integer;
	signal Input: 	std_logic_vector(15 downto 0);
	signal SE:		std_logic;
	signal Output: 	std_logic_vector(31 downto 0);

begin
	extend: entity work.extend generic map (16) port map (Input, SE, Output);
	process
	begin
		Input 	<= "1010101010101010";
		SE 		<= '1';
		wait for 1 ns; 
		assert (Output = "11111111111111111010101010101010") report "bad output value" severity error;
        assert false report "end of test" severity note;
		wait;
	end process;
end test;
