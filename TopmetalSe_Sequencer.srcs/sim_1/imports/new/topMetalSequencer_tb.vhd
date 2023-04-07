----------------------------------------------------------------------------------
-- Company: UW
-- Engineer: Alex Piers (based off of work from Yuan Mei at LBNL)
-- 
-- Create Date: 03/15/2021 11:47:40 AM
-- Design Name: 
-- Module Name: topMetalSequencer_tb - Behavioral
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
 
entity topMetalSequencer_tb is
--  Port ( );
end topMetalSequencer_tb;
 
ARCHITECTURE behavior OF topMetalSequencer_tb IS

  -- Component Declaration for the Unit Under Test (UUT)
  
--  COMPONENT topMetalSequencerLeader
--GENERIC (
--    ROWS          : positive := 72;     -- number of ROWS in the array
--    COLS          : positive := 72;     -- number of COLS in the ARRAY
--    CLK_DIV_WIDTH : positive := 16;
--    CONFIG_WIDTH  : positive := 14
--  );
--  PORT (
--    CLK               : IN  std_logic;      -- clock, TM_CLK_S is derived from this one
--    RESET             : IN  std_logic;      -- reset
--    EXTERN_CLK        : IN  std_logic;
--    USE_EXTERN_CLK    : IN  std_logic;
--    --CONFIGURE         : IN std_logic; 
--    USB_SERIAL        : IN std_logic;
--    trigger_adc       : IN unsigned(7 DOWNTO 0);
--    trigger_thresh_switch : IN std_logic_vector(7 DOWNTO 0);

--    led           : OUT std_logic_vector(15 downto 0);
--    -- output
--    TRIGGER_OUT   : OUT std_logic;
--    --
----    TM_RST        : OUT std_logic;      -- digital reset
--    TM_CLK_S      : OUT std_logic;
--    TM_RST_S      : OUT std_logic;
--    TM_START_S    : OUT std_logic;
--    TM_SPEAK_S    : OUT std_logic;
--    GND           : OUT std_logic
-- );
--  END COMPONENT;

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
        

  --Inputs
  SIGNAL CLK           : std_logic                     := '0';
  SIGNAL RESET         : std_logic                     := '0';

  SIGNAL led         : std_logic_vector(15 DOWNTO 0);

  -- Clock period definitions
  CONSTANT CLK_period     : time := 10 ns;
  
  SIGNAL ROW_SR_EN    : std_logic   := '0';
  SIGNAL COL_SR_EN   : std_logic    := '0'; 
  
  SIGNAL ROW_SR_EN_BUF    : std_logic;
  SIGNAL COL_SR_EN_BUF   : std_logic; 
  
  SIGNAL ROW_IN     : std_logic;
  SIGNAL COL_IN     : std_logic;
  
  SIGNAL ROW_SEL    : std_logic_vector (99 downto 0);
  SIGNAL COL_SEL    : std_logic_vector (99 downto 0);
  
  SIGNAL DATA_OUT_ROW   : std_logic;
  SIGNAL DATA_OUT_COL   : std_logic;
  
  SIGNAL ROW_DAT        : std_logic;
  SIGNAL COL_DAT        : std_logic;


  SIGNAL DATA_IN        : std_logic_vector(31 downto 0) := (31 downto 10 => '1', others => '0');
  SIGNAL DATA_VAL       : std_logic;
  SIGNAL SPI_OUT       : std_logic;
  SIGNAL SYNC       : std_logic;
  SIGNAL SCLK           : std_logic;

BEGIN

  CLK_process : PROCESS
  BEGIN
    CLK <= '0';
    WAIT FOR CLK_period/2;
    CLK <= '1';
    WAIT FOR CLK_period/2;
  END PROCESS;

  -- Instantiate the Device Under Test (DUT)
  
  DUT: DAC_SPI PORT MAP(
    CLK_IN      => CLK,
    RESET       => RESET,
    DATA_IN     => DATA_IN,
    DATA_VAL    => DATA_VAL,
    
    DATA_OUT     => SPI_OUT,
    SYNC_OUT      => SYNC,
    SCLK         => SCLK 
 
  );
  
  
  CLK_SEQ: clock_sequencer PORT MAP (
    CLK           => CLK,
    RESET         => RESET,
    
    LA_ROW_SHIFT  => ROW_SR_EN_BUF,
    LA_COL_SHIFT  => COL_SR_EN_BUF,
    ROW_DAT_IN    => ROW_DAT,
    COL_DAT_IN    => COL_DAT
  );


    -- Insantiate Row and Column Shift Registers
   SR_ROW: shift_register PORT MAP(
        CLK     => CLK,
        ENA     => ROW_SR_EN_BUF,
        RST   =>RESET,
        DATA_IN => ROW_DAT,
        
        DATA_OUT => DATA_OUT_ROW,
        COL_SEL  => ROW_SEL
 
    );
    SR_COL: shift_register PORT MAP(
        CLK     => CLK,
        ENA     => COL_SR_EN_BUF,
        RST   =>RESET,
        DATA_IN => COL_DAT,
        
        DATA_OUT => DATA_OUT_COL,
        COL_SEL  => COL_SEL
    );


--ROW_SR_EN_BUF <= ROW_SR_EN;
--COL_SR_EN_BUF <= COL_SR_EN;
    
--  CLK <= '0';
--  WAIT FOR CLK_period;
--  CLK <= '1';
--  WAIT FOR CLK_period;
--  CLK <= '0';
--  WAIT FOR CLK_period;
--  CLK <= '1';
--  WAIT FOR CLK_period;
--  CLK <= '0';
--  WAIT FOR CLK_period;
--  CLK <= '1';
--  WAIT FOR CLK_period;
  -- Clock process definitions


 --Stimulus process
 stim_proc : PROCESS
 BEGIN
    -- hold reset state for 100 ns.
    WAIT FOR CLK_PERIOD;
    RESET <= '1';
    WAIT FOR CLK_PERIOD;
    RESET <= '0';
    WAIT FOR CLK_PERIOD;
    ROW_IN <= '1';
    COL_IN <= '1';
    ROW_SR_EN<='1';
    COL_SR_EN<='1';
    WAIT FOR CLK_PERIOD;
    ROW_IN <= '0';
    COL_IN <= '0';
    ROW_SR_EN<='0';
    WAIT FOR 3*CLK_PERIOD;
    COL_SR_EN <='0';
    
    DATA_VAL<= '1';
    WAIT FOR CLK_PERIOD;
    DATA_VAL <='0';
    
    WAIT FOR 10000*CLK_PERIOD;
    

    
END PROCESS;
  
--external_data : process

--variable read_from_input_buf : line;
--variable data : std_logic_vector(7 DOWNTO 0);
--variable write_col_to_output_buf : line;
--variable tout : std_logic;

--begin

--file_open(input_buf, "/home/selena/Documents/UWTopMetalSequencer/sim_data/sim_simple.txt", read_mode);
--file_open(output_buf, "/home/selena/Documents/UWTopMetalSequencer/sim_data/trigger_out.txt", write_mode);

--wait for 20ms;
--WAIT FOR CLK_period/2;
--RESET <= '1';
--WAIT FOR CLK_period/2;
--RESET <= '0';
--wait for 3.5*CLK_period;

--write(write_col_to_output_buf, string'("#trigger value"));
--writeline(output_buf, write_col_to_output_buf);

--while not endfile(input_buf) loop
--readline(input_buf, read_from_input_buf);
--read(read_from_input_buf, data);

--trigger_adc(7 downto 0) <= unsigned(data);

----        tout := TRIGGER_OUT;




--wait for CLK_period;
----        write(write_col_to_output_buf, data);
----        write(write_col_to_output_buf, string'("  "));
--write(write_col_to_output_buf, TRIGGER_OUT);
--writeline(output_buf, write_col_to_output_buf);  

--end loop;

--file_close(input_buf);
--file_close(output_buf);

--wait;
--end process;
--CLK <= not CLK after c_CLK_PERIOD/2;

--serial_test: process
--begin
---- Send a command to the UART

--wait for 10 ns;
--UART_WRITE_BYTE("11101101", USB_SERIAL);

--UART_WRITE_BYTE("00000001", USB_Serial);
--wait for 2 ms;
--UART_WRITE_BYTE("00100000", USB_SERIAL);
--wait for 2ms;

--UART_WRITE_BYTE("00000010", USB_SERIAL);
--wait for 2ms;
--UART_WRITE_BYTE("00100000", USB_SERIAL);

----wait until rising_edge(CLK);
--wait for 2 ms;
--UART_WRITE_BYTE("00000010", USB_SERIAL);

--UART_WRITE_BYTE("10100110", USB_SERIAL);

--wait for 1ms;
--UART_WRITE_BYTE("11111101", USB_SERIAL);
--UART_WRITE_BYTE("00000000", USB_SERIAL);
--UART_WRITE_BYTE("11110000", USB_SERIAL);

--wait;
--END PROCESS;
END;
