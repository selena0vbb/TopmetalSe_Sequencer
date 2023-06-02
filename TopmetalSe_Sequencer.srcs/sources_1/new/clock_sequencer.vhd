----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2023 11:14:37 AM
-- Design Name: 
-- Module Name: clock_sequencer - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity clock_sequencer is
    Port ( 
            --INPUTS
    CLK     : IN std_logic;
    RESET   : IN std_logic;
   
    ENABLE  : IN std_logic;
   
    --OUTPUTS
    LA_ROW_SHIFT    : OUT std_logic;
    LA_COL_SHIFT    : OUT std_logic;
    
    ROW_DAT_IN      : OUT std_logic;
    COL_DAT_IN      : OUT std_logic;
    
    ROW_CLK         : OUT std_logic;
    COL_CLK         : OUT std_logic;
    
    ROW_RESET       : OUT std_logic;
    COL_RESET       : OUT std_logic
    
    );
    

end clock_sequencer;

architecture Behavioral of clock_sequencer is

    SIGNAL TM_CLK_BUF   : std_logic;
    SIGNAL LA_ROW_SHIFT_BUF : std_logic; --Acts as Enable Pin
    SIGNAL LA_COL_SHIFT_BUF : std_logic; -- Acts as Enable Pin
    
        
    SIGNAL ROW_ADDR     : unsigned(7 DOWNTO 0);
    SIGNAL COL_ADDR     : unsigned(7 DOWNTO 0);
    
    TYPE driveState_t IS (S0, S1, S2, COL_SHIFT, ROW_SHIFT);
    SIGNAL driveState      : driveState_t;
    
    TYPE SA_driveState_t IS (idle, prepare, clock);
    signal SA_driveState    : SA_driveState_t;
    
    
BEGIN
   TM_CLK_BUF <= CLK;
   LA_ROW_SHIFT <= LA_ROW_SHIFT_BUF;
   LA_COL_SHIFT <= LA_COL_SHIFT_BUF;
   
   ROW_RESET <= RESET;
   COL_RESET <= RESET;
   
   ROW_CLK <= CLK;
   COL_CLK <= CLK;
   
   
   LA_clock: PROCESS(CLK, RESET)
   BEGIN
        IF RESET = '1' or ENABLE = '0' THEN
            driveState <= S0;
            LA_ROW_SHIFT_BUF <= '0';
            LA_COL_SHIFT_BUF <= '0';
            
        ELSIF FALLING_EDGE(CLK) THEN
            CASE driveState IS 
            
            WHEN S0 =>
                
                driveState <= S1;
            WHEN S1 =>
                --RESET these signals
                COL_ADDR <= "00000000";
                ROW_ADDR <= "00000000";
                 
                LA_ROW_SHIFT_BUF <= '1';
                LA_COL_SHIFT_BUF <= '1';
                
                ROW_DAT_IN <='1';
                COL_DAT_IN <='1';
                
                driveState <=S2;
                
            WHEN S2 =>
                
                ROW_DAT_IN<='0';
                COL_DAT_IN<='0';            
                
                LA_ROW_SHIFT_BUF <= '0';
                
                COL_ADDR <= COL_ADDR + 1;
                driveState <= COL_SHIFT;
            WHEN COL_SHIFT =>
                ROW_DAT_IN <= '0';
                
                IF (COL_ADDR >= 99) THEN
                    
                    
                    COL_ADDR <= "00000000";
                    COL_DAT_IN <='1';
                    
                    LA_ROW_SHIFT_BUF<= '1';
                    
                    driveState<=ROW_SHIFT;
                    
                    
                ELSE
                    COL_ADDR <= COL_ADDR + 1;
                    --LA_COL_SHIFT_BUF <= NOT LA_COL_SHIFT_BUF;
                                       
                END IF;
            WHEN ROW_SHIFT =>
                LA_ROW_SHIFT_BUF<= '0';
                COL_DAT_IN<='0';
                IF (ROW_ADDR >= 99) THEN
                    ROW_DAT_IN <= '1';
                    ROW_ADDR<="00000000";
                ELSE
                    --LA_ROW_SHIFT_BUF <= NOT LA_ROW_SHIFT_BUF;
                    ROW_ADDR <= ROW_ADDR + 1;
                    driveState<=COL_SHIFT;
 
                END IF;
            END CASE;
            
            
        END IF;
   
   END process;
   
   --Below is used for clocking the small array
   --For now, let's just use the switches on the FPGA 
--   SA_clock: PROCESS(CLK, RESET)
--   BEGIN
--        IF RESET = '1' or ENABLE = '0' THEN
--            SA_driveState <= IDLE;

--        ELSIF FALLING_EDGE(CLK) THEN
--            CASE SA_driveState IS 
            
--            WHEN IDLE =>
--                IF (SA_ENABLE = '1') THEN
--                    SA_driveState <= prepare;
--                END IF;
                
--            WHEN prepare =>
--                SA_driveState <= clock;
                
--            WHEN clock => 
--                IF SA_STOP = '1' THEN
--                    IF (SA_STOP_ADDR <3) THEN
                        
--                        --Select Row 1
--                    ELSIF (SA_STOP_ADDR <6) THEN
--                        -- Select Row 2
--                    ELSIF (SA_STOP_ADDR <9) THEN
--                        -- Select Row 3
--                    END IF;
--                ELSE: --clock the small array
                    
               
--                END IF;
                
--            END CASE;
            
            
--        END IF;
   
--   END process;
   
end Behavioral;
    
