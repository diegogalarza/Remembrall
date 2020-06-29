--(PRIMERA CAJITA)
library ieee;
use ieee.std_logic_1164.all;

entity alphanumerico is

	port(
		horaBin : in std_logic_vector(13 downto 0);
		minutosBin : in std_logic_vector(13 downto 0);
		alphaNumerico: out std_logic_vector(31 downto 0) -- alphanumerico
	);

end alphanumerico;

architecture rtl of alphanumerico is

	signal horasExtendido : std_logic_vector(15 downto 0); -- horas de 16 bits;
	signal minutosExtendido : std_logic_vector(15 downto 0); -- minutos de 16 bits
	
begin
	
	horasControlador : work.controlador
	port map
	(
		bin => horaBin,
		bcdFinal => horasExtendido
	);
	
	minutosControlador : work.controlador
	port map
	(
		bin => minutosBin,
		bcdFinal => minutosExtendido
	);
	
	alphaNumerico <=  minutosExtendido & horasExtendido ;
	

end rtl;