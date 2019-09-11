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
	
	component PWM_motor
	Port(
			  clk : in  STD_LOGIC;
           btn_reset : in  STD_LOGIC;
			  btn_subir_act : in  STD_LOGIC;
           btn_bajar_act : in  STD_LOGIC;
			  sw_sentido : in  STD_LOGIC;
			  sw_velocidad : in STD_LOGIC_VECTOR (2 downto 0);
			  dutycycle_bcd : in STD_LOGIC_VECTOR (11 downto 0);
			  
           motor1 : out  STD_LOGIC;
			  motor2 : out  STD_LOGIC;
			  led_salida : out  STD_LOGIC;
			  led_sentido : out  STD_LOGIC;
			  anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0);
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

begin

	PWM_motor1: PWM_motor
		port map (
			clk => clk,
         btn_reset => btn_reset,
			btn_subir_act => btn_subir_0,
			btn_bajar_act => btn_bajar_0,
			sw_sentido => sw_sentido,
			sw_velocidad => sw_velocidad,
			dutycycle_bcd => num_bcd_0,
         
			motor1 => motor1,
			motor2 => motor2,
			led_salida => led_salida,
			led_sentido => led_sentido,
			anodo => anodo,
			segmento => segmento,
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

end Behavioral;

