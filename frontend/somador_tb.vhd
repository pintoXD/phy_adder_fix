-------------------------------------------------------------------------
-- Design unit: somador_tb
-- Description: top entity of an adder testbench
--------------------------------------------------------------------------


library IEEE;						
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use IEEE.Std_Logic_unsigned.all; -- due to conv_integer and + operator usage 
use IEEE.Std_Logic_arith.all;	 -- due to conv_std_logic_vector usage
use std.textio.all;
use work.Util_package.all;


-- Test bench interface is always empty.
entity somador_tb  is
end somador_tb;


-- Instantiate the components and generates the stimuli.
architecture verification of somador_tb is  



   --constant imageFileName	: string := "vetor.txt";	-- vector content to be loaded
    file imageFile : TEXT open READ_MODE is "vetor.txt";





-- Signals and constant declarations

	constant WIDTH		:integer := 8;
	signal clk		:std_logic := '0';
	signal rst_n		:std_logic;
	signal carry_i		:std_logic := '0';
	signal a_i, b_i		:std_logic_vector(WIDTH-1 downto 0);
	signal sum_o		:std_logic_vector(WIDTH-1 downto 0);
	signal carry_o		:std_logic;


-- Need to declare the component for Verilog simulation
	component somador
--        generic (
--            WIDTH   : integer;
--        )
	port (
		clk		: in std_logic;
		rst_n		: in std_logic;
		carry_i		: in std_logic;
		a_i		: in std_logic_vector(WIDTH-1 downto 0);
		b_i		: in std_logic_vector(WIDTH-1 downto 0);
		sum_o		: out std_logic_vector(WIDTH-1 downto 0);
		carry_o		: out std_logic
	);
	end component;

begin

	-- Instantiates the device under verification
	DUV: somador port map (
			clk,
			rst_n,
			carry_i,
			a_i,
			b_i,
			sum_o,
			carry_o
		);



	-- Generates the stimuli
	rst_n <= '0', '0' after 10 ns, '1' after 15 ns;
	--clk <= not clk after 20 ns;	-- 25 MHz
	clk <= not clk after 50 ns;	-- 10 MHz

	carry_i <= '0','1' after 49.5 ns; 
	   		
			   		


	process

--
		variable fileLine	: line;			-- Stores a read line from a text file
		variable str 		: string(1 to 2);	-- Stores an 8 characters string
		variable char		: character;		-- Stores a single character
		variable bool		: boolean;		-- 
--
		begin

			while NOT (endfile(imageFile)) loop	-- Main loop to read the file
		   		

				-- Read a file line into 'fileLine'
				readline(imageFile, fileLine);	

					-- Read the "A" operand and stores in 'str'
					for i in 1 to 2 loop
						read(fileLine, char, bool);
						str(i) := char;
					end loop;
					
					-- Converts the string "A" 'str' to std_logic_vector
					a_i <= StringToStdLogicVector(str);

					-- Read the 1 blank between A and B
					read(fileLine, char, bool);

					-- Read the "B" operand and stores in 'str'
					for i in 1 to 2 loop
						read(fileLine, char, bool);
						str(i) := char;
					end loop;
					
					-- Converts the string "B" 'str' to std_logic_vector
					b_i <= StringToStdLogicVector(str);

			   		wait until  clk = '1';
					--	carry_i <= not carry_i; 
			   		wait until  clk = '1';
	
					if a_i="00000000" and b_i="00000000" then
						wait for 5000 ns;
					end if;			
			end loop;


			wait ;	-- Suspend process  	


	end process;


end verification;


