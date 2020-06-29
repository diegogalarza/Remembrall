-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library ieee;
-- Use clauses import declarations into the current scope.	
-- If more than one use clause imports the same name into the
-- the same scope, none of the names are imported.

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

entity slot is
	port
	(
		-- Input ports
		Clk: in std_logic;
		EN : in std_logic;
		botonSeguir: in std_logic;
		-- Output ports
		R  : out std_logic_vector (2 downto 0)
		
	);
end slot;


architecture behavior of slot is

	signal arregloAlam: natural range 0 to 4;   -- toda se;al que sea un registro 

begin

	process (Clk) is
	begin
		if(rising_edge(Clk)) then
			if((EN = '1')) then
				if(botonSeguir = '0') then
					if(arregloAlam = 5) then
						arregloAlam <= 0;
					else
						arregloAlam<= arregloAlam+1;
					end if;
				end if;	
			end if;
		end if;
	end process;
	
	R <= std_logic_vector(to_unsigned (arregloAlam,3));

end behavior;