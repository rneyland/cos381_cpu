library ieee;
use ieee.std_logic_1164.all;

entity ALUControl is
	port(	OpType: 	in 	std_logic_vector(1 downto 0);
			Function: 	in 	std_logic_vector(5 downto 0);
			Operation:	out std_logic_vector(3 downto 0));
end ALUControl;

architecture rtl of ALUControl is
begin

	process(Function) is
	begin
		if OpType = "00" then
			Operation <= "0000";
		elsif OpType = "01" then 
			Operation <= "0100";
		elsif OpType = "10" then
			case Function is 
				when "011011" => Operation <= "1001"; --nor
				when "101010" => Operation <= "0101"; --slt
				when "000000" => Operation <= "0010"; --sll
				when "000010" => Operation <= "0011"; --srl

			end case; 
		elsif OpType = "11" then
			--or
		end if; 
	end process;
end rtl;
