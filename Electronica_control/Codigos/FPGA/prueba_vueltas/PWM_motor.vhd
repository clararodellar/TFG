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
			  posicion_m : in STD_LOGIC_VECTOR(15 downto 0);
			  
           motor1 : out  STD_LOGIC;
			  motor2 : out  STD_LOGIC;
			  anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0));
			  
end PWM_motor;

architecture Behavioral of PWM_motor is
	
	signal dutycycle : unsigned (7 downto 0); -- Hasta 255
	
	signal conta8us : unsigned (9 downto 0); -- 10 bits
	--signal conta8us : unsigned (2 downto 0); -- 3 bits. Valor para la simulación
	constant periodo : natural := 800; -- Lo que vale cada una de las divisiones para tener un periodo aprox de 2 ms
	--constant periodo : natural := 8; -- Valor para la simulación
	signal signalPWM : STD_LOGIC;
	signal mostrar : STD_LOGIC_VECTOR (3 downto 0);
	
	signal cuentaPWM : unsigned (7 downto 0);
	
	signal salidaPWM : STD_LOGIC;
	
	signal conta1milisegundo : unsigned (16 downto 0); -- 17 bits
	--	signal conta1milisegundo : unsigned (3 downto 0);
	constant c_fin_cuenta_milisegundo : natural := 10**5; -- Tiene este valor para contar 1 milésima de segundo
	--	constant c_fin_cuenta_milisegundo : natural := 10; --Tiene este valor para simular
	signal s1mili : STD_LOGIC; -- Señal de 1 décima de segundo. Valdrá '1' cada 1 décima de segundo
	signal conta3mili: unsigned (1 downto 0);
	
	signal error: unsigned (15 downto 0);
	signal parar : STD_LOGIC;
	
begin


-----------------------------------------------------------------------------------------------------------------------

-- Generamos la señal de ciclo de trabajo

	dutycycle <= "01100100"; --100
	
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
-- de xxxx milisegundos.

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

---------------------------------------------------------------------------------------------------------------------

-- Generamos la señal de PWM por comparación de las señales creadas que pasaremos a nuestro componente

	p_comparador: Process (cuentaPWM, dutycycle)
	begin
		if cuentaPWM < dutycycle then
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
			parar <= '0';
		elsif clk'event and clk = '1' then
			if error = 0 then -- En caso de que el error sea 0 (se han contado 1800 posiciones) se para el motor
				motor1 <= '0';
				motor2 <= '0';
				parar <= '1';
			elsif parar = '0' then -- Mientras no se haya alcanzado el error 0, el motor se mueve
				motor1 <= salidaPWM;
				motor2 <= '0';
			end if;
		end if;
	end process;
	
	
	error <= 18000 - unsigned(posicion_m) when signed(posicion_m)>0 else
	         unsigned(18000 + signed(posicion_m));
	--error <= abs(1800 - unsigned(posicion_m));
	
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
			 "0001000" when mostrar="1010" else -- A: A,B,C,E,F,G
			 "0000011" when mostrar="1011" else -- B: C,D,E,F,G || A,B,C,D,E
			 "1000110" when mostrar="1100" else -- C: A,D,E,F || B,C,D,G
			 "0100001" when mostrar="1101" else -- D: B,C,D,E,G || A,C,D,E,F
			 "0000110" when mostrar="1110" else -- E: A,D,E,F,G || A,B,C,D,G
			 "0001110";  -- F: A,E,F,G || A,B,C,G


			 --"1111111";  -- nada
	
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
				if conta3mili = 3 then
					conta3mili <= (others => '0');
				else
					conta3mili <= conta3mili +1; -- Contamos décimas de segundo
				end if;
			end if;
		end if;
	end process;
	
	
------------------------------------------------------------------------------------------------------------------
	
	-- Se muestra la posición por el display en hexadecimal para asegurarnos que cuando pare haya contado las 1800
	-- líneas
	
	p_mux: Process (conta3mili, posicion_m)
	begin
		if conta3mili = "00" then
			mostrar <= posicion_m(3 downto 0); -- unidades
		elsif conta3mili = "01" then
			mostrar <= posicion_m(7 downto 4); -- decenas
		elsif conta3mili = "10" then
			mostrar <= posicion_m(11 downto 8); -- centenas
		else
			mostrar <= posicion_m(15 downto 12);
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
				when "10" =>
					anodo <= "1011";
				when others =>
					anodo <= "0111";
			end case;
		end if;
	end process;


end Behavioral;

