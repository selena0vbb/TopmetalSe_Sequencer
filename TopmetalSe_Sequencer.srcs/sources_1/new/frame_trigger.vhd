----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2025 12:41:50 PM
-- Design Name: 
-- Module Name: frame_trigger - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frame_trigger is
    PORT (
        trigger_adc       : IN unsigned(7 DOWNTO 0);
        trigger_thresh : IN std_logic_vector(7 DOWNTO 0);
        -- output
        TRIGGER_OUT   : OUT std_logic
   );
end frame_trigger;

architecture Behavioral of frame_trigger is
    --COMPONENT adc_mem is
     --   PORT();
    --end component;

    

begin


end Behavioral;
