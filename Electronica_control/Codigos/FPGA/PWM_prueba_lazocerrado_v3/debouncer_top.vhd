----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:48:54 07/07/2019 
-- Design Name: 
-- Module Name:    debouncer_top - Behavioral 
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

entity debouncer_top is
    Port ( clk : in  STD_LOGIC;
			  btn_reset : in  STD_LOGIC;
           btn_in : in  STD_LOGIC;
           btn_out : out  STD_LOGIC);
end debouncer_top;

architecture Behavioral of debouncer_top is

	--constant CNT_SIZE : integer := 19;
	constant CNT_SIZE : integer := 2; -- Valor para simular
   signal btn_prev   : std_logic := '0';
   signal counter    : std_logic_vector(CNT_SIZE downto 0) := (others => '0');

begin

	debouncer: Process (btn_reset, clk)
   begin
		if btn_reset = '1' then
			counter <= (others => '0');
			btn_prev <= '0';
			btn_out <= '0';
		elsif (clk'event and clk='1') then
			if (btn_prev xor btn_in) = '1' then
				counter <= (others => '0');
				btn_prev <= btn_in;
			elsif (counter(CNT_SIZE) = '0') then
				counter <= counter + 1;
        	else
				btn_out <= btn_prev;
			end if;
		end if;
   end process;

end Behavioral;

