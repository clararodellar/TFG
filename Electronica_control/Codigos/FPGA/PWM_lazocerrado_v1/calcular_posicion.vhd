----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:20:10 07/14/2019 
-- Design Name: 
-- Module Name:    calcular_posicion - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity calcular_posicion is
    Port ( clk : in  STD_LOGIC;
           btn_reset : in  STD_LOGIC;
           A : in  STD_LOGIC; -- encoder1
           B : in  STD_LOGIC; -- encoder2
           posicion : out  STD_LOGIC_VECTOR(15 downto 0)); -- 24 bits daría la media hora
end calcular_posicion;

architecture Behavioral of calcular_posicion is
	
	signal A_rg1 : STD_LOGIC;
	signal A_rg2 : STD_LOGIC;
	signal pulso_A : STD_LOGIC;
	
	signal count : signed (15 downto 0); -- Puede dar 4660 vueltas en un sentido y dado que como 
				-- máximo da 1 vuelta en 0,5 segundos, puede estar en un sentido 38 minuto sin que desborde la señal
				-- integer range -8388608 to 8388607 := 0;
begin

-- Se obtiene haciendo máquinas de estados y simplificando las fórmulas obtenidas mediante Karnough
	
	-- Creamos biestable para guardar los valores de la señal de botón subir 2 veces y compararlas y que así sólo 
	-- detecte una transición de subida, no el nivel. Conseguimos evitar varias lecturas del 1 del botón. Es lo que se
	-- denomina detector de flanco.
	
	biestable_A: Process (btn_reset, clk) --Se usa mismo reset y mismo reloj para todos los componentes
	begin
		if btn_reset='1' then -- Resetear
			A_rg1 <= '0';
			A_rg2 <= '0';
		elsif clk'event and clk='1' then -- Se guardan las variables.
			A_rg1 <= A;
			A_rg2 <= A_rg1;
		end if;
	end process;
	
	pulso_A <= '1' when (A_rg1='1' and A_rg2='0') else '0'; -- Hay cambio de color
	
	cuenta_posicion: Process (btn_reset, clk)
	begin
		if btn_reset = '1' then
			count <= (others=>'0');
		elsif clk'event and clk='1' then -- if rising_edge(clk) then
			if pulso_A = '1' and B ='0' then 
				count <= count + 1; -- Va hacia delante asi que sumamos uno
			elsif pulso_A = '1' and B = '1' then 
				count <= count - 1; -- Va hacia detrás asi que restamos uno
			end if;
		end if;
	end process;

	posicion <= std_logic_vector(count); -- std_logic_vector puede tener signo?
				-- std_logic_vector(to_signed(count, posicion'length)); ?????

end Behavioral;

