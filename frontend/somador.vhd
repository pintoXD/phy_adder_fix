-------------------------------------------------------------------------
-- Design unit: somador
-- Description: top entity of an adder
--------------------------------------------------------------------------


library IEEE;						
use IEEE.std_logic_1164.all;
use IEEE.Std_Logic_unsigned.all; -- due to conv_integer and + operator usage 
use IEEE.Std_Logic_arith.all;	 -- due to conv_std_logic_vector usage

entity somador  is
	generic(
		WIDTH		: integer := 8);
	port (
		clk, rst_n		: in std_logic;
		carry_i			: in std_logic;
		a_i, b_i		: in std_logic_vector(WIDTH-1 downto 0);
		carry_o			: out std_logic;
		sum_o			: out std_logic_vector(WIDTH-1 downto 0));
end somador;

architecture behavioral of somador is  

signal sum_temp: std_logic_vector (WIDTH downto 0);
--signal a_s, b_s, carryin_s : std_logic_vector(WIDTH downto 0);

begin

process (clk,rst_n)

variable a_v, b_v, carryin_v : std_logic_vector(WIDTH downto 0);

  begin
	if rst_n='0' then
	  sum_temp <= (others => '0');
	elsif rising_edge(clk) then
	  a_v := '0'&a_i;
	  b_v := '0'&b_i;
	  carryin_v := "00000000"&carry_i;
	  --sum_temp <= '0'&a_i + '0'&b_i + "00000000"&carry_i;
	  sum_temp <= a_v + b_v + carryin_v;
	end if;
end process;


--  a_s <= '0'&a_i;
--  b_s <= '0'&b_i;
--  carryin_s <= "00000000"&carry_i;


  sum_o <= sum_temp (WIDTH-1 downto 0);
  carry_o <= sum_temp(WIDTH);

end behavioral;

