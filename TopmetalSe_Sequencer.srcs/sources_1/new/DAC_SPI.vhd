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
    SIGNAL SCLK_BUF : std_logic := '0';
    
    SIGNAL BIT_NUM  : integer  := 31;
    
    SIGNAL SYNC_BUF        : std_logic := '1'; -- High is OFF
    
BEGIN
    CLK_BUF<= CLK_IN;
    SCLK <= SCLK_BUF;
    SYNC_OUT <= SYNC_BUF;
    DATA_STORE : process (CLK_IN, RESET)
    BEGIN
        IF RESET = '1' THEN
            DAT_REG <= (others => '0');
        ELSIF rising_edge(CLK_IN) THEN
            IF DATA_VAL = '1' THEN
                DAT_REG <= DATA_IN;
            END IF;
        END IF;
              
    END PROCESS;
    
    
    SCLK_GEN : PROCESS(CLK_BUF, RESET)
    BEGIN
        --if RESET =  '1' THEN
        --SCLK <= '0';
        IF RISING_EDGE(CLK_BUF) THEN
            SCLK_BUF <= NOT SCLK_BUF;
        END IF;
    END PROCESS;        
    
    WR_PROCESS : PROCESS (SCLK_BUF, RESET)
    BEGIN
        IF RESET = '1' THEN
            BIT_NUM <= 31;
            
        ELSIF RISING_EDGE(SCLK_BUF) THEN
            
            DATA_OUT <= DATA_IN(BIT_NUM);
            BIT_NUM <= BIT_NUM -1;
        END IF;
     END PROCESS;      

end Behavioral;
