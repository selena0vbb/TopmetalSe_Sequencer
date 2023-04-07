----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/28/2023 04:07:36 PM
-- Design Name: 
-- Module Name: tmSe_leader - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;


entity tmSe_leader is
    Port (
    --INPUTS
    CLK     : IN std_logic;
    RESET   : IN std_logic;
    

    --OUTPUTS
    LA_ROW_SHIFT    : OUT std_logic;
    LA_ROW_DAT_IN   : OUT std_logic;
    
    LA_COL_SHIFT    : OUT std_logic;
    LA_COL_DAT_IN   : OUT std_logic
     );

END tmSe_leader;

architecture Behavioral of tmSe_leader is
    
    SIGNAL TM_CLK_BUF   : std_logic;
    SIGNAL LA_ROW_SHIFT_BUF : std_logic;
    SIGNAL LA_COL_SHIFT_BUF : std_logic;
    SIGNAL LA_ROW_DAT_BUF   : std_logic;
    SIGNAL LA_COL_DAT_BUF   : std_logic;
    
    
    SIGNAL ROW_ADDR     : unsigned(8 DOWNTO 0);
    SIGNAL COL_ADDR     : unsigned(8 DOWNTO 0);
    
    TYPE driveState_t IS (S0, S1, S2);
    SIGNAL driveState      : driveState_t;
    
    --DEVICES
    COMPONENT clock_sequencer
       PORT(
        CLK     : IN std_logic;
        RESET   : IN std_logic;
    
        --OUTPUTS
        LA_ROW_SHIFT    : OUT std_logic;
        LA_COL_SHIFT    : OUT std_logic;
        ROW_DAT_IN      : OUT std_logic;
        COL_DAT_IN      : OUT std_logic
    );
    END COMPONENT;
    
    

BEGIN
    TM_CLK_BUF <= CLK;
    LA_ROW_SHIFT <= LA_ROW_SHIFT_BUF;
    LA_COL_SHIFT <= LA_COL_SHIFT_BUF;
    LA_ROW_DAT_IN <= LA_ROW_DAT_BUF;
    LA_COL_DAT_IN <= LA_COL_DAT_BUF;

    
   -- Instantiate the sequencer
    CLK_SEQ: clock_sequencer PORT MAP (
    CLK           => CLK,
    RESET         => RESET,
    
    LA_ROW_SHIFT  => LA_ROW_SHIFT_BUF,
    LA_COL_SHIFT  => LA_COL_SHIFT_BUF,
    ROW_DAT_IN    => LA_ROW_DAT_BUF,
    COL_DAT_IN    => LA_COL_DAT_BUF
    );
    
    
    

end Behavioral;
