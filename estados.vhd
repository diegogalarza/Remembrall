
library ieee;
use ieee.std_logic_1164.all;

entity estados is

	port(
		clk		 : in	std_logic;
		boE,boP,boS,boNo,boR,boT : in	std_logic;
		reset	 : in	std_logic;
		enSlot : out std_logic;
		enEscritura : out std_logic
	);

end entity;

architecture rtl of estados is

	-- Build an enumerated type for the state machine
	type state_type is (espera, programar, slot, nombre, rept, tiempo);

	-- Register to hold the current state
	signal state   : state_type;

begin
		process (clk, reset)
		begin
			if reset = '0' then
				state <= espera;
			elsif (rising_edge(clk)) then
				case state is
					when espera=>
						if boE = '1' then
							state <= programar;
						else
							state <= espera;
						end if;
					when programar=>
						if boP = '1' then
							state <= slot;
						else
							state <= programar;
						end if;
					when slot=>
						if boS = '1' then
							state <= nombre;
						else
							state <= slot;
						end if;
					when nombre =>
						if boNo = '1' then
							state <= rept;
						else
							state <= nombre;
						end if;
					when rept =>
						if boR = '1' then
							state <= tiempo;
						else
							state <= rept;
						end if;
					when tiempo =>
						if boT = '1' then
							state <= espera;
						else
							state <= tiempo;
						end if;
				end case;
			end if;
		end process;

		
		-- Output depends solely on the current state
	process (state)
		begin
			case state is
				when espera =>
					enSlot <= '0';
					enEscritura <= '0';
				when programar =>
					enSlot <= '0';
					enEscritura <= '0';
				when slot =>
					enSlot <= '1';
					enEscritura <= '0';
				when nombre => 
					enSlot <= '0';
					enEscritura <= '1';
				when rept => 
					enSlot <= '0';
					enEscritura <= '0';
				when tiempo => 
					enSlot <= '0';
					enEscritura <= '0';
			end case;
	end process;		
end rtl;
