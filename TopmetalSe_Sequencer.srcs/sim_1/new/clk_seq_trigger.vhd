----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2025 04:59:53 PM
-- Design Name: 
-- Module Name: clk_seq_trigger - Behavioral
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

entity clk_seq_trigger is
--  Port ( );
end clk_seq_trigger;

architecture Behavioral of clk_seq_trigger is
    COMPONENT clock_sequencer PORT(
        CLK     : IN std_logic;
        RESET   : IN std_logic;
       
        ENABLE  : IN std_logic;
        
        STOP_ADDR : IN integer; --used to signal a stop at a certain address, set it higher than 10,000 to disable
       
        ADC_IN  : IN unsigned(7 DOWNTO 0);
        
        THRESH_SET: IN std_logic;
        THRESH_VAL : IN signed(7 downto 0);
        
        --OUTPUTS
        LA_ROW_SHIFT    : OUT std_logic;
        LA_COL_SHIFT    : OUT std_logic;
        
        ROW_DAT_IN      : OUT std_logic;
        COL_DAT_IN      : OUT std_logic;
        
        ROW_CLK         : OUT std_logic;
        COL_CLK         : OUT std_logic;
        
        ROW_RESET       : OUT std_logic;
        COL_RESET       : OUT std_logic;
       
        TRIGGER_OUT     : OUT std_logic;
        FRAME_START     : OUT std_logic  
    
    );
    END COMPONENT;
    
    
begin


end Behavioral;
