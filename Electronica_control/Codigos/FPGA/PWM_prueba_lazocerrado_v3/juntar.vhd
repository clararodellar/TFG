----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:48:27 07/14/2019 
-- Design Name: 
-- Module Name:    juntar - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity juntar is

	Port ( clk : in  STD_LOGIC;
           btn_reset : in  STD_LOGIC;
           btn_subir : in  STD_LOGIC;
           btn_bajar : in  STD_LOGIC;
           sw_sentido : in  STD_LOGIC;
           sw_velocidad : in  STD_LOGIC_VECTOR (2 downto 0);
			  sw4 : in STD_LOGIC;
			  encoder1 : in  STD_LOGIC;
           encoder2 : in  STD_LOGIC;
			  
           motor1 : out  STD_LOGIC;
           motor2 : out  STD_LOGIC; 
           led_salida : out  STD_LOGIC;
			  led_sentido : out  STD_LOGIC;
			  led_comprueba: out STD_LOGIC;
			  led_posicion: out STD_LOGIC;
           anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0));

end juntar;

architecture Behavioral of juntar is

	signal btn_subir_0 : STD_LOGIC;
	signal btn_bajar_0 : STD_LOGIC;
	signal num_bin_0 : STD_LOGIC_VECTOR (7 downto 0);
	signal num_bcd_0 : STD_LOGIC_VECTOR (11 downto 0);
	signal posicion_0 : STD_LOGIC_VECTOR(15 downto 0);
	signal velocidad_real_tension_0 : STD_LOGIC_VECTOR(15 downto 0);
	signal velocidad_deseada_0 : STD_LOGIC_VECTOR(15 downto 0);
	signal control_pid_0 : STD_LOGIC_VECTOR(15 downto 0);
	signal fin_pwm_0 : STD_LOGIC;
	signal orden_cambio_vel_0 : STD_LOGIC;
	signal s16mili_0 : STD_LOGIC;
	
	component PWM_motor
	Port(
			  clk : in  STD_LOGIC;
           btn_reset : in  STD_LOGIC;
			  btn_subir_act : in  STD_LOGIC;
           btn_bajar_act : in  STD_LOGIC;
			  sw_sentido : in  STD_LOGIC;
			  sw_velocidad : in STD_LOGIC_VECTOR (2 downto 0);
			  posicion : in STD_LOGIC_VECTOR(15 downto 0);  
			  control_pid : in STD_LOGIC_VECTOR(15 downto 0);
			  dutycycle_bcd : in STD_LOGIC_VECTOR (11 downto 0);
			  sw4 : in STD_LOGIC;
			  
           motor1 : out  STD_LOGIC;
			  motor2 : out  STD_LOGIC;
			  led_salida : out  STD_LOGIC;
			  led_sentido : out  STD_LOGIC;
			  led_comprueba: out STD_LOGIC;
			  fin_pwm: out STD_LOGIC;
			  s16mili : out STD_LOGIC;
			  orden_cambio_vel: out STD_LOGIC;
			  anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0);
			  velocidad_real_tension : out  STD_LOGIC_VECTOR(15 downto 0);
			  velocidad_deseada : out  STD_LOGIC_VECTOR(15 downto 0);
			  dutycycle_bin : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component debouncer_top
	Port(
		clk : in  STD_LOGIC;
		btn_reset : in  STD_LOGIC;
      btn_in : in  STD_LOGIC;
      btn_out : out  STD_LOGIC);
	end component;
	
	component binary_to_bcd
	Port(
		bin : in  STD_LOGIC_VECTOR (7 downto 0);
      bcd : out  STD_LOGIC_VECTOR (11 downto 0));
	end component;
	
	component calcular_posicion
	Port(
		clk : in  STD_LOGIC;
      btn_reset : in  STD_LOGIC;
      A : in  STD_LOGIC;
      B : in  STD_LOGIC;
		s16mili : in STD_LOGIC;
      posicion : out  STD_LOGIC_VECTOR(15 downto 0)); -- 24 bits
	end component;
	
	component PID
	Port(
		clk : in STD_LOGIC;
		btn_reset : in  STD_LOGIC;
		SetVal : in std_logic_vector(15 downto 0); -- Velocidad deseada
		adc_data : in std_logic_vector(15 downto 0); -- Velocidad real
		fin_pwm : in STD_LOGIC;
		orden_cambio_vel: in STD_LOGIC;
		output : out std_logic_vector(15 downto 0)); -- Velocidad con el control para conseguir la deseada
	end component;

begin

	led_posicion <= '0' when posicion_0 = 0 else '1';
	
	PWM_motor1: PWM_motor
		port map (
			clk => clk,
         btn_reset => btn_reset,
			btn_subir_act => btn_subir_0,
			btn_bajar_act => btn_bajar_0,
			sw_sentido => sw_sentido,
			sw_velocidad => sw_velocidad,
			posicion => posicion_0,
			control_pid => control_pid_0,
			dutycycle_bcd => num_bcd_0,
			sw4 => sw4,
         
			
			motor1 => motor1,
			motor2 => motor2,
			led_salida => led_salida,
			led_sentido => led_sentido,
			led_comprueba => led_comprueba,
			fin_pwm => fin_pwm_0,
			s16mili => s16mili_0,
			orden_cambio_vel => orden_cambio_vel_0,
			anodo => anodo,
			segmento => segmento,
			velocidad_real_tension => velocidad_real_tension_0,
			velocidad_deseada => velocidad_deseada_0,
			dutycycle_bin => num_bin_0
		);
		
	debouncer_top1: debouncer_top
		port map (
			clk => clk,
			btn_reset => btn_reset,
			btn_in => btn_subir,
			btn_out => btn_subir_0
		);
	
	debouncer_top2: debouncer_top
		port map (
			clk => clk,
			btn_reset => btn_reset,
			btn_in => btn_bajar,
			btn_out => btn_bajar_0
		);
	
	binary_to_bcd1: binary_to_bcd
		port map (
			bin => num_bin_0,
			bcd => num_bcd_0
		);
		
	calcular_posicion1: calcular_posicion
		port map (
			clk => clk,
         btn_reset => btn_reset,
			A => encoder1,
			B => encoder2,
			s16mili => s16mili_0,
			posicion => posicion_0
		);
	
	PID1: PID
		port map (
			clk => clk,
         btn_reset => btn_reset,
			SetVal => velocidad_deseada_0,
			adc_data => velocidad_real_tension_0,
			fin_pwm => fin_pwm_0,
			orden_cambio_vel => orden_cambio_vel_0,
			output => control_pid_0
		);

end Behavioral;

