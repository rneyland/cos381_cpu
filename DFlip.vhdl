library ieee;
use ieee.std_logic_1164.all;

entity Dflip is
	port
	(
		d, clock, we: in std_logic;
		q: out std_logic
	);
end Dflip;

architecture rtl of Dflip is
begin
	process(d, clock, we)
	begin
		if (clock'event and clock = '1' and we = '1') then
			q <= d after 20 ps;
		end if;
	end process;
end rtl;
