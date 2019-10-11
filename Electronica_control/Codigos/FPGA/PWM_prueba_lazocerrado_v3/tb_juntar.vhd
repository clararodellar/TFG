--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:48:59 09/18/2019
-- Design Name:   
-- Module Name:   D:/URJC/4.CUARTO/TFG/TRABAJO/FPGA/PWM_prueba_lazocerrado_v3/tb_juntar.vhd
-- Project Name:  PWM_prueba_lazocerrado_v3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: juntar
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_juntar IS
END tb_juntar;
 
ARCHITECTURE behavior OF tb_juntar IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT juntar
    PORT(
         clk : IN  std_logic;
         btn_reset : IN  std_logic;
         btn_subir : IN  std_logic;
         btn_bajar : IN  std_logic;
         sw_sentido : IN  std_logic;
         sw_velocidad : IN  std_logic_vector(2 downto 0);
         sw4 : IN  std_logic;
         encoder1 : IN  std_logic;
         encoder2 : IN  std_logic;
         motor1 : OUT  std_logic;
         motor2 : OUT  std_logic;
         led_salida : OUT  std_logic;
         led_sentido : OUT  std_logic;
         led_comprueba : OUT  std_logic;
         anodo : OUT  std_logic_vector(3 downto 0);
         segmento : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal btn_reset : std_logic := '0';
   signal btn_subir : std_logic := '0';
   signal btn_bajar : std_logic := '0';
   signal sw_sentido : std_logic := '0';
   signal sw_velocidad : std_logic_vector(2 downto 0) := (others => '0');
   signal sw4 : std_logic := '0';
   signal encoder1 : std_logic := '0';
   signal encoder2 : std_logic := '0';

 	--Outputs
   signal motor1 : std_logic;
   signal motor2 : std_logic;
   signal led_salida : std_logic;
   signal led_sentido : std_logic;
   signal led_comprueba : std_logic;
   signal anodo : std_logic_vector(3 downto 0);
   signal segmento : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: juntar PORT MAP (
          clk => clk,
          btn_reset => btn_reset,
          btn_subir => btn_subir,
          btn_bajar => btn_bajar,
          sw_sentido => sw_sentido,
          sw_velocidad => sw_velocidad,
          sw4 => sw4,
          encoder1 => encoder1,
          encoder2 => encoder2,
          motor1 => motor1,
          motor2 => motor2,
          led_salida => led_salida,
          led_sentido => led_sentido,
          led_comprueba => led_comprueba,
          anodo => anodo,
          segmento => segmento
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
   -- Clock process definitions
   enc_process :process
   begin
	 for i in 0 to 120 loop
		encoder1 <= '0';
		encoder2 <= '0';
		wait for 75 us;
		encoder1 <= '1';
		encoder2 <= '0';	
		wait for 75  us;
		encoder1 <= '1';
		encoder2 <= '1';			
		wait for 75  us;
		encoder1 <= '0';
		encoder2 <= '1';
		wait for 75  us;
   end loop;
	while true loop
		encoder1 <= '0';
		encoder2 <= '0';
		wait for 100 us;
		encoder1 <= '1';
		encoder2 <= '0';	
		wait for 100  us;
		encoder1 <= '1';
		encoder2 <= '1';			
		wait for 100  us;
		encoder1 <= '0';
		encoder2 <= '1';
		wait for 100  us;
   end loop;
   end process;


   -- Stimulus process
   stim_proc: process
   begin		
      btn_reset <= '1';
		sw4 <= '1';
      wait for 100 ns;	
      btn_reset <= '0';
      wait for clk_period*10;
		sw_velocidad <= "100";
		wait for 100 ns;	
		btn_subir <= '1';
		wait for 200 ns;
		btn_subir <= '0';
		sw_velocidad <= "000";
      -- insert stimulus here 

      wait;
   end process;

END;
