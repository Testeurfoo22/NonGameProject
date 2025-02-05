library IEEE; use IEEE.STD_LOGIC_1164.all;

entity proc_mips is -- single cycle MIPS processor
	port (clk, reset: in STD_LOGIC;
			pc: out STD_LOGIC_VECTOR (31 downto 0);
			instr: in STD_LOGIC_VECTOR (31 downto 0);
			memwrite: out STD_LOGIC;
			aluout, writedata: out STD_LOGIC_VECTOR (31 downto 0);
			readdata: in STD_LOGIC_VECTOR (31 downto 0));
end;

architecture struct of proc_mips is
	component controller
		port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
				zero: in STD_LOGIC;
				regwrite, memwrite: out STD_LOGIC;
				pcsrc: out STD_LOGIC;
				alusrc, regdst, memtoreg, jump: out STD_LOGIC_VECTOR(1 downto 0);
				alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
	end component;
	component datapath
		port (	clk, reset: in STD_LOGIC;
				pcsrc: in STD_LOGIC;
				alusrc: in STD_LOGIC_VECTOR(1 downto 0);
				regwrite: in STD_LOGIC;
				regdst, memtoreg, jump: in STD_LOGIC_VECTOR(1 downto 0);
				alucontrol: in STD_LOGIC_VECTOR (5 downto 0);
				zero: out STD_LOGIC;
				pc: buffer STD_LOGIC_VECTOR (31 downto 0);
				instr: in STD_LOGIC_VECTOR(31 downto 0);
				aluout, writedata: buffer STD_LOGIC_VECTOR (31 downto 0);
				readdata: in STD_LOGIC_VECTOR(31 downto 0));
	end component;
	signal regwrite, pcsrc: STD_LOGIC;
	signal alusrc, regdst, memtoreg, jump: STD_LOGIC_VECTOR(1 downto 0);
	signal zero: STD_LOGIC;
	signal alucontrol: STD_LOGIC_VECTOR (5 downto 0);
begin
	cont: controller port map (instr (31 downto 26), instr(5 downto 0), zero, regwrite, 
										memwrite, pcsrc, alusrc, regdst, memtoreg, jump, alucontrol);
	dp: datapath port map (	clk, reset, pcsrc, alusrc, regwrite, regdst, memtoreg, jump,
									alucontrol, zero, pc, instr, aluout, writedata, readdata);
end;