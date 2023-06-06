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
    INTERN_CLK     : IN std_logic; --Internal 100 MHz Clock
   
    EXTERN_CLK     : IN std_logic; --External 1-25 MHz Clock 
    
    --Switches
    RESET          : IN std_logic;
    CONFIGURE_LED   :IN std_logic;
    
    USB_SERIAL      : IN std_logic;
    
    SA_COL          : IN STD_LOGIC_VECTOR( 2 downto 0);
    SA_ROW          : IN STD_LOGIC_VECTOR( 2 downto 0);
    
    
    --OUTPUTS
    --Below clocks shift registers of large array
    LA_ROW_SHIFT    : OUT std_logic;
    LA_ROW_DAT_IN   : OUT std_logic;
    LA_ROW_RESET    : OUT std_logic;
    LA_ROW_CLK      : OUT std_logic;
    
    LA_COL_SHIFT    : OUT std_logic;
    LA_COL_DAT_IN   : OUT std_logic;
    LA_COL_RESET    : OUT std_logic;
    LA_COL_CLK      : OUT std_logic;
    
    --Below controls small array(clocking and single pixel selection)
    SA_ROW_OUT          : OUT STD_LOGIC_VECTOR( 2 downto 0); --PMOD
    SA_COL_OUT          : OUT STD_LOGIC_VECTOR( 2 downto 0); --PMOD
    
    SPI_OUT         : OUT std_logic; --PMOD
    SPI_SYNC        : OUT std_logic; --PMOD
    SPI_SCLK        : OUT std_logic;  --PMOD
    
    led             : OUT std_logic_vector(15 downto 0)
    --CLK_OUT         : OUT std_logic
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
    
    SIGNAL UART_REG : std_logic_vector(7 downto 0);
    
    SIGNAL UART_RX_VALID : std_logic;
    SIGNAL SPI_DAT_VALID: std_logic; -- used to signal that we've received 3 bytes from uart
    
    
    SIGNAL UART_DAC_STATE: std_logic_vector(1 downto 0) := "00"; -- stores which of the 4 setes of 8 bits in the 32 bit value we are in from the UART
    
    SIGNAL DAC_DAT_REG : std_logic_vector(31 downto 0); --Stores 32 bit incoming data from UART, used for DAC SPI, UART IS 8 bits at a time
    SIGNAL DAC_DAT_VAL : std_logic; 
    
    TYPE bridgeState_s IS (IDLE, DAT_IN0, DAT_IN1, DAT_IN2, DAT_IN3, STOP, SPI_WAIT, S_RESET);
    SIGNAL bridgeState : bridgeState_s := IDLE;
    
    SIGNAL LARGE_ARRAY_ENABLE : std_logic := '1';
    
    SIGNAL wait_cycle : integer := 800; -- clock cycles to wait after reading in UART before resetting (need for writing to SPI)
    
    SIGNAL SA_ROW_BUF : STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL SA_COL_BUF : STD_LOGIC_VECTOR (2 downto 0);
        
        
    SIGNAL LED_BUF    : std_logic_vector(31 downto 0);
    --DEVICES
    COMPONENT clock_sequencer
       PORT(
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
    END COMPONENT;
    
    COMPONENT uart_rx --8 bit UART receiver
        PORT(
		i_CLK       : in std_logic; --in clock
	    i_RX_Serial : in std_logic; --serial data in
	    o_RX_valid     : out std_logic; -- data byte valid
	    o_RX_Byte   : out std_logic_vector(7 downto 0) --value out 
		);
    END COMPONENT; 
    
    COMPONENT DAC_SPI
        PORT(
        CLK_IN  : in std_logic;
        RESET   : in std_logic;
        DATA_IN : in std_logic_vector(31 downto 0);
        DATA_VAL : in std_logic;
        
        DATA_OUT    : out std_logic;
        SYNC_OUT    : out std_logic;
        SCLK     : out std_logic
        );
    END COMPONENT;
    
BEGIN
    TM_CLK_BUF <= EXTERN_CLK;
    LA_ROW_SHIFT <= LA_ROW_SHIFT_BUF;
    LA_COL_SHIFT <= LA_COL_SHIFT_BUF;
    LA_ROW_DAT_IN <= LA_ROW_DAT_BUF;
    LA_COL_DAT_IN <= LA_COL_DAT_BUF;

    
   -- Instantiate the sequencer
    CLK_SEQ: clock_sequencer PORT MAP (
    CLK           => EXTERN_CLK,
    RESET         => RESET,
    ENABLE        => LARGE_ARRAY_ENABLE,
    LA_ROW_SHIFT  => LA_ROW_SHIFT_BUF,
    LA_COL_SHIFT  => LA_COL_SHIFT_BUF,
    ROW_DAT_IN    => LA_ROW_DAT_BUF,
    COL_DAT_IN    => LA_COL_DAT_BUF,
    ROW_RESET     => LA_ROW_RESET,
    COL_RESET     => LA_COL_RESET,
    ROW_CLK       => LA_ROW_CLK,
    COL_CLK       => LA_COL_CLK
    );
    
    --Instantiate a UART, and SPI for a UART-SPI Bridge
    
    UART_RX_USB : uart_rx PORT MAP(
    i_CLK => INTERN_CLK,
    i_RX_Serial => USB_SERIAL,
    o_RX_valid => UART_RX_VALID,
    o_RX_byte => UART_REG
   
    );
  
    SPI_WX_DAC : DAC_SPI PORT MAP(
    CLK_IN => INTERN_CLK,
    RESET => RESET,
    DATA_IN => DAC_DAT_REG,
    DATA_VAL => DAC_DAT_VAL, 
    
    DATA_OUT => SPI_OUT,
    SYNC_OUT => SPI_SYNC,
    SCLK => SPI_SCLK
    );  
    
    
    SA_CLOCK: process(EXTERN_CLK)
    BEGIN --delay for small array
        IF FALLING_EDGE(EXTERN_CLK) then
            SA_ROW_BUF <= SA_ROW;
            SA_COL_BUF <= SA_COL;
            
            SA_ROW_OUT <= SA_ROW_BUF;
            SA_COL_OUT <= SA_COL_BUF;
             
        END IF;
    END PROCESS;
    
    
    
    UART_SPI_DAC: process(INTERN_CLK, UART_RX_VALID, RESET)
    
    BEGIN

        IF RESET = '1' THEN
            bridgeState <= IDLE;
            UART_DAC_STATE<= "00";
            --UART_RX_VALID <= '0';
            DAC_DAT_VAL <= '0';
            DAC_DAT_REG <= (others => '0');
            wait_cycle <= 800;
        --Collects 32 bit value from UART, sends to SPI Module
        --Primary Handler for USB Communication
        --Data Packets are 8 + 32
        --8 bits are communications for FPGA, 32 are for the DACs
        --Use python USB code to control the generation of the signals (see elsewhere)
        --8 bits control clocking primarily, use them to switch between control clock signals and control DAC signals

        ELSIF FALLING_EDGE(INTERN_CLK) then
            case bridgeState is
                WHEN IDLE =>
                
                    IF UART_RX_VALID = '1' THEN
                    
                        IF UART_DAC_STATE = "00" THEN
                            bridgeState <= DAT_IN0;
                        ELSIF UART_DAC_STATE = "01" THEN
                            bridgeState <= DAT_IN1;
                        ELSIF UART_DAC_STATE = "10" THEN
                            bridgeState <= DAT_IN2;
                        ELSIF UART_DAC_STATE = "11" THEN
                            bridgeState <= DAT_IN3;
                        END IF;
                        
                     END IF;
                WHEN DAT_IN0 =>
                    DAC_DAT_REG(7 DOWNTO 0) <= UART_REG;
                    UART_DAC_STATE <= "01";
                    bridgeState <= IDLE;
                WHEN DAT_IN1 =>
                    DAC_DAT_REG(15 DOWNTO 8) <= UART_REG;
                    UART_DAC_STATE <= "10";
                    bridgeState <= IDLE;
                WHEN DAT_IN2 =>
                    DAC_DAT_REG(23 DOWNTO 16) <= UART_REG;
                    UART_DAC_STATE <= "11";
                    bridgeState <= IDLE;
                WHEN DAT_IN3 =>
                    DAC_DAT_REG(31 DOWNTO 24) <= UART_REG;
                    --UART_STATE <= "11";
                    bridgeState <= STOP;
                WHEN STOP =>
                    DAC_DAT_VAL <=  '1';
                    
                    bridgeState<= SPI_WAIT;
                WHEN SPI_WAIT =>
                    DAC_DAT_VAL<= '0';
                    --wait few clock cycles before resetting
                    IF wait_cycle = 0 THEN
                        bridgeState <= S_RESET;
                    ELSE
                        wait_cycle <= wait_cycle -1;
                    END IF;
                WHEN S_RESET =>
                    wait_cycle <= 800;
                    bridgeState <= IDLE;
                    DAC_DAT_REG <= (others => '0');
                    DAC_DAT_VAL <= '0';
                    UART_DAC_STATE<= "00";
                    
           END CASE;         
        END IF;
    
    END PROCESS;
    
    UART_LED_SIGNAL: process(INTERN_CLK, DAC_DAT_VAL)
    
    BEGIN
        IF rising_edge(DAC_DAT_VAL) THEN
            led_buf <= DAC_DAT_REG;
        END IF;
        
        IF falling_edge(INTERN_CLK) THEN
            if CONFIGURE_LED = '1' THEN
                led <= led_buf(31 downto 16);
            else
                led <= led_buf(15 downto 0);
            END IF;
        END IF;
        
    END PROCESS;
    

    
end Behavioral;
