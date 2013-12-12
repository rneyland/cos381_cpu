LIBRARY ieee;
use ieee.std_logic_1164.all;

entity CPU is
end CPU;

architecture rtl of CPU is
	-- sram
	signal CLK, NWE, NOE: std_logic;

	-- address
	signal IMemData: std_logic_vector(31 downto 0);
	signal OpCode, Funct: std_logic_vector(5 downto 0);
	signal Rs, Rt, Rd, Shamt: std_logic_vector(4 downto 0);

	-- control
	signal Branch, MemRead, MemWrite, RegWrite, SignExtend, AluSrc1: std_logic;
	signal AluSrc2, MemToReg, WriteRegDst, PCSrc, ALUOpType: std_logic_vector(1 downto 0);

	-- register
	signal WriteReg: std_logic_vector(4 downto 0);
	signal WriteData, RegOut1, RegOut2: std_logic_vector(31 downto 0); 

	-- pc register
	signal PCAdd4, PCAddI, PCRegIn, PCRegOut: std_logic_vector(31 downto 0);

	-- alu
	signal ALUOperation: std_logic_vector(3 downto 0);
	signal Zero: std_logic;
	signal ALUOut: std_logic_vector(31 downto 0);
begin

	process
	begin
		if (MemWrite and CLK = '1') then
			NWE <= '0';
		else 
			NWE <= '1';
		end if;

		if (MemRead and CLK = '1') then
			NOE <= '0';
		else
			NOE <= '1';
		end if;
	end process;

	OpCode <= IMemData(31 downto 26);
	Rs <= IMemData(25 downto 21);
	Rt <= IMemData(20 downto 16);
	Rd <= IMemData(15 downto 11);
	Shamt <= IMemData(10 downto 6);
	Funct <= IMemData(5 downto 0);

	ImmAddr <= IMemData(15 downto 0);


	ALU: entity work.ALU port map(ALUIn1, ALUIn2, ALUOperation, ALUOut, Zero);
	ALUControl: entity work.ALUControl port map(ALUOpType, Funct, ALUOperation);
	Control: entity work.Control port map (OpCode, Funct, Branch, MemRead, MemWrite, RegWrite, SignExtend, AluSrc1, AluSrc2, MemToReg, WriteRegDst, PCSrc, ALUOpType);
	RegFile: entity work.RegFile port map (Rs, Rt, WriteReg, RegWrite, CLK, RegOut1, RegOut2);
	PCAdd4: entity work.Adder32 port map (PCRegOut, "00000000000000000000000000000100", '0', '0', PCAdd4 );
	PCAddI: entity work.Adder32 port map (PCAdd4, ("0000000000000000" & ImmAddr), '0', '0', PCAddImm);

	PCBranchMux: entity work.Mux32_2to1 port map (		Input(31 downto 0) => PCAdd4, 
														Input(63 downto 32) => PCAddImm, 
														Sel => Branch, 
														Output => PCFinal);

	PCSourceMux: entity work.Mux32_4to1 port map (		Input(31 downto 0) => PCFinal,
														Input(63 downto 32) => IMemData, 
														Input(95 downto 64) => RegOut1,
														Sel =>  PCSrc, 
														Output => PCRegIn);


	ALUValue1Mux: entity work.Mux32_2to1 port map (		Input(31 downto 0) => "00000000000000000000000000000100",
														Input(63 downto 32) => RegOut1,
														Sel => AluSrc1,
														Output => ALUIn1);


	ALUValue2Mux: entity work.Mux32_4to1 port map ( 	Input(31 downto 0) => PCRegOut,
														Input(63 downto 32) => ShamtExt,
														Input(95 downto 64) => ImmAddrExt,
														Input(127 downto 96) => RegOut2,
														Sel => AluSrc2,
														Output => ALUIn2);


	WriteRegDstMux: entity work.Mux5_4to1 port map (	Input(4 downto 0) => Rt,
														Input(9 downto 5) => Rd,
														Input(14 downto 10) => "11110",
														Sel => WriteRegDst,
														Output => WriteReg);

	WriteDataMux: entity work.Mux32_4to1 port map (		Input(31 downto 0) => ALUOut,
														Input(63 downto 31) => DMemData,
														Input(95 downto 64) => PCRegOut,
														Sel => MemToReg,
														Output => WriteData);

 	LeftShift2: entity work.Shift32 port map (IMemData, 0, "00000000000000000000000000000010", ImmAddrShift);
 	ImmedExtend: entity work.Extend generic map (16) port map (ImmAddrShift, SignExtend, ImmAddrExt);
	ShamtExtend: entity work.Extend generic map (5) port map (Shamt, '0', ShamtExt);
	Clock: entity work.Clock port map (OpCode, CLK);
	IMemory: entity work.SRam port map ('0', PCRegOut, IMemData, NWE, NOE);
	DMemory: entity work.SRam port map ('0', ALUOut, DMemData, NWE, NOE);
	PCReg: entity work.Reg32 port map (PCRegIn, CLK, '1', PCRegOut);
	IMemData <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ";

end rtl;
