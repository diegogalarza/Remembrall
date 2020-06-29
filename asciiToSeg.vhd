--REPRESENTACION DEL CODIGO ASCII EN 7 SEGMENTOS (SEGUNDA CAJITA)
library ieee;
use ieee.std_logic_1164.all;

entity asciiToSeg is

	port(
		alphaNumerico: in std_logic_vector(31 downto 0); -- alphanumerico
		
		primer7seg : out std_logic_vector(6 downto 0);		-- primer siete segmentos derecha izquierda
		segundo7seg : out std_logic_vector(6 downto 0);
		tercer7seg : out std_logic_vector(6 downto 0);
		cuarto7seg : out std_logic_vector(6 downto 0)
	);

end asciiToSeg;

architecture rtl of asciiToSeg is

	signal alpha1 : std_logic_vector(7 downto 0);
	signal alpha2 : std_logic_vector(7 downto 0);
	signal alpha3 : std_logic_vector(7 downto 0);
	signal alpha4 : std_logic_vector(7 downto 0);
	signal seg1 : std_logic_vector(6 downto 0);  -- primer siete segmentos derecha izquierda
	signal seg2 : std_logic_vector(6 downto 0);
	signal seg3 : std_logic_vector(6 downto 0);
	signal seg4 : std_logic_vector(6 downto 0);
	
begin
	
	alpha1 <= alphaNumerico(7 downto 0); 
	alpha2 <= alphaNumerico(15 downto 8); 
	alpha3 <= alphaNumerico(23 downto 16); 
	alpha4 <= alphaNumerico(31 downto 24);
	
	
	segmentoP : work.wordTo7seg	-- Primer Segmento
	port map
	(
		hexa => alpha1,
		segmento => seg1	
	);
	primer7seg <= seg1;    -- Se le asigna el primer digito (derecha izquerda)
	
	
	segmentoS : work.wordTo7seg	-- Segundo Segmento
	port map
	(
		hexa => alpha2,
		segmento => seg2	
	);
	segundo7seg <= seg2;
	
	segmentoT : work.wordTo7seg	-- Tercer Segmento
	port map
	(
		hexa => alpha3,
		segmento => seg3	
	);
	tercer7seg <= seg3;
	
	segmentoC : work.wordTo7seg	-- Cuarto Segmento
	port map
	(
		hexa => alpha4,
		segmento => seg4	
	);
	cuarto7seg <= seg4;
	

end rtl;