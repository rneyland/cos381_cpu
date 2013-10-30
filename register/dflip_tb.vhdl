library ieee;
use ieee.std_logic_1164.all;

entity dflip_tb is
end dflip_tb;

architecture test of dflip_tb is
    signal d, clock, we, q: std_logic;

    component dflip 
        port (
            d:      in std_logic;
            clock:  in std_logic;
            we:     in std_logic;
            q:      out std_logic
        );
    end component;

begin
    flip: dflip port map (d, clock, we, q);

    process  
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;

    process
    begin
        d   <=  '1';
        we  <=  '1';
        wait for 4 ns; -- 4ns
        assert (q='U') report "bad rtl output value" severity error;
		wait for 2 ns; -- 6ns 
		assert (q='1') report "bad rtl output value" severity error;

        d   <= '0';
        we  <=  '1';
        wait for 4 ns; -- 10ns
        assert (q='1') report "bad rtl output value" severity error;
		wait for 6 ns; -- 16ns
		assert (q='0') report "bad rtl output value" severity error;
		
		wait for 10 ns; -- 26ns
        d   <= '1';
        we  <=  '1';
        wait for 4 ns; -- 30ns
        assert (q='0') report "bad rtl output value" severity error;
		wait for 6 ns; -- 36ns
		assert (q='1') report "bad rtl output value" severity error;
      
        assert false report "end of test" severity note;

        wait;    
    end process;
end test;

