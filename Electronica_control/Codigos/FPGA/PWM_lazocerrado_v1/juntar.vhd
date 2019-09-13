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
			  encoder1 : in  STD_LOGIC;
           encoder2 : in  STD_LOGIC;
			  on_off_switch_in : in std_logic;
			  
           motor1 : out  STD_LOGIC;
           motor2 : out  STD_LOGIC; 
           led_salida : out  STD_LOGIC;
			  led_sentido : out  STD_LOGIC;
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
	
	signal kp_sw_0 : std_logic; --determines if p term is needed
	signal ki_sw_0 : std_logic; --determines if i term is needed
	signal kd_sw_0 : std_logic; --determines if d term is needed
	signal on_off_switch_0 : std_logic; --determines if controller is active
	
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
			  on_off_switch_in : in std_logic;
			  dutycycle_bcd : in STD_LOGIC_VECTOR (11 downto 0);
			  
           motor1 : out  STD_LOGIC;
			  motor2 : out  STD_LOGIC;
			  led_salida : out  STD_LOGIC;
			  led_sentido : out  STD_LOGIC;
			  anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0);
			  velocidad_real_tension : out  STD_LOGIC_VECTOR(15 downto 0);
			  velocidad_deseada : out  STD_LOGIC_VECTOR(15 downto 0);
			  kp_sw : out std_logic; --determines if p term is needed
			  ki_sw : out std_logic; --determines if i term is needed
			  kd_sw : out std_logic; --determines if d term is needed
			  on_off_switch_out : out std_logic; --determines if controller is active
			  dutycycle_bin : out STD_LOGIC_VECTOR (7 downto 0));
	end component;
	
	component debouncer_top
	Port(
		clk : in  STD_LOGIC;
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
      posicion : out  STD_LOGIC_VECTOR(15 downto 0)); -- 24 bits
	end component;
	
	component PID
	Port(
		kp_sw          : IN std_logic; --determines if p term is needed
		ki_sw          : IN std_logic; --determines if i term is needed
		kd_sw          : IN std_logic; --determines if d term is needed
		SetVal         : IN std_logic_vector(15 DOWNTO 0); --user input reference
		adc_data       : IN std_logic_vector(15 DOWNTO 0); --feedbac value from sensor
		on_off_switch  : IN std_logic; --determines if controller is active
		output         : OUT std_logic_vector(15 DOWNTO 0); --output of controller
		clk            : IN STD_LOGIC);
	end component;

begin

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
			on_off_switch_in => on_off_switch_in,
			dutycycle_bcd => num_bcd_0,
         
			motor1 => motor1,
			motor2 => motor2,
			led_salida => led_salida,
			led_sentido => led_sentido,
			anodo => anodo,
			segmento => segmento,
			velocidad_real_tension => velocidad_real_tension_0,
			velocidad_deseada => velocidad_deseada_0,
			kp_sw => kp_sw_0,
			ki_sw => ki_sw_0,
			kd_sw => kd_sw_0,
			on_off_switch_out => on_off_switch_0,
			dutycycle_bin => num_bin_0
		);
		
	debouncer_top1: debouncer_top
		port map (
			clk => clk,
			btn_in => btn_subir,
			btn_out => btn_subir_0
		);
	
	debouncer_top2: debouncer_top
		port map (
			clk => clk,
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
			posicion => posicion_0
		);
	
	PID1: PID
		port map (
			kp_sw => kp_sw_0,
			ki_sw => ki_sw_0,
			kd_sw => kd_sw_0,
			SetVal => velocidad_deseada_0,
			adc_data => velocidad_real_tension_0,
			on_off_switch => on_off_switch_0,
			output => control_pid_0,
			clk => clk
		);

end Behavioral;

