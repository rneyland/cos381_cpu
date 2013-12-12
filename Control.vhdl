library ieee;
use ieee.std_logic_1164.all;

entity Control is
	port(	Operation: 	in std_logic_vector(31 downto 26);
			Func: 		in std_logic_vector(5 downto 0);
			Branch, MemRead, MemWrite, RegWrite, SignExtend, ALUSrc1: out std_logic;
			ALUSrc2, MemToReg, WriteRegDst, PCSrc, ALUOpType: out std_logic_vector(1 downto 0));
end Control;

architecture rtl of Control is
begin

	process(Operation, Func) is
	begin
		case Operation is
			when "000000" =>
				Branch <= '0';
				MemRead <= '0';
				MemWrite <= '0';
				RegWrite <= '1'; 
				ALUSrc1 <= '0';
				ALUSrc2 <= "00";
				MemToReg <= "00";
				WriteRegDst <= "01";
				PCSrc <= "00";


				if Func = "010100" or "010110" then 
					SignExtend <= '1';
				else 
					SignExtend <= '0';
				end if;


				if Func = "010100" Func = "010101" then
					ALUOpType <= "00";
				elsif Func = "010110" or Func "010111" then
					ALUOpType <= "01";
				elsif Func = "011001" then
					--or
				else 
					ALUOpType <= "10";
				end if;

			-- ADDI
			when "001000" =>	Branch <= '0' after 20 ps;
								MemRead <= '0' after 20 ps;
								MemWrite <= '0' after 20 ps;
								RegWrite <= '1' after 20 ps;
								SignExtend <= '1' after 20 ps;
								ALUSrc1 <= '0' after 20 ps;
								ALUSrc2 <= "01" after 20 ps;
								MemToReg <= "00" after 20 ps;
								WriteRegDst <= "00" after 20 ps;
								PCSrc <= "00" after 20 ps;
								ALUOpType <= "00" after 20 ps;
			-- ADDUI
			when "001000" =>	Branch <= '0' after 20 ps;
								MemRead <= '0' after 20 ps;
								MemWrite <= '0' after 20 ps;
								RegWrite <= '1' after 20 ps;
								SignExtend <= '0' after 20 ps;
								ALUSrc1 <= '0' after 20 ps;
								ALUSrc2 <= "01" after 20 ps;
								MemToReg <= "00" after 20 ps;
								WriteRegDst <= "00" after 20 ps;
								PCSrc <= "00" after 20 ps;
								ALUOpType <= "00" after 20 ps;
			-- LW
			when "100011" =>	Branch <= '0' after 20 ps;
								MemRead <= '1' after 20 ps;
								MemWrite <= '0' after 20 ps;
								RegWrite <= '1' after 20 ps;
								SignExtend <= '1' after 20 ps;
								ALUSrc1 <= '0' after 20 ps;
								ALUSrc2 <= "01" after 20 ps;
								MemToReg <= "01" after 20 ps;
								WriteRegDst <= "00" after 20 ps;
								PCSrc <= "00" after 20 ps;
			-- SW
			when "101011" =>	Branch <= '0' after 20 ps;
								MemRead <= '0' after 20 ps;
								MemWrite <= '1' after 20 ps;
								RegWrite <= '1' after 20 ps;
								SignExtend <= '1' after 20 ps;
								ALUSrc1 <= '0' after 20 ps;
								ALUSrc2 <= "01" after 20 ps;
								MemToReg <= "10" after 20 ps;
								WriteRegDst <= "00" after 20 ps;
								PCSrc <= "00" after 20 ps;



		end case; 
	end process;
end rtl;
