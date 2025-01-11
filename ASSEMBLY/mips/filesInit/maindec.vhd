library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity maindec is -- main control decoder
	port(op, funct: in STD_LOGIC_VECTOR(5 downto 0);
		regwrite, memwrite: out STD_LOGIC;
		branch: out STD_LOGIC;
		alusrc, regdst, memtoreg, jump: out STD_LOGIC_VECTOR(1 downto 0);
		aluop: out STD_LOGIC_VECTOR(1 downto 0));
end;
architecture behave of maindec is
	signal controls: STD_LOGIC_VECTOR(12 downto 0);
begin
	process(op)
	begin
		case op is
			when "000000" => -- Instructions R
				if funct = "001000" then
					controls <= "0000000001000"; -- jr
				elsif funct = "111111" then
					controls <= "1111100000000"; -- neg
				else
					controls <= "1010000000011"; -- Rtyp
			end if;
			when "100011" => controls <= "1000100010000"; -- LW
			when "101011" => controls <= "0000101000000"; -- SW
			when "000100" => controls <= "0000010000001"; -- BEQ
			when "001000" => controls <= "1000100000000"; -- ADDI
			when "000010" => controls <= "0000000000100"; -- J
			when "001100" => controls <= "1000100000010"; -- ANDI
			when "000011" => controls <= "1100000100100"; -- JAL
			when others => controls <=   "-------------"; -- illegal op
		end case;
	end process;
	regwrite <= controls(12);
	regdst <= controls(11 downto 10);
	alusrc <= controls(9 downto 8);
	branch <= controls(7);
	memwrite <= controls(6);
	memtoreg <= controls(5 downto 4);
	jump <= controls(3 downto 2);
	aluop <= controls(1 downto 0);
end;