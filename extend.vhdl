library ieee;
use ieee.std_logic_1164.all;

entity Extend is 
	generic ( 	Size: 	integer );
	port 	(	Input:	in std_logic_vector((size - 1) downto 0);
				SE: 	in std_logic;
				Output: out std_logic_vector(31 downto 0));
end Extend;

architecture rtl of Extend is 
begin
	Output((Size - 1) downto 0) <= Input;
	Output(31 downto (Size)) <= (others => (Input(Size - 1) and SE));
end rtl;