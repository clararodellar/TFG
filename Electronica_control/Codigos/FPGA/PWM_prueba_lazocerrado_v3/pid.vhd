LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY PID IS
	PORT (
		clk : in STD_LOGIC;
		btn_reset : in  STD_LOGIC;
		SetVal : in std_logic_vector(15 downto 0); -- Velocidad deseada
		adc_data : in std_logic_vector(15 downto 0); -- Velocidad real
		orden_cambio_vel: in STD_LOGIC; -- Si se ha cambiado la velocidad
		fin_pwm : in STD_LOGIC;
		output : out std_logic_vector(15 downto 0) -- Velocidad con el control para conseguir la deseada
		
	);
END PID;
ARCHITECTURE Behavioral OF PID IS

	signal output_loaded: unsigned (15 downto 0); --allows to check if output is within range
	signal aumentar_vel: STD_LOGIC;
	signal cuenta : unsigned (3 downto 0);
	signal tiempo_control: STD_LOGIC;
	
BEGIN
	
	Process(SetVal, adc_data)
	begin  
	  if unsigned(SetVal) > unsigned(adc_data) then -- Si vamos más despacio de lo que queremos
	    aumentar_vel <= '1'; -- Tenemos que aumentar la velocidad
	  else 
		 aumentar_vel <= '0'; -- Tenemos que disminuir la velocidad
	  end if;
	end process;
	
	Process(btn_reset, clk)
	begin
		if btn_reset='1' then
			cuenta <= (others => '0');
		elsif clk'event and clk = '1' then
			if fin_pwm = '1' then
				if cuenta = 5 then
					cuenta <= (others => '0');
				else
					cuenta <= cuenta +1;
				end if;
			end if;
		end if;
	end process;
	
	tiempo_control <= '1' when cuenta = 5 and fin_pwm = '1' else '0';
	
	Process(btn_reset, clk, SetVal)
	begin
		if btn_reset='1' then
			output_loaded <= unsigned(SetVal);
		elsif clk'event and clk = '1' then
			if orden_cambio_vel = '1' then -- Si han cambiado la velocidad a la que quiero ir 
				output_loaded <= unsigned(SetVal); -- Actualizamos el valor de la salida
			elsif tiempo_control = '1' then -- Hacemos el control en ciclos más grandes para que al motor le de tiempo a reaccionar
				if  aumentar_vel = '1' then -- Hay que acelerar
					if output_loaded < 255 then 
						output_loaded <= output_loaded +1; -- Se hace el control
					end if;
				elsif  aumentar_vel = '0' then -- Hay que acelerar
					if output_loaded > 0 then 
						output_loaded <= output_loaded -1; -- Se hace el control
					end if;
				end if;
			end if;
		end if;
	end process;
	
	output <= std_logic_vector(output_loaded);

end Behavioral; 