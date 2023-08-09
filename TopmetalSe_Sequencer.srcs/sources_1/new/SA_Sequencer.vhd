----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/08/2023 04:42:26 PM
-- Design Name: 
-- Module Name: SA_Sequencer - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SA_Sequencer is
  Port (
  INTERN_CLK : IN std_logic;
  RESET      : IN std_logic;
  USE_SWITCH : IN std_logic;
  SA_PXL_ADDR: IN std_logic_vector(3 downto 0);
  
  ROW_SWITCH : IN std_logic_vector(2 downto 0);
  COL_SWITCH : IN std_logic_vector(2 downto 0);
  
  SA_ROW_OUT : OUT std_logic_vector(2 downto 0);
  SA_COL_OUT : OUT std_logic_vector(2 downto 0)
  
  
  
   );
end SA_Sequencer;

architecture Behavioral of SA_Sequencer is

begin

SA_PIXL_SELECT: process(INTERN_CLK, USE_SWITCH)
    BEGIN --delay for small array
        IF FALLING_EDGE(INTERN_CLK) then
            IF (USE_SWITCH = '1') THEN
                --use hardware switches
                SA_ROW_OUT <= ROW_SWITCH;
                SA_COL_OUT <= COL_SWITCH;

            ELSIF (USE_SWITCH = '0') THEN
                --lazy solution for now
                IF SA_PXL_ADDR = "1000" THEN --pixel 8
                    SA_ROW_OUT <= "100";
                    SA_COL_OUT <= "100";
                ELSIF SA_PXL_ADDR = "0111" THEN --pixel 7
                    SA_ROW_OUT <= "100";
                    SA_COL_OUT <= "010";
                ELSIF SA_PXL_ADDR = "0110" THEN --pixel 6
                    SA_ROW_OUT<= "100";
                    SA_COL_OUT<= "001";
                    
                ELSIF SA_PXL_ADDR = "0101" THEN --pixel 5
                    SA_ROW_OUT <= "010";
                    SA_COL_OUT <= "100";
                ELSIF SA_PXL_ADDR = "0100" THEN --pixel 4
                    SA_ROW_OUT<= "010";
                    SA_COL_OUT<= "010";
                ELSIF SA_PXL_ADDR = "0011" THEN --pixel 3
                    SA_ROW_OUT<= "010";
                    SA_COL_OUT<= "001";
                
                ELSIF SA_PXL_ADDR = "0010" THEN --pixel 2
                    SA_ROW_OUT <= "001";
                    SA_COL_OUT <= "100";
                ELSIF SA_PXL_ADDR = "0100" THEN --pixel 1
                    SA_ROW_OUT<= "001";
                    SA_COL_OUT<= "010";
                ELSIF SA_PXL_ADDR = "0011" THEN --pixel 0
                    SA_ROW_OUT<= "001";
                    SA_COL_OUT<= "001";  
      
                END IF;
            
            END IF;
        END IF;
    END PROCESS;
    
end Behavioral;
