LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU IS 
END CPU;

ARCHITECTURE rtl OF CPU IS
	signal clk: std_logic;
	signal nwe: std_logic;
	signal noe: std_logic;
	signal z, pc4, pc_out: std_logic_vector(31 downto 0);
BEGIN
	
	if (--memwrite and clk='1') then
		nwe <= '0';
	else 
		nwe <= '1';
	end if;

	if (--memread and clk='1') then
		noe <= '0';
	else
		nwe <= '1';
	end if;


	nwe <=
	Control: ENTITY work.Control PORT MAP();
	PCAdd4: ENTITY work.Adder32 PORT MAP(--pc, "00000000000000000000000000000100", '0', '0', pc4 );
	PCAdd??: ENTITY work.Adder32 PORT MAP(--pc4, ???, '0', '0', pcbranch);
	PCMuxBranch: ENTITY work.Mux32-2to1 PORT MAP((pc4, pcbranch), branch, pc_out);
	PCMuxSource: ENTITY work.Mux32-3to1 PORT MAP((pc_out, addr, regaddr), pcsrc, pc_final);
	LeftShift2: ENTITY work.Shift32 PORT MAP();
	RegFile: ENTITY work.RegFile PORT MAP();
	Clock: ENTITY work.Clock PORT MAP(--opcode, clk);
	SRam: ENTITY work.sram PORT MAP('0', --pc, z, nwe, noe);
	PCReg: entity work.reg32 port map(--pc, clk, '1', pc_out);
	z <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";


