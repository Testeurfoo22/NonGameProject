library IEEE; use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
	port (	a, b: in STD_LOGIC_VECTOR(31 downto 0);
			      f: in STD_LOGIC_VECTOR (5 downto 0);
			      z: out STD_LOGIC;
			      y: out STD_LOGIC_VECTOR(31 downto 0):= X"00000000");
end;
architecture behave of alu is
signal diff, tmp: STD_LOGIC_VECTOR(31 downto 0);
begin

	diff <= a - b;
	
	process (a, b, f, diff, tmp) begin
		case f is
			when "100100" => tmp <= a and b; --
			when "100101" => tmp <= a or b; --
			when "100000" => tmp <= a + b; --
			--when "100" => tmp <= a and (not b); --
			--when "101" => tmp <= a or (not b); --
			--when "100110" => tmp <= a xor b; --38 xor
			--when "100111" => tmp <= not (a or b); --39 nor
			when "100010" => tmp <= diff; -- 
			when "101010" => --SLT
					tmp <= X"0000000" & "000" & diff(31); 
			when others => tmp <= X"FFFFFFFF"; 
		end case;
	end process;
	
	z <= '1' when tmp = X"00000000" else '0';
	
	y <= tmp;
	
end;