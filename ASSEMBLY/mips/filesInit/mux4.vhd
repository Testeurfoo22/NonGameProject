library IEEE; use IEEE.STD_LOGIC_1164.all;

entity mux4 is -- two-input multiplexer
	generic (width: integer);
	port (d0, d1, d2, d3: in STD_LOGIC_VECTOR(width-1 downto 0);
			s: in STD_LOGIC_VECTOR(1 downto 0);
			y: out STD_LOGIC_VECTOR(width-1 downto 0));
end;

architecture behave of mux4 is
begin
	process (d0, d1, d2, d3, s) begin
		case (s) is
			when "00" => y <= d0;
			when "01" => y <= d1;
			when "10" => y <= d2;
			when "11" => y <= d3;
			when others => y <= d3;
		end case;
	end process;
end;

--entity mux4 is -- two-input multiplexer
--	generic(width: integer);
--	port(	d0, d1, d2, d3: in STD_LOGIC_VECTOR(width - 1 downto 0);
--			s: in STD_LOGIC_VECTOR(1 downto 0);
--			y: out STD_LOGIC_VECTOR(width - 1 downto 0));
--end;
--architecture behave of mux2 is
--	component mux2
--		generic(width: integer);
--		port(	d0, d1: in STD_LOGIC_VECTOR(width - 1 downto 0);
--				s: in STD_LOGIC;
--				y: out STD_LOGIC_VECTOR(width - 1 downto 0));
--	end component;
--	signal low, high: STD_LOGIC_VECTOR(width - 1 downto 0);
--begin
--	lowmux: mux2 generic map(width) port map(d0, d1, s(0), low);
--	highmux: mux2 generic map(width) port map(d2, d3, s(0), high);
--	finalmux: mux2 generic map(width) port map(low, high, s(1), y);
--end;