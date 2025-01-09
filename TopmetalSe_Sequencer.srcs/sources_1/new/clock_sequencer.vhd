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
    

end clock_sequencer;

architecture Behavioral of clock_sequencer is

    SIGNAL TM_CLK_BUF   : std_logic;
    SIGNAL LA_ROW_SHIFT_BUF : std_logic; --Acts as Enable Pin
    SIGNAL LA_COL_SHIFT_BUF : std_logic; -- Acts as Enable Pin
    
        
    SIGNAL ROW_ADDR     : unsigned(7 DOWNTO 0);
    SIGNAL COL_ADDR     : unsigned(7 DOWNTO 0);
    
    TYPE driveState_t IS (S0, S1, S2, COL_SHIFT, ROW_SHIFT);
    SIGNAL driveState      : driveState_t;
    
    SIGNAL pxl_addr : integer := 0; 
    
    SIGNAL SPEAK : std_logic := '1';
    
    SIGNAL adc_in_buf: unsigned(7 downto 0);
    SIGNAL adc_in_buf_2: unsigned(7 downto 0);
    SIGNAL adc_val_prev_frame : unsigned(7 downto 0);
    SIGNAL bram_out: std_logic_vector(7 downto 0);
    SIGNAL diff : signed(7 downto 0);
    SIGNAL pxl_addr_next: integer :=1;
    SIGNAL trigger_threshold: signed(7 downto 0) := to_signed(3,8);
    
    SIGNAL pxl_addr_stdvec: std_logic_vector(13 downto 0);
    SIGNAL pxl_addr_next_stdvec: std_logic_vector(13 downto 0);

    SIGNAL TRIGGER_BUF: std_logic;
    COMPONENT adc_frame_mem is
    PORT(
        clka : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clkb : IN STD_LOGIC;
        addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
   
    );
    END COMPONENT;
BEGIN
   TM_CLK_BUF <= CLK;
   LA_ROW_SHIFT <= LA_ROW_SHIFT_BUF;
   LA_COL_SHIFT <= LA_COL_SHIFT_BUF;
   
   ROW_RESET <= RESET;
   COL_RESET <= RESET;
   
   ROW_CLK <= CLK;
   COL_CLK <= CLK;
   
   pxl_addr_stdvec <= std_logic_vector(to_unsigned(pxl_addr,14));
   pxl_addr_next_stdvec <= std_logic_vector(to_unsigned(pxl_addr_next,14));
   
   adc_in_buf <= adc_in;
   
   TRIGGER_OUT <= TRIGGER_BUF;
   
   adc_frame_mem_inst: adc_frame_mem
   port map(
    clka => CLK,
    wea => "1",
    addra=> pxl_addr_stdvec,
    dina => std_logic_vector(adc_in_buf),
    clkb => CLK,
    addrb => pxl_addr_next_stdvec,
    doutb => bram_out
   );
   
   LA_clock: PROCESS(CLK, RESET, ENABLE)
   BEGIN
        IF RESET = '1' or ENABLE = '0' THEN
            driveState <= S0;
            LA_ROW_SHIFT_BUF <= '0';
            LA_COL_SHIFT_BUF <= '0';
            pxl_addr <= 0;
            pxl_addr_next <=1;
            SPEAK <= '1';
        ELSIF FALLING_EDGE(CLK) THEN
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
                    pxl_addr_next <= pxl_addr_next+1;
                ELSE
                    LA_ROW_SHIFT_BUF <= '0';
                    LA_COL_SHIFT_BUF <= '0';
                    SPEAK <= '0';
                END IF;
            WHEN COL_SHIFT =>
                pxl_addr <= pxl_addr +1;
                pxl_addr_next <= pxl_addr_next +1;
				FRAME_START <= '0';
                --ROW_DAT_IN <= '0';
                
                IF pxl_addr_next >= 9999 then
                    pxl_addr_next <= 0;
                END IF;
                IF pxl_addr >= 9999 then
                    pxl_addr <= 0;
                END IF;
                IF pxl_addr = stop_addr then
                    LA_ROW_SHIFT_BUF <= '0';
                    LA_COL_SHIFT_BUF <= '0';
                    SPEAK <= '0';
               
                ELSIF (COL_ADDR >= 99) THEN
                    
                    
                    COL_ADDR <= "00000000";
                    COL_DAT_IN <='1';
                    
                    LA_ROW_SHIFT_BUF<= '1';
                    IF (ROW_ADDR>=99) THEN
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
                pxl_addr_next <= pxl_addr_next +1;
                IF (ROW_ADDR >= 99) THEN
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
   
   
   TRIGGER: PROCESS(CLK, PXL_ADDR, RESET)
   BEGIN
    IF RESET = '1' THEN
        TRIGGER_BUF <= '0';
    ELSIF FALLING_EDGE(CLK) THEN
        IF trigger_buf = '1' THEN
            trigger_buf <= '0';
        END IF;
        adc_in_buf_2 <= adc_in_buf;
        adc_val_prev_frame <= unsigned(bram_out);
        
        --compare
        diff <= signed(adc_in_buf_2 - adc_val_prev_frame);
        IF diff > trigger_threshold THEN
            trigger_buf <= '1'; -- trigger out comes 2 clock cycles later
        END IF;
        
    END IF;
     
   END PROCESS;
   
   SET_TRIGGER: PROCESS(CLK, THRESH_SET, RESET)
   BEGIN
    IF RESET = '1' THEN
        trigger_threshold <= "00000011";
    ELSIF FALLING_EDGE(CLK) THEN
        IF THRESH_SET = '1' THEN
            trigger_threshold<=THRESH_VAL;
        END IF;
    END IF;
   END PROCESS;
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
    
