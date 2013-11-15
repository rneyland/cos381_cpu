ENTITY Control IS
	PORT(	Operation: 	IN STD_LOGIC_VECTOR(31 DOWNTO 26);
			Func: 		IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			Branch, MemRead, MemWrite, RegWrite, SignExtend, ALUSrc1: OUT STD_LOGIC;
			ALUSrc2, MemToReg, WriteRegDst, PCSrc, ALUOpType: OUT STD_LOGIC VECTOR(1 DOWNTO 0));
END Control;
