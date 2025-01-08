----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/06/2025 05:06:05 PM
-- Design Name: 
-- Module Name: trigger_tb - Behavioral
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
 

 
entity trigger_tb is
--  Port ( );
end trigger_tb;

architecture Behavioral of trigger_tb is


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
    
    begin
    
    --clocks
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
    
    process
        variable iline: line;
        variable read_value: std_logic_vector(7 downto 0);
        
    begin
        -- RESET to start
        RST <= '1';
        WAIT FOR EXTERN_CLK_period;
        RST <= '0';
        WAIT FOR EXTERN_CLK_period;
        --READ FILES
        file_open(test_ADC_vals, "/home/selena/TopmetalSe_Sequencer/sim_files/ADC_values.txt", read_mode);
        while not endfile(test_ADC_vals) loop
            readline(test_ADC_vals, iline);
            read(iline, read_value);
            ADC_VAL <= unsigned(read_value);
            wait for EXTERN_CLK_period;
            
        end loop;
        
        wait;
    end process;
end Behavioral;
