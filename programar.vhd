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

entity programar is
	port
	(
		-- Input ports
		Clk : in std_logic;
		botonHora : in std_logic;
		botonMinu : in std_logic;

		
		-- Output ports
		horasF : out std_logic_vector(13 downto 0); 
		minutosF : out std_logic_vector(13 downto 0)
		
	);
end programar;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture structural of programar is

	signal hora : natural;
	signal minutos : natural;
	

begin

	process (Clk) is
	begin
		if(rising_edge(Clk)) then
			if(botonHora = '0') then
				if(hora = 24) then
					hora <= 1;
				else
					hora <= hora + 1;
				end if;
			end if;
			
			if (botonMinu = '0') then
				if(minutos = 59) then
					minutos <= 0;
				else
					minutos <= minutos +1;
				end if;
			end if;
		end if;
	end process;
	
	horasF <= std_logic_vector(to_unsigned (hora,14));
	minutosF <= std_logic_vector(to_unsigned (minutos,14));
	
end structural;