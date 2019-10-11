----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:53:12 07/07/2019 
-- Design Name: 
-- Module Name:    PWM_motor - Behavioral 
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

entity PWM_motor is
    Port ( clk : in  STD_LOGIC;
           btn_reset : in  STD_LOGIC;
			  btn_subir_act : in  STD_LOGIC;
           btn_bajar_act : in  STD_LOGIC;
			  sw_sentido : in STD_LOGIC;
			  sw_velocidad : in STD_LOGIC_VECTOR(2 downto 0);
			  posicion : in STD_LOGIC_VECTOR(15 downto 0);  -- El único que me interesa con 23 es posición, pero por operaciones podría tener que cambiarse todos los que pone 15
			  control_pid : in STD_LOGIC_VECTOR(15 downto 0);
			  dutycycle_bcd : in STD_LOGIC_VECTOR(11 downto 0);
			  sw4 : in STD_LOGIC;
			  
           motor1 : out  STD_LOGIC;
			  motor2 : out  STD_LOGIC;
			  led_salida : out  STD_LOGIC;
			  led_sentido: out STD_LOGIC;
			  led_comprueba: out STD_LOGIC;
			  fin_pwm: out STD_LOGIC;
			  s16mili : out STD_LOGIC;
			  orden_cambio_vel: out STD_LOGIC;
			  anodo : out  STD_LOGIC_VECTOR(3 downto 0);
           segmento : out  STD_LOGIC_VECTOR(6 downto 0);
			  velocidad_real_tension : out  STD_LOGIC_VECTOR(15 downto 0);
			  velocidad_deseada : out  STD_LOGIC_VECTOR(15 downto 0);
			  dutycycle_bin : out STD_LOGIC_VECTOR(7 downto 0));
			  
end PWM_motor;

architecture Behavioral of PWM_motor is
	
	signal dutycycle : unsigned (7 downto 0); -- Hasta 255
	signal control_pid2 : unsigned (15 downto 0);
	signal comparacion : unsigned (15 downto 0);
	signal velocidad_real : STD_LOGIC_VECTOR (15 downto 0);
	
	signal conta8us : unsigned (9 downto 0); -- 10 bits
	--signal conta8us : unsigned (2 downto 0); -- 3 bits. Valor para la simulación
	constant periodo : natural := 800; -- Lo que vale cada una de las divisiones para tener un periodo aprox de 2 ms
	--constant periodo : natural := 8; -- Valor para la simulación
	signal signalPWM : STD_LOGIC;
	signal mostrar : STD_LOGIC_VECTOR (3 downto 0);
	
	signal conta0_5seg: unsigned (25 downto 0); --26 bits
	constant c_fin_cuenta_medioseg: natural := 5*10**7; --Tiene este valor para contar medio segundo
	signal s0_5seg : STD_LOGIC; --Señal de 0.5 segundos.
	signal pulso_anterior : STD_LOGIC;
	
	signal conta16mili : unsigned (3 downto 0); -- 10 bits
	
	signal cuentaPWM : unsigned (7 downto 0);
	
	signal salidaPWM : STD_LOGIC;
	
	signal btn_subir_rg1 : STD_LOGIC;
	signal btn_subir_rg2 : STD_LOGIC;
	signal pulso_subir : STD_LOGIC;
	
	signal btn_bajar_rg1 : STD_LOGIC;
	signal btn_bajar_rg2 : STD_LOGIC;
	signal pulso_bajar : STD_LOGIC;
	
	signal aumento : unsigned (6 downto 0);
	--signal posicion_anterior : STD_LOGIC_VECTOR(15 downto 0);
	
	signal conta1milisegundo : unsigned (16 downto 0); -- 17 bits
	--	signal conta1milisegundo : unsigned (3 downto 0);
	constant c_fin_cuenta_milisegundo : natural := 10**5; -- Tiene este valor para contar 1 milésima de segundo
	--	constant c_fin_cuenta_milisegundo : natural := 10; --Tiene este valor para simular
	signal s1mili : STD_LOGIC; -- Señal de 1 décima de segundo. Valdrá '1' cada 1 décima de segundo
	signal conta3mili: unsigned (1 downto 0);
	
	signal velocidad_real_tension2 : STD_LOGIC_VECTOR(15 downto 0);
	
begin

------------------------------------------------------------------------------------------------------------------
	
	-- Creamos biestable para guardar los valores de la señal de botón subir 2 veces y compararlas y que así sólo 
	-- detecte una transición de subida, no el nivel. Conseguimos evitar varias lecturas del 1 del botón. Es lo que se
	-- denomina detector de flanco.
	
	biestable_subir: Process (btn_reset, clk) --Se usa mismo reset y mismo reloj para todos los componentes
	begin
		if btn_reset='1' then -- Resetear
			btn_subir_rg1 <= '0';
			btn_subir_rg2 <= '0';
		elsif clk'event and clk='1' then -- Se guardan las variables.
			btn_subir_rg1 <= btn_subir_act;
			btn_subir_rg2 <= btn_subir_rg1;
		end if;
	end process;
	
	pulso_subir <= '1' when (btn_subir_rg1='1' and btn_subir_rg2='0') else '0'; --Hacemos la comparación
	
	
------------------------------------------------------------------------------------------------------------------
	
	-- Creamos biestable para guardar los valores de la señal de botón bajar 2 veces y compararlas y que así sólo 
	-- detecte una transición de subida, no el nivel. Conseguimos evitar varias lecturas del 1 del botón. Es lo que se
	-- denomina detector de flanco.
	
	biestable_bajar: Process (btn_reset, clk) --Se usa mismo reset y mismo reloj para todos los componentes
	begin
		if btn_reset='1' then -- Resetear
			btn_bajar_rg1 <= '0';
			btn_bajar_rg2 <= '0';
			orden_cambio_vel <= '0';
		elsif clk'event and clk='1' then -- Se guardan las variables.
			btn_bajar_rg1 <= btn_bajar_act;
			btn_bajar_rg2 <= btn_bajar_rg1;
			orden_cambio_vel <= pulso_bajar or pulso_subir; -- Se retrasa señal para actualizar output_load
		end if;
	end process;
	
	pulso_bajar <= '1' when (btn_bajar_rg1='1' and btn_bajar_rg2='0') else '0'; --Hacemos la comparación
	
	
-------------------------------------------------------------------------------------------------------------------
	
-- Proceso que determina cuánto se aumenta la velocidad
	
	P_AUMENTAR: Process (sw_velocidad)
	begin 
		if sw_velocidad = "001" then 
			aumento <= "0000001"; -- 1
		elsif sw_velocidad = "010" then
			aumento <= "0001010"; -- 10
		elsif sw_velocidad = "100" then
			aumento <= "1100100"; -- 100
		else
			aumento <= "0000000"; -- 0
		end if;
	end process;

-----------------------------------------------------------------------------------------------------------------------

-- Generamos la señal de ciclo de trabajo

	p_dutycycle: Process (btn_reset,clk)  -- Contador que crea señal de 1 milésima de segundo
	begin
		if btn_reset='1' then -- Resetear
			dutycycle <= (others => '0');
		elsif clk'event and clk='1' then -- Hacemos el divisor de frecuencia
			if pulso_subir = '1' then
				if aumento = 1 then
					if dutycycle = 255 then
						dutycycle <= dutycycle;
					else
						dutycycle <= dutycycle + aumento;
					end if;
				elsif aumento = 10 then
					if dutycycle > 245 then
						dutycycle <= dutycycle;
					else
						dutycycle <= dutycycle + aumento;
					end if;
				elsif aumento = 100 then
					if dutycycle > 155 then
						dutycycle <= dutycycle;
					else
						dutycycle <= dutycycle + aumento;
					end if;
				end if;
			elsif pulso_bajar = '1' then
				if aumento = 1 then	
					if dutycycle = 0 then
						dutycycle <= dutycycle;
					else
						dutycycle <= dutycycle - aumento;
					end if;
				elsif aumento = 10 then
					if dutycycle < 10 then
						dutycycle <= dutycycle;
					else
						dutycycle <= dutycycle - aumento;
					end if;
				elsif aumento = 100 then
					if dutycycle < 100 then
						dutycycle <= dutycycle;
					else
						dutycycle <= dutycycle - aumento;
					end if;
				end if;
			end if;
		end if;
	end process;
	
---------------------------------------------------------------------------------------------------------------------
	
--Generamos la señal periódica del ciclo de trabajo
	
	p_conta8us: Process (btn_reset,clk)  -- Contador que crea señal de 250 us
	begin
		if btn_reset='1' then -- Resetear
			conta8us <= (others => '0');
		elsif clk'event and clk='1' then -- Hacemos el divisor de frecuencia
			if conta8us = periodo-1 then
				conta8us <= (others => '0');
			else
				conta8us <= conta8us +1;
			end if;
		end if;
	end process;
	
	signalPWM <= '1' when conta8us = periodo -1 else '0'; -- Creamos señal de 1 milésima de segundo.

---------------------------------------------------------------------------------------------------------------------
	
-- Generamos la señal del periodo, que son 256 veces la del ciclo de trabajo, lo que da una señal de periodo 
-- de 2 milisegundos.

	p_periodo : Process (btn_reset, clk) -- Contador que cuenta 8 milisegundos
	begin
		if btn_reset='1' then
			cuentaPWM <= (others => '0');
		elsif clk'event and clk = '1' then
			if signalPWM = '1' then
				if cuentaPWM = 255 then
					cuentaPWM <= (others => '0');
				else
					cuentaPWM <= cuentaPWM +1; -- Contamos
				end if;
			end if;
		end if;
	end process;

   fin_pwm <= '1' when cuentaPWM = 255 and signalPWM = '1' else '0';
---------------------------------------------------------------------------------------------------------------------

-- Generamos la señal de PWM por comparación de las señales creadas que pasaremos a nuestro componente
	
	control_pid2 <= unsigned(control_pid);
	
	comparacion <= "00000000" & control_pid2(7 downto 0);

	led_comprueba <= '0' when control_pid2(15 downto 8) = "00000000" else '1';
	
	p_comparador: Process (cuentaPWM, comparacion) 
	begin
		if cuentaPWM < comparacion(7 downto 0) then 
			salidaPWM <= '1';
		else
			salidaPWM <= '0';	
		end if;
	end process;
	
---------------------------------------------------------------------------------------------------------------------

-- Se pasa al motor la información
	
	p_motor: Process(clk, btn_reset) 
	begin
		if btn_reset='1' then
			motor1 <= '0';
			motor2 <= '0';
			led_salida <= '0';
			led_sentido <= '0';
		elsif clk'event and clk = '1' then
			led_salida <= salidaPWM;
			if sw_sentido = '0' then
				motor1 <= salidaPWM;
				motor2 <= '0';
				led_sentido <= '0';
			else
				motor1 <= '0';
				motor2 <= salidaPWM;
				led_sentido <= '1';
			end if;
		end if;
	end process;
	
---------------------------------------------------------------------------------------------------------------------

	segmento <= "1000000" when mostrar="0000" else -- 0: B,C,D,E,F,G
			 "1111001" when mostrar="0001" else -- 1: F,E
			 "0100100" when mostrar="0010" else -- 2: A,C,D,F,G
			 "0110000" when mostrar="0011" else -- 3: A,D,E,F,G
			 "0011001" when mostrar="0100" else -- 4: A,B,E,F
			 "0010010" when mostrar="0101" else -- 5: A,B,D,E,G
			 "0000010" when mostrar="0110" else -- 6: A,B,C,D,E,G
			 "1111000" when mostrar="0111" else -- 7: E,F,G
			 "0000000" when mostrar="1000" else -- 8: A,B,C,D,E,F,G
			 "0011000" when mostrar="1001" else -- 9: A,B,E,F,G
			 "1111111";  -- nada
	
	-------------------------------------------------------------------------------------------------------------------
	
	p_conta1mili: Process (btn_reset,clk)  -- Contador que crea señal de 1 milésima de segundo
	begin
		if btn_reset='1' then -- Resetear
			conta1milisegundo <= (others => '0');
		elsif clk'event and clk='1' then -- Hacemos el divisor de frecuencia
			if conta1milisegundo = c_fin_cuenta_milisegundo-1 then
				conta1milisegundo <= (others => '0');
			else
				conta1milisegundo <= conta1milisegundo +1;
			end if;
		end if;
	end process;
	
	s1mili <= '1' when conta1milisegundo = c_fin_cuenta_milisegundo -1 else '0'; -- Creamos señal de 1 milésima de segundo.
	
	-------------------------------------------------------------------------------------------------------------------	
	
	p_conta3milis : Process (btn_reset, clk) -- Contador que cuenta 4 milisegundos
	begin
		if btn_reset='1' then
			conta3mili <= (others => '0');
		elsif clk'event and clk = '1' then
			if s1mili = '1' then
				if conta3mili = 2 then
					conta3mili <= (others => '0');
				else
					conta3mili <= conta3mili +1; -- Contamos décimas de segundo
				end if;
			end if;
		end if;
	end process;
	
	-------------------------------------------------------------------------------------------------------------------
	
	p_conta0_5seg: Process (btn_reset,clk)  -- Contador que crea señal de medio sgeundo
	begin
		if btn_reset='1' then -- Resetear
			conta0_5seg <= (others => '0');
		elsif clk'event and clk='1' then -- Hacemos el divisor de frecuencia
			if conta0_5seg = c_fin_cuenta_medioseg -1 then
				conta0_5seg <= (others => '0');
			else
				conta0_5seg <= conta0_5seg +1;
			end if;
		end if;
	end process;
	
	s0_5seg <= '1' when conta0_5seg = c_fin_cuenta_medioseg - 1 else '0';
	
------------------------------------------------------------------------------------------------------------------
	
	-- Creamos la variable pulso_anterior que vale 1 y 0 alternativamente cada medio segundo para poder asignarsela
	-- al número que queremos que parpadee.
	
	biestable_pulso_anterior: Process (btn_reset, clk) --Se usa mismo reset y mismo reloj para todos los componentes
	begin
		if btn_reset='1' then -- Resetear
			pulso_anterior <= '0'; 
		elsif clk'event and clk='1' then -- Se guardan las variables.
			if pulso_anterior = '1' and s0_5seg = '1' then 
				pulso_anterior <= '0'; 
			elsif pulso_anterior = '0' and s0_5seg ='1' then 
				pulso_anterior <= '1'; 
			end if;
		end if;
	end process;
	
------------------------------------------------------------------------------------------------------------------

	velocidad_deseada <= "00000000" & std_logic_vector(dutycycle);

	p_control : Process (btn_reset, clk) -- Contador que cuenta 16 milisegundos
	begin
		if btn_reset='1' then
			conta16mili <= (others => '0');
			velocidad_real <= (others => '0');
			--velocidad_real_tension <= (others => '0');
			--posicion_anterior <= (others => '0');
		elsif clk'event and clk = '1' then
			if s1mili = '1' then
				if conta16mili = 15 then
					conta16mili <= (others => '0');
					--if signed(posicion)>0 then
						--velocidad_real <= std_logic_vector(unsigned(posicion));
					--else
						--velocidad_real <= std_logic_vector(-signed(posicion));
					--end if;
					velocidad_real <= std_logic_vector(unsigned(posicion)); --std_logic_vector((to_integer(unsigned(posicion)) - to_integer(unsigned(posicion_anterior)))/16);
					--velocidad_real_tension <= std_logic_vector(2*unsigned(velocidad_real));
				else
					conta16mili <= conta16mili +1; -- Contamos décimas de segundo
				end if;
			end if;
		end if;
	end process;
	
	velocidad_real_tension <= velocidad_real(14 downto 0) & '0'; -- Multiplicar por 2
	
	s16mili <= '1' when conta16mili = 15 and s1mili = '1' else '0';
	
	
------------------------------------------------------------------------------------------------------------------


-- Hacemos que parpadeen los números cuando se pueda cambiar su valor. Mostramos en el display el voltaje
-- Pasamos el valor dutycycle a la salida dutycycle_bin para la función
																 -- binary_to_bcd
	velocidad_real_tension2 <= velocidad_real(14 downto 0) & '0';
	dutycycle_bin <= std_logic_vector(dutycycle) when sw4 ='1' else velocidad_real_tension2(7 downto 0);
	
	
	p_mux: Process (dutycycle_bcd, conta3mili, sw_velocidad, pulso_anterior)
	begin
		if conta3mili = "00" then
			if sw_velocidad = "001" then
				if pulso_anterior = '1' then
					mostrar <= dutycycle_bcd(3 downto 0); -- unidades
				else
					mostrar <= "1111";
				end if;
			else
				mostrar <= dutycycle_bcd(3 downto 0); -- unidades
			end if;
		elsif conta3mili = "01" then
			if sw_velocidad = "010" then
				if pulso_anterior = '1' then
					mostrar <= dutycycle_bcd(7 downto 4); -- decenas
				else
					mostrar <= "1111";
				end if;
			else
				mostrar <= dutycycle_bcd(7 downto 4); -- decenas
			end if;
		elsif conta3mili = "10" then
			if sw_velocidad = "100" then
				if pulso_anterior = '1' then
					mostrar <= dutycycle_bcd(11 downto 8); -- centenas
				else
					mostrar <= "1111";
				end if;
			else
				mostrar <= dutycycle_bcd(11 downto 8); -- centenas
			end if;
		else
			mostrar <= "1111";
		end if;
	end process;
	
	-------------------------------------------------------------------------------------------------------------------
	
	p_decodificador: Process (btn_reset, conta3mili)
	begin
		if btn_reset='1' then
			anodo <= "1111";
		else
			case conta3mili is
				when "00" =>
					anodo <= "1110";
				when "01" =>
					anodo <= "1101";
				when others =>
					anodo <= "1011";
			end case;
		end if;
	end process;


end Behavioral;

