library ieee;
use ieee.std_logic_1164.all;

ENTITY Control IS
	PORT(	Operation: 	IN STD_LOGIC_VECTOR(31 DOWNTO 26);
			Func: 		IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			Branch, MemRead, MemWrite, RegWrite, SignExtend, ALUSrc1: OUT STD_LOGIC;
			ALUSrc2, MemToReg, WriteRegDst, PCSrc, ALUOpType: OUT STD_LOGIC_VECTOR(1 DOWNTO 0));
END Control;

ARCHITECTURE rtl OF Control IS
BEGIN

--Control: PROCESS
--BEGIN
PROCESS(Operation)
BEGIN
	PROCESS(Operation, Func) IS
	BEGIN
		CASE OPERATION IS
			-- ADD
			WHEN "000000"	=>	Branch <= '0';
								MemRead <= '0';
								MemWrite <= '0';
								RegWrite <=	'1';
								SignExtend <= '0';
								ALUSrc1 <= '0';
								ALUSrc2 <= "00";
								MemToReg <= "00";
								WriteRegDst <= "01";
								PCSrc <= "00";
								ALUOpType <= "00";
			-- ADDU
			WHEN "001000" =>	Branch <= '0';
								MemRead <= '0';
								MemWrite <= '0';
								RegWrite <=	'1';
								SignExtend <= '0';
								ALUSrc1 <= '0';
								ALUSrc2 <= "00";
								MemToReg <= "00";
								WriteRegDst <= "01";
								PCSrc <= "00";
								ALUOpType <= "00";
			-- ADDI
			WHEN "001000" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '0' AFTER 20 ps;
								MemWrite <= '0' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '1' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps;
								ALUSrc2 <= "01" AFTER 20 ps;
								MemToReg <= "00" AFTER 20 ps;
								WriteRegDst <= "00" AFTER 20 ps;
								PCSrc <= "00" AFTER 20 ps;
								ALUOpType <= "00" AFTER 20 ps;
			-- ADDUI
			WHEN "001000" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '0' AFTER 20 ps;
								MemWrite <= '0' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '1' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps;
								ALUSrc2 <= "01" AFTER 20 ps;
								MemToReg <= "00" AFTER 20 ps;
								WriteRegDst <= "00" AFTER 20 ps;
								PCSrc <= "00" AFTER 20 ps;
								ALUOpType <= "00" AFTER 20 ps;
			-- SUB
			WHEN "000001"	=>	Branch <= '0';
								MemRead <= '0';
								MemWrite <= '0';
								RegWrite <=	'1';
								SignExtend <= '0';
								ALUSrc1 <= '0';
								ALUSrc2 <= "00";
								MemToReg <= "00";
								WriteRegDst <= "01";
								PCSrc <= "00";
								ALUOpType <= "01";
			-- NOR
			WHEN "100111"	=>	Branch <= '0';
								MemRead <= '0';
								MemWrite <= '0';
								RegWrite <=	'1';
								SignExtend <= '0';
								ALUSrc1 <= '0';
								ALUSrc2 <= "00";
								MemToReg <= "00";
								WriteRegDst <= "01";
								PCSrc <= "00";
								ALUOpType <= "10";
			-- XOR
			WHEN "100110"	=>	Branch <= '0';
								MemRead <= '0';
								MemWrite <= '0';
								RegWrite <=	'1';
								SignExtend <= '0';
								ALUSrc1 <= '0';
								ALUSrc2 <= "00";
								MemToReg <= "00";
								WriteRegDst <= "01";
								PCSrc <= "00";
								ALUOpType <= "10";
			-- LW
			WHEN "100011" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '1' AFTER 20 ps;
								MemWrite <= '0' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '1' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps;
								ALUSrc2 <= "01" AFTER 20 ps;
								MemToReg <= "01" AFTER 20 ps;
								WriteRegDst <= "00" AFTER 20 ps;
								PCSrc <= "00" AFTER 20 ps;
			-- SW
			WHEN "101011" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '0' AFTER 20 ps;
								MemWrite <= '1' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '1' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps;
								ALUSrc2 <= "01" AFTER 20 ps;
								MemToReg <= "10" AFTER 20 ps;
								WriteRegDst <= "00" AFTER 20 ps;
								PCSrc <= "00" AFTER 20 ps;
			-- SLT
			WHEN "101010" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '0' AFTER 20 ps;
								MemWrite <= '0' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '0' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps; --hardcode 4 
								ALUSrc2 <= "00" AFTER 20 ps; -- second read from reg, 32bit extended, 32bit extended & shamt, PC
								MemToReg <= "00" AFTER 20 ps; -- from ALU, data memory, PC
								WriteRegDst <= "00" AFTER 20 ps; -- rt, rd, or 31 reg
								PCSrc <= "00" AFTER 20 ps; -- PC+4, J-type, first read from reg
								ALUOpType <= "10";
			-- SLL
			WHEN "000000" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '0' AFTER 20 ps;
								MemWrite <= '0' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '0' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps;
								ALUSrc2 <= "00" AFTER 20 ps;
								MemToReg <= "00" AFTER 20 ps;
								WriteRegDst <= "01" AFTER 20 ps;
								PCSrc <= "00" AFTER 20 ps;
								ALUOpType <= "10";
			-- SRL
			WHEN "000000" =>	Branch <= '0' AFTER 20 ps;
								MemRead <= '0' AFTER 20 ps;
								MemWrite <= '0' AFTER 20 ps;
								RegWrite <= '1' AFTER 20 ps;
								SignExtend <= '0' AFTER 20 ps;
								ALUSrc1 <= '0' AFTER 20 ps;
								ALUSrc2 <= "00" AFTER 20 ps;
								MemToReg <= "00" AFTER 20 ps;
								WriteRegDst <= "01" AFTER 20 ps;
								PCSrc <= "00" AFTER 20 ps;
								ALUOpType <= "10";


				




	END;
END ARCHITECTURE rtl; 
