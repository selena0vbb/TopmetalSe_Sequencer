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
    RESET          : IN std_logic;
    
    USB_SERIAL      : IN std_logic;
    --OUTPUTS
    LA_ROW_SHIFT    : OUT std_logic;
    LA_ROW_DAT_IN   : OUT std_logic;
    
    LA_COL_SHIFT    : OUT std_logic;
    LA_COL_DAT_IN   : OUT std_logic;
    
    SPI_OUT         : OUT std_logic;
    SPI_SYNC        : OUT std_logic;
    SPI_SCLK        : OUT std_logic
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
    
    SIGNAL UART_STATE: std_logic_vector(1 downto 0) := "00"; -- stores which of the 4 setes of 8 bits in the 32 bit value we are in from the UART
    
    SIGNAL DAC_DAT_REG : std_logic_vector(31 downto 0); --Stores 32 bit incoming data from UART, used for DAC SPI, UART IS 8 bits at a time
    SIGNAL DAC_DAT_VAL : std_logic; 
    
    TYPE bridgeState_s IS (IDLE, DAT_IN0, DAT_IN1, DAT_IN2, DAT_IN3, STOP, S_RESET);
    SIGNAL bridgeState : bridgeState_s := IDLE;
    
    
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
    
    LA_ROW_SHIFT  => LA_ROW_SHIFT_BUF,
    LA_COL_SHIFT  => LA_COL_SHIFT_BUF,
    ROW_DAT_IN    => LA_ROW_DAT_BUF,
    COL_DAT_IN    => LA_COL_DAT_BUF
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
    
    
    UART_SPI_DAC: process(INTERN_CLK, UART_RX_VALID, RESET)
    BEGIN
        IF RESET = '1' THEN
            bridgeState <= IDLE;
            UART_STATE<= "00";
            --UART_RX_VALID <= '0';
            DAC_DAT_VAL <= '0';
            DAC_DAT_REG <= (others => '0');
            
        --Collects 32 bit value from UART, sends to SPI Module
        ELSIF FALLING_EDGE(INTERN_CLK) then
            case bridgeState is
                WHEN IDLE =>
                    IF UART_RX_VALID = '1' THEN
                        IF UART_STATE = "00" THEN
                            bridgeState <= DAT_IN0;
                        ELSIF UART_STATE = "01" THEN
                            bridgeState <= DAT_IN1;
                        ELSIF UART_STATE = "10" THEN
                            bridgeState <= DAT_IN2;
                        ELSIF UART_STATE = "11" THEN
                            bridgeState <= DAT_IN3;
                        END IF;
                        
                     END IF;
                WHEN DAT_IN0 =>
                    DAC_DAT_REG(31 DOWNTO 24) <= UART_REG;
                    UART_STATE <= "01";
                    bridgeState <= IDLE;
                WHEN DAT_IN1 =>
                    DAC_DAT_REG(23 DOWNTO 16) <= UART_REG;
                    UART_STATE <= "10";
                    bridgeState <= IDLE;
                WHEN DAT_IN2 =>
                    DAC_DAT_REG(15 DOWNTO 8) <= UART_REG;
                    UART_STATE <= "11";
                    bridgeState <= IDLE;
                WHEN DAT_IN3 =>
                    DAC_DAT_REG(7 DOWNTO 0) <= UART_REG;
                    --UART_STATE <= "11";
                    bridgeState <= STOP;
                WHEN STOP =>
                    DAC_DAT_VAL <=  '1';
                    bridgeState<= S_RESET;
                WHEN S_RESET =>
                    bridgeState <= IDLE;
                    DAC_DAT_REG <= (others => '0');
                    DAC_DAT_VAL <= '0';
                    UART_STATE<= "00";
                    
           END CASE;         
        END IF;
    
    END PROCESS;
    
    
    
    
    
end Behavioral;
