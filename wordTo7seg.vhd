--DECODIFICADOR LETRAS

library ieee;
-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

entity wordTo7seg is
	port
	(
		hexa	: in  std_logic_vector(7 downto 0);  -- Numero hexagecimal de las letrasa
		segmento  : out  std_logic_vector(6 downto 0)
		
	);
end wordTo7seg;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture structural of wordTo7seg is

begin

	with hexa select segmento <=    
	"1000000" when x"30",			-- 0
	"1111001" when x"31",			-- 1
	"0100100" when x"32",			-- 2
	"0110000" when x"33",			-- 3
	"0011001" when x"34",			-- 4
	"0010010" when x"35",			-- 5
	"0000010" when x"36",			-- 6
	"1111000" when x"37",			-- 7
	"0000000" when x"38",			-- 8
	"0010000" when x"39",      	-- 9
	---------------------
	
	"1111111" when others;

end structural;