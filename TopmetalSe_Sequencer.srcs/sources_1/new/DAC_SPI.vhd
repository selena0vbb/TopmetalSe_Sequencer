----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2023 05:51:53 PM
-- Design Name: 
-- Module Name: DAC_SPI - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--  SPI Interface for DAC8568 (see manual) 
--  Parallelizes Data for SPI
--  Input Handling is done elsewhere maybe?
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity DAC_SPI is

  Port (
    CLK_IN  : in std_logic;
    RESET   : in std_logic;
    DATA_IN : in std_logic_vector(31 downto 0);
    DATA_VAL : in std_logic;
    
    DATA_OUT    : out std_logic;
    SYNC_OUT    : out std_logic;
    SCLK     : out std_logic
  
  );
end DAC_SPI;

architecture Behavioral of DAC_SPI is
    SIGNAL CLK_BUF  : std_logic;
    SIGNAL DAT_REG  : std_logic_vector(31 downto 0);
    SIGNAL REG_VAL  : std_logic;
    
    SIGNAL SCLK_BUF : std_logic := '0';
    
    SIGNAL BIT_NUM  : integer  := 31;
    
    SIGNAL SYNC_BUF        : std_logic := '1'; -- High is OFF
    
    SIGNAL CLK_COUNT        : integer := 0;
    
    
    TYPE tx_state IS (IDLE, WX_OUT, WX_END);
    SIGNAL txstate      : tx_state;
    
    TYPE rx_state IS (IDLE, RX_IN, RX_WAIT);
    SIGNAL rxstate      : rx_state;
    
BEGIN
    CLK_BUF<= CLK_IN;
    SCLK <= SCLK_BUF;
    SYNC_OUT <= SYNC_BUF;
    

    DATA_RX_PROC : PROCESS(CLK_BUF, RESET)
    BEGIN
        IF RESET = '1' THEN
            rxstate <= IDLE;
            REG_VAL <= '0';
            DAT_REG<= (others => '0');
            
        ELSIF RISING_EDGE(CLK_BUF) THEN
            CASE rxstate is
                WHEN IDLE =>
                    REG_VAL <= '0';
                    --SYNC_BUF <= '1';
                    IF DATA_VAL = '1' THEN
                        rxstate <= RX_IN;
                    END IF;
                WHEN RX_IN =>
                    DAT_REG <= DATA_IN;
                    REG_VAL <= '1';
                    IF REG_VAL = '1' THEN
                        rxstate <= RX_WAIT;
                    END IF;
                WHEN RX_WAIT =>
                --Just a Buffer
                    IF txstate = WX_OUT THEN
                        rxstate <= IDLE;    
                    END IF;
            END CASE;
        END IF;
    
    END PROCESS;
    
    
    DATA_WX_PROC : PROCESS(SCLK_BUF, RESET)
    BEGIN
        IF RESET = '1' THEN
            txstate <= IDLE;
            SYNC_BUF <='1';
            BIT_NUM <= 31;
            DATA_OUT <= '0';
            
        ELSIF RISING_EDGE(SCLK_BUF) THEN
            CASE txstate IS
            
            WHEN IDLE =>
                SYNC_BUF <= '1';
                DATA_OUT<= '0';
                BIT_NUM <= 31;
                IF REG_VAL = '1' THEN
                    txstate <= WX_OUT;
                    
                END IF;
            WHEN WX_OUT =>
                SYNC_BUF <= '0';
                DATA_OUT <= DAT_REG(BIT_NUM);
                BIT_NUM <= BIT_NUM -1;
                IF BIT_NUM = 0 THEN
                    txstate <= WX_END;
                
                END IF;             
            WHEN WX_END =>
                DATA_OUT<= '0';
                SYNC_BUF <= '1';
                txstate <= IDLE;
            
            
            END CASE;
        END IF;     
    END PROCESS;
    

    
    SCLK_GEN : PROCESS(CLK_BUF, RESET)
    BEGIN
        --if RESET =  '1' THEN
        --SCLK <= '0';
        IF RISING_EDGE(CLK_BUF) THEN
            CLK_COUNT <= CLK_COUNT +1;
            IF CLK_COUNT = 3 THEN
                SCLK_BUF <= NOT SCLK_BUF;
                CLK_COUNT<=0;
            END IF;
        
        END IF;
    END PROCESS;        
    

end Behavioral;
