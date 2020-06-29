-- VOLVER LA HORA O LOS MINUTOS A BCD CON EXTENCION DE SIGNO Y EN ASCII


library ieee;
-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

entity controlador is
	port
	(
		bin	: in  std_logic_vector(13 downto 0);  -- Numero binari
		bcdFinal : out std_logic_vector(15 downto 0)
		
	);
end controlador;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture structural of controlador is

signal	bcd: std_logic_vector(15 downto 0);  -- 00/24
signal	bcdSinCero : std_logic_vector(7 downto 0);  -- 24
signal	bcdPrimero  : std_logic_vector(3 downto 0);	--derecha a izquierda 4
signal	bcdSegundo : std_logic_vector(7 downto 4); -- 2
signal 	bcdPrimero2 : std_logic_vector(7 downto 0);
signal 	bcdSegundo2 : std_logic_vector(7 downto 0);

begin

BCD2seg: work.binToBCD
port map
(
		num_bin => bin,
		num_bcd => bcd
);	
	bcdSinCero<= bcd(7 downto 0);
	bcdPrimero<= bcdSinCero(3 downto 0);
	bcdSegundo<= bcdSinCero(7 downto 4);
	bcdPrimero2 <= std_logic_vector(unsigned("0000" & bcdPrimero) + to_unsigned(48,8));
	bcdSegundo2 <= std_logic_vector(unsigned("0000" & bcdSegundo) + to_unsigned(48,8));
	bcdFinal <= bcdSegundo2 & bcdPrimero2;
	
end structural;