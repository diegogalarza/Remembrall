library ieee;
use ieee.std_logic_1164.all;

entity proyectoFinal is

	port(
		--ENTRADAS
		Clk : in std_logic;
		botonH : in std_logic;
		botonM : in std_logic;
		boE,boP,boS,boNo,boR,boT : in	std_logic;
		--SALIDAS
		segmento1 : out std_logic_vector(6 downto 0);
		segmento2 : out std_logic_vector(6 downto 0);
		segmento3 : out std_logic_vector(6 downto 0);
		segmento4 : out std_logic_vector(6 downto 0)
	);

end proyectoFinal;

architecture rtl of proyectoFinal is

	--FLANCO
	signal botonEspera: std_logic;
	signal botonProg: std_logic;
	signal botonS: std_logic;
	signal botonNo: std_logic;
	signal botonR: std_logic;
	signal botonT: std_logic;
	--ALPHANUMERIO
	signal Clkd:std_logic;
	signal horaBin : std_logic_vector(13 downto 0);
	signal minutosBin : std_logic_vector(13 downto 0);
	signal alphaNume : std_logic_vector(31 downto 0);
	signal seg1 : std_logic_vector(6 downto 0);  -- primer siete segmentos derecha izquierda
	signal seg2 : std_logic_vector(6 downto 0);
	signal seg3 : std_logic_vector(6 downto 0);
	signal seg4 : std_logic_vector(6 downto 0);
	signal enSlot : std_logic;
	signal arregloSlot : std_logic_vector(2 downto 0);
	signal enEscritura : std_logic;
	attribute keep : boolean;
	attribute keep of alphaNume: signal is true;
	-- REGISTROS SLOTS 
		--PRIMER SLOT
	signal hora1 : std_logic_vector(13 downto 0);
	signal minuto1 : std_logic_vector(13 downto 0);
		--SEGUNDO SLOTS
	signal hora2 : std_logic_vector(13 downto 0);
	signal minuto2 : std_logic_vector(13 downto 0);
		--TERCER SLOTS
	signal hora3 : std_logic_vector(13 downto 0);
	signal minuto3 : std_logic_vector(13 downto 0);
		--CUARTO SLOT
	signal hora4 : std_logic_vector(13 downto 0);
	signal minuto4 : std_logic_vector(13 downto 0);
		--CINCO SLOT
	signal hora5 : std_logic_vector(13 downto 0);
	signal minuto5 : std_logic_vector(13 downto 0);
	

begin

	div : work.divisor
	port map
	(
		clk50mhz=> Clk,
		Clk1 => Clkd
	);

--FLANCO

	flancoProgram : work.flancoP
	port map
	(
		clk => Clkd,
		input => not boE,
		reset => '0',
		output =>botonEspera
	);
	
	flancoeSlot : work.flancoP
	port map
	(
		clk => Clkd,
		input => not boP,
		reset => '0',
		output =>botonProg
	);
	
	flancoeNo : work.flancoP
	port map
	(
		clk => Clk,
		input => not boS,
		reset => '0',
		output =>botonS
	);
	
	flancoeR : work.flancoP
	port map
	(
		clk => Clk,
		input => not boNo,
		reset => '0',
		output =>botonNo
	);
	
	flancoT : work.flancoP
	port map
	(
		clk => Clkd,
		input => not boR,
		reset => '0',
		output =>botonR
	);
	
	flancoE : work.flancoP
	port map
	(
		clk => Clkd,
		input => not boT,
		reset => '0',
		output =>botonT
	);
	
	
-- MAQUINA ESTADOS

	maquinca : work.estados
	port map
	(
		clk => Clkd,
		boE => botonEspera,
		boP => botonProg,
		boS =>botonS,
		boNo =>botonNo,
		boR =>botonR,
		boT =>botonT,
		reset => '0',
		enSlot => enSlot,
		enEscritura => enEscritura
	);
	

	--Clk <= Clk;

-- BURBUJA DE PROGRAMAR

	horasMinutosBin : work.programar
	port map
	(
		clk => Clkd,
		botonHora => botonH,
		botonMinu => botonM,
		horasF => horaBin,
		minutosF => minutosBin
	);

	alpha: work.alphanumerico
	port map
	(
		horaBin => horaBin,
		minutosBin => minutosBin,
		alphaNumerico => alphaNume
	);
	

	ascii: work.asciiToSeg
	port map
	(
		alphaNumerico => alphaNume,
		primer7seg => seg1,
		segundo7seg => seg2,
		tercer7seg => seg3,
		cuarto7seg => seg4
	);
	
	segmento1 <= seg1;
	segmento2 <= seg2;
	segmento3 <= seg3;
	segmento4 <= seg4;
	
-- BURBUJA DE SLOT
	arrSlot: work.slot
	port map
	(
		Clk => Clkd,
		EN => enSlot,
		botonSeguir => boS,
		R => arregloSlot
	);

	process (Clkd) is
	begin
		if(rising_edge(Clkd)) then
			if((enEscritura = '1')) then
				case(arregloSlot) is
					when "000" =>
						hora1 <=horaBin;
						minuto1 <=minutosBin;
					when "001" =>
						hora2 <=horaBin;
						minuto2 <=minutosBin;
					when "010" =>
						hora3 <=horaBin;
						minuto3 <=minutosBin;
					when "011" =>
						hora4 <=horaBin;
						minuto4 <=minutosBin;
					when "100" =>
						hora5 <=horaBin;
						minuto5 <=minutosBin;
					when others =>
						NULL;
				end case;
			end if;
		end if;
	end process;
	
	
end rtl;