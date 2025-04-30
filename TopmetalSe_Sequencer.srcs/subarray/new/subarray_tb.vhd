----------------------------------------------------------------------------------
-- Company: University of Washington CENPA
-- Engineer: Harry Ni
-- 
-- Create Date: 03/28/2023 04:07:36 PM
-- Design Name: TopmetalSe Sequencer
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

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
 
USE IEEE.NUMERIC_STD.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
 

entity subarray_tb is
--  Port ( );
end subarray_tb;
 
architecture Behavioral of subarray_tb is
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
    
      COMPONENT shift_register
    PORT(
      CLK   : IN std_logic;
      ENA   : IN std_logic;
      RST : IN std_logic;
      DATA_IN:IN std_logic;
      
      DATA_OUT: OUT std_logic;
      COL_SEL : OUT std_logic_vector(99 downto 0)
    );
  END COMPONENT;
    
    CONSTANT EXTERN_CLK_period     : time := 50 ns;

    SIGNAL EXTERN_CLK : std_logic;
    SIGNAL RST: std_logic;
    
    SIGNAL ADC_VAL: unsigned(7 downto 0);
    
    SIGNAL ROW_SHIFT: std_logic;
    SIGNAL COL_SHIFT: std_logic;
    SIGNAL ROW_DAT: std_logic;
    SIGNAL COL_DAT: std_logic;
    SIGNAL ROW_RESET: std_logic;
    SIGNAL COL_RESET: std_logic;
    SIGNAL ROW_CLK : std_logic;
    SIGNAL COL_CLK: std_logic;
    
    SIGNAL TRIG_OUT: std_logic;
    SIGNAL P0: std_logic;
    
    file test_ADC_vals: text;
    
    SIGNAL ROW_SEL    : std_logic_vector (99 downto 0);
    SIGNAL COL_SEL    : std_logic_vector (99 downto 0);
    
    
    
BEGIN
    EXTERN_CLK_process: PROCESS
       BEGIN
        EXTERN_CLK <= '0';
        WAIT FOR EXTERN_CLK_period/2;
        EXTERN_CLK <= '1';
        WAIT FOR EXTERN_CLK_period/2;
    END PROCESS;
    
    DUT : clock_sequencer PORT MAP(
        clk => EXTERN_CLK, 
        RESET => RST,
        ENABLE => '1',
        STOP_ADDR => 12000,
        ADC_IN => ADC_VAL,
        THRESH_SET => '0',
        THRESH_VAL => "00000000",
        LA_ROW_SHIFT=> ROW_SHIFT,
        LA_COL_SHIFT=> COL_SHIFT,
        ROW_DAT_IN => ROW_DAT,
        COL_DAT_in => COL_DAT,
        ROW_CLK => ROW_CLK,
        COL_CLK => COL_CLK,
        ROW_RESET => ROW_RESET,
        COL_RESET => COL_RESET,
        TRIGGER_OUT => TRIG_OUT,
        FRAME_START => P0
    );
-- Insantiate Row and Column Shift Registers
   SR_ROW: shift_register PORT MAP(
        CLK     => ROW_CLK,
        ENA     => ROW_SHIFT,
        RST   => ROW_RESET,
        DATA_IN => ROW_DAT,
        
        DATA_OUT => open,
        COL_SEL  => ROW_SEL
 
    );
    SR_COL: shift_register PORT MAP(
        CLK     => COL_CLK,
        ENA     => COL_SHIFT,
        RST   =>   COL_RESET,
        DATA_IN => COL_DAT,
        
        DATA_OUT => open,
        COL_SEL  => COL_SEL
    );








end Behavioral;
