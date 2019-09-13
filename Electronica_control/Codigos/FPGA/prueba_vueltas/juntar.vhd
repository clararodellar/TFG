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
			  encoder1: in STD_LOGIC;
			  encoder2: in STD_LOGIC;
			  
           motor1 : out  STD_LOGIC;
           motor2 : out  STD_LOGIC;
           anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0));

end juntar;

architecture Behavioral of juntar is

	signal posicion_0 : STD_LOGIC_VECTOR(15 downto 0);
	
	component PWM_motor
	Port(
			  clk : in  STD_LOGIC;
           btn_reset : in  STD_LOGIC;
			  posicion_m : in STD_LOGIC_VECTOR(15 downto 0);
			  
           motor1 : out  STD_LOGIC;
			  motor2 : out  STD_LOGIC;
			  anodo : out  STD_LOGIC_VECTOR (3 downto 0);
           segmento : out  STD_LOGIC_VECTOR (6 downto 0));
	end component;
	
	component calcular_posicion
	Port(
		clk : in  STD_LOGIC;
      btn_reset : in  STD_LOGIC;
      A : in  STD_LOGIC; 
      B : in  STD_LOGIC; 
      posicion : out  STD_LOGIC_VECTOR(15 downto 0)); 
	end component;

begin

	PWM_motor1: PWM_motor
		port map (
			clk => clk,
         btn_reset => btn_reset,
			posicion_m => posicion_0,
         
			motor1 => motor1,
			motor2 => motor2,
			anodo => anodo,
			segmento => segmento
		);
		
	calcular_posicion1: calcular_posicion
		port map (
			clk => clk,
         btn_reset => btn_reset,
			A => encoder1,
			B => encoder2,
			posicion => posicion_0
		);
end Behavioral;

