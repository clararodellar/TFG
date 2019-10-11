----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:36:45 07/08/2019 
-- Design Name: 
-- Module Name:    binary_to_bcd - Behavioral 
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

entity binary_to_bcd is
    Port ( bin : in  STD_LOGIC_VECTOR (7 downto 0);
           bcd : out  STD_LOGIC_VECTOR (11 downto 0));
end binary_to_bcd;

architecture Behavioral of binary_to_bcd is

begin

	proceso_bcd: Process (bin) 
		variable bcd_signal : STD_LOGIC_VECTOR (11 downto 0);
	   variable bin_signal : STD_LOGIC_VECTOR (7 downto 0);

   begin
		bin_signal := bin;
		bcd_signal := (others => '0');
		
		for i in 0 to 7 loop
			bcd_signal(11 downto 1) := bcd_signal(10 downto 0); -- shift bcd 
			bcd_signal(0) := bin_signal(7); -- + 1 new entry
			bin_signal(7 downto 1) := bin_signal(6 downto 0); -- shift src 
			bin_signal(0) := '0'; -- + pad with 0
			
			if (i < 7 and bcd_signal(3 downto 0) > "0100") then
				bcd_signal(3 downto 0) := std_logic_vector(unsigned(bcd_signal(3 downto 0)) + "0011") ;
			end if ;
			if (i < 7 and bcd_signal(7 downto 4) > "0100") then
				bcd_signal(7 downto 4) := std_logic_vector(unsigned(bcd_signal(7 downto 4)) + "0011") ;
			end if ;
			if (i < 7 and bcd_signal(11 downto 8) > "0100") then
				bcd_signal(11 downto 8) := std_logic_vector(unsigned(bcd_signal(11 downto 8)) + "0011") ;
			end if ;
		end loop ;
		bcd <= bcd_signal;
	end process;


end Behavioral;

