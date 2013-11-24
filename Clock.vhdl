LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity Clock is 
	port (	opcode: in std_logic;
			clk: out std_logic); 
end Clock;

architecture rtl of Clock is 
begin
	process
		while opcode /= "11111" loop
			clk <= '0';
			wait for 3 ns;
			clk <= '1';
			wait for 3 ns; 
		end loop; 
	end process;
end rtl; 
