----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2025 12:25:33 PM
-- Design Name: 
-- Module Name: subarray - Behavioral
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

entity subarray is
    Port ( 
            --INPUTS
    CLK     : IN std_logic;
    RESET   : IN std_logic;
   
    ENABLE  : IN std_logic;
    
    STOP_ADDR : IN integer; --used to signal a stop at a certain address, set it higher than 10,000 to disable
   
    ADC_IN  : IN unsigned(7 DOWNTO 0) := (others=>'0');
    
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
end subarray;

architecture Behavioral of subarray is
    SIGNAL TM_CLK_BUF   : std_logic;
    SIGNAL LA_ROW_SHIFT_BUF : std_logic; --Acts as Enable Pin
    SIGNAL LA_COL_SHIFT_BUF : std_logic; -- Acts as Enable Pin
    
        
    SIGNAL ROW_ADDR     : unsigned(7 DOWNTO 0);
    SIGNAL COL_ADDR     : unsigned(7 DOWNTO 0);
    TYPE driveState_t IS (S0, S1, S2, COL_SHIFT, ROW_SHIFT);
    SIGNAL driveState      : driveState_t;
    
    SIGNAL pxl_addr : integer := 0; 
    SIGNAL pxl_trig : integer :=20;
    SIGNAL latency  : integer :=6; --in order to account for latency from ADC 
    
    SIGNAL SPEAK : std_logic := '1';
    SIGNAL ROW_RESET_buf : std_logic;
    SIGNAL COL_RESET_buf : std_logic;
    
    SIGNAL SUBARRAY_ON: std_logic := '1';
    SIGNAL CLOCK_COUNT: integer := 1;
    SIGNAL TEST_FLAG : std_logic :='0';
    

begin
   --TM_CLK_BUF <= CLK;
   LA_ROW_SHIFT <= LA_ROW_SHIFT_BUF;
   LA_COL_SHIFT <= LA_COL_SHIFT_BUF;
   

   ROW_RESET <= RESET;
   COL_RESET <= RESET;
   
--    ROW_CLK <= TM_CLK_BUF;
--    COL_CLK <= TM_CLK_BUF;

   LA_clock: PROCESS(TM_CLK_BUF, RESET, ENABLE)
   BEGIN
        IF RESET = '1' or ENABLE = '0' THEN
            driveState <= S0;
            LA_ROW_SHIFT_BUF <= '0';
            LA_COL_SHIFT_BUF <= '0';
            pxl_addr <= 0;
            SPEAK <= '1';
            ROW_RESET_buf <= '0';
            COL_RESET_buf <= '0';
            
        ELSIF FALLING_EDGE(TM_CLK_BUF) THEN
            IF SPEAK = '1' THEN 
            
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
                
                
                IF pxl_addr /= stop_addr THEN
                    driveState<= S2;
                END IF;
          
            WHEN S2 =>
                
                ROW_DAT_IN<='0';
                COL_DAT_IN<='0';            
                
                LA_ROW_SHIFT_BUF <= '0';
                
                COL_ADDR <= COL_ADDR + 1;
                IF pxl_addr /= stop_addr then 
                    driveState <= COL_SHIFT;
                    pxl_addr <= pxl_addr +1;
                    --pxl_addr_next <= pxl_addr_next+1;
                ELSE
                    LA_ROW_SHIFT_BUF <= '0';
                    LA_COL_SHIFT_BUF <= '0';
                    SPEAK <= '0';
                END IF;
            WHEN COL_SHIFT =>
                pxl_addr <= pxl_addr +1;
                --pxl_addr_next <= pxl_addr_next +1;
				FRAME_START <= '0';
                --ROW_DAT_IN <= '0';
                
                --IF pxl_addr_next >= 9999 then
                 --   pxl_addr_next <= 0;
                --END IF;
                IF pxl_addr >= 225 then
                    pxl_addr <= 0;
                END IF;
                IF pxl_addr = stop_addr then
                    LA_ROW_SHIFT_BUF <= '0';
                    LA_COL_SHIFT_BUF <= '0';
                    SPEAK <= '0';
               
                ELSIF (COL_ADDR >= 14) THEN
                    
                    
                    COL_ADDR <= "00000000";
                    COL_DAT_IN <='1';
                    
                    LA_ROW_SHIFT_BUF<= '1';
                    IF (ROW_ADDR>=14) THEN
                        ROW_DAT_IN <= '1';
                    ELSE
                        ROW_DAT_IN<='0';                    
                    END IF;
                    
                    driveState<=ROW_SHIFT;
                    
                ELSE
                    COL_ADDR <= COL_ADDR + 1;
                    --LA_COL_SHIFT_BUF <= NOT LA_COL_SHIFT_BUF;
                                       
                END IF;
            WHEN ROW_SHIFT =>
            IF SPEAK = '1' THEN
                LA_ROW_SHIFT_BUF<= '0';
                COL_DAT_IN<='0';
                COL_ADDR <= COL_ADDR + 1;
                pxl_addr <= pxl_addr+1;
                --pxl_addr_next <= pxl_addr_next +1;
                IF (ROW_ADDR >= 14) THEN
                    ROW_ADDR<="00000000";
                    
                    driveState<=COL_SHIFT;
                   
					FRAME_START <= '1';
                ELSE
                    ROW_ADDR <= ROW_ADDR + 1;
                    driveState<=COL_SHIFT;
                    
 
                END IF;
            END IF;

            END CASE;
            
            END IF;
        END IF;
   
   END process;

--   SLOW_CLOCK_GEN: PROCESS(CLK, RESET, ENABLE)
--   BEGIN
--        IF(RESET='1') then
--            CLOCK_COUNT<=1;
--            --tmp<='0';
--        elsif(falling_edge(CLK)) then
--            CLOCK_COUNT <=CLOCK_COUNT+1;
--            if (CLOCK_COUNT = 50) then
--            SLOW_CLK <= NOT SLOW_CLK;
--            CLOCK_COUNT <= 1;
--        end if;
--    end if;
   
--   END PROCESS;


    CLOCK_SEL: PROCESS(CLK, RESET, ENABLE, PXL_ADDR)
    BEGIN
        IF(RESET='1') THEN
--            ROW_CLK<=CLK;
--            COL_CLK<=CLK;
            TM_CLK_BUF <= CLK;
            CLOCK_COUNT <= 1;
        ELSIF (FALLING_EDGE(CLK)) THEN
            IF SUBARRAY_ON = '1' THEN
                IF (PXL_ADDR>=pxl_trig-4 AND PXL_ADDR<=pxl_trig+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                ELSIF (PXL_ADDR>=pxl_trig+15-4 AND PXL_ADDR<=pxl_trig+15+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                ELSIF (PXL_ADDR>=pxl_trig-30-4 AND PXL_ADDR<=pxl_trig-30+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                ELSIF (PXL_ADDR>=pxl_trig-45-4 AND PXL_ADDR<=pxl_trig-45+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                ELSIF (PXL_ADDR>=pxl_trig-15-4 AND PXL_ADDR<=pxl_trig-15+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                    
                 ELSIF (PXL_ADDR>=pxl_trig-60-4 AND PXL_ADDR<=pxl_trig-60+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                 ELSIF (PXL_ADDR>=pxl_trig+30-4 AND PXL_ADDR<=pxl_trig+30+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                 ELSIF (PXL_ADDR>=pxl_trig+45-4 AND PXL_ADDR<=pxl_trig+45+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF;
                    
                ELSIF (PXL_ADDR>=pxl_trig+60-4 AND PXL_ADDR<=pxl_trig+60+4) THEN
                
                    TEST_FLAG <='1';
                    CLOCK_COUNT <= CLOCK_COUNT +1;
                    IF (CLOCK_COUNT = 50) THEN
                        TM_CLK_BUF <= NOT TM_CLK_BUF;
                        CLOCK_COUNT <= 1;
                        ROW_CLK <= TM_CLK_BUF;
                        COL_CLK <= TM_CLK_BUF;
                    END IF; 
                ELSE
                    TEST_FLAG <='0';
                    TM_CLK_BUF <= NOT TM_CLK_BUF;
                    ROW_CLK <= TM_CLK_BUF;
                    COL_CLK <= TM_CLK_BUF;
                END IF;     
            ELSE
                TEST_FLAG <='0';
                TM_CLK_BUF <= NOT TM_CLK_BUF;
                ROW_CLK <= TM_CLK_BUF;
                COL_CLK <= TM_CLK_BUF;
            
            END IF;
         END IF;
     
    END PROCESS;

end Behavioral;
