----------------------------------------------------------------------------------
--! @file topMetalSequencerLeader.vhd
--! @brief Analog scan control and SRAM config for Topmetal-II-
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Yuan Mei
-- 
-- Create Date:    23:56:58 1/19/2015
-- Design Name:    Topmetal II- analog scan driver
-- Module Name:    topmetal_iiminus_analog - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: Updated for UW topmetal setup by ADP Sept/01/2020
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
LIBRARY UNISIM;
USE UNISIM.VComponents.ALL;


ENTITY topMetalSequencerLeader IS
  GENERIC (
    ROWS          : positive := 72;     -- number of ROWS in the array
    COLS          : positive := 72;     -- number of COLS in the ARRAY
    CLK_DIV_WIDTH : positive := 16;
    CONFIG_WIDTH  : positive := 14
  );
  PORT (
    CLK               : IN  std_logic;      -- clock, TM_CLK_S is derived from this one
    RESET             : IN  std_logic;      -- reset
    EXTERN_CLK        : IN  std_logic;
    USE_EXTERN_CLK    : IN  std_logic;--pin to set to configur emode
    USB_SERIAL        : IN std_logic; 
    trigger_adc       : IN unsigned(7 DOWNTO 0);
    trigger_thresh_switch : IN std_logic_vector(7 DOWNTO 0);
    --MASK_RESET        : IN std_logic; --sets all mask values ot 0
    led           : OUT std_logic_vector(15 downto 0);
    -- output
    TRIGGER_OUT   : OUT std_logic;
    --
--    TM_RST        : OUT std_logic;      -- digital reset
    TM_CLK_S      : OUT std_logic;
    TM_RST_S      : OUT std_logic;
    TM_START_S    : OUT std_logic;
    TM_SPEAK_S    : OUT std_logic;
    GND           : OUT std_logic
 );
END topMetalSequencerLeader;

ARCHITECTURE Behavioral OF topMetalSequencerLeader IS

    COMPONENT ila_0 IS
    PORT (
    clk : IN STD_LOGIC;


    probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe2 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe3 : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    probe4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    probe5 : IN STD_LOGIC_VECTOR(12 downto 0)


    );
    END COMPONENT;
    
    COMPONENT buffer_adc_mem IS
    PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(13 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;
    
    COMPONENT uart_rx IS
    PORT (
        i_CLK       : in std_logic; --in clock
	    i_RX_Serial : in std_logic; --serial data in
	    o_RX_valid     : out std_logic; -- data byte valid
	    o_RX_Byte   : out std_logic_vector(7 downto 0) --value out 
    );
    END COMPONENT;
    
    COMPONENT mask_mem IS
    PORT (
        clka : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(12 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
    );
    END COMPONENT;
    
    -- configuration
  SIGNAL BASE_CLK      :  std_logic;
  SIGNAL CLK_DIV       :  std_logic_vector(3 DOWNTO 0);  -- log2(CLK_DIV_WIDTH), CLK/(2**CLK_DIV)
  SIGNAL clk_vector    :  std_logic_vector(0 DOWNTO 0);
  SIGNAL trig_vector   :  std_logic_vector(0 DOWNTO 0);
  
  SIGNAL STOP_ADDR     :  std_logic_vector(CONFIG_WIDTH-1 DOWNTO 0);  --MSB enables
  SIGNAL TRIGGER_RATE  :  std_logic_vector(CONFIG_WIDTH-1 DOWNTO 0);  --trigger every () frames
  SIGNAL TRIGGER_DELAY :  std_logic_vector(CONFIG_WIDTH-1 DOWNTO 0);
  SIGNAL clk_cnt         : unsigned(CLK_DIV_WIDTH-1 DOWNTO 0);
  SIGNAL TM_CLK_buf      : std_logic;
  SIGNAL TM_RST_S_buf    : std_logic;
  SIGNAL TM_START_S_buf  : std_logic;
  SIGNAL TM_SPEAK_S_buf  : std_logic;
  SIGNAL TM_RST          : std_logic;
  
  SIGNAL mask_write_flag : std_logic := '0'; 
  --
  SIGNAL pxladdr         : unsigned(CONFIG_WIDTH-1 DOWNTO 0);
  SIGNAL pxladdr_next    : unsigned(CONFIG_WIDTH-1 downto 0);
--  SIGNAL pxladdr         : integer;
--  SIGNAL pxladdr_vec     : std_logic_vector(13 downto 0);
  SIGNAL trigger_cnt     : unsigned(TRIGGER_RATE'length-1 DOWNTO 0);
  SIGNAL trigger_buf     : std_logic;
  --
  TYPE driveState_t IS (S0, S1, S2, S3, S4, S5, S6, S7);
  SIGNAL driveState      : driveState_t;
  SIGNAL driveState1     : driveState_t;
  SIGNAL npix            : integer := ROWS*COLS;
  
--  digital triggering
--  SIGNAL trigger_adc     : unsigned(7 DOWNTO 0); 
  --TYPE frame IS ARRAY (0 to ROWS*COLS) of unsigned(5 DOWNTO 0);
  
  --SIGNAL frame_buffer : frame;
  SIGNAL prev_pixel : unsigned(7 downto 0);
  SIGNAL trigger_threshold : signed(8 DOWNTO 0) := (others => '0');
  SIGNAL trigger_adc_buf_in  : unsigned(8 DOWNTO 0) := (others => '0');
  SIGNAL trigger_adc_buf_out : std_logic_vector(7 downto 0) := (others=> '0');
  SIGNAL trigger_adc_zeros   : std_logic_vector(7 downto 0) := (others=> '0');
  SIGNAL prev_frame_adc      : unsigned(8 DOWNTO 0) := (others => '0');

  SIGNAL diff         : signed(8 DOWNTO 0);
  
  SIGNAL serial_valid : std_logic;
  SIGNAL serial_out   : std_logic_vector(7 downto 0);
  SIGNAL byte_addr    : std_logic := '0';
  
  
  SIGNAL sVal_in      : std_logic_vector(15 downto 0);
  SIGNAL sVal_valid   : std_logic :='0';
  
  SIGNAL mask_addr    : unsigned(12 DOWNTO 0) :=(others =>'0');
 
  SIGNAL MASK_WRITE    : std_logic := '0';
  SIGNAL MASK_IN       : std_logic :='0';
  SIGNAL MASK_OUT      : std_logic :='0';
  SIGNAL MASK_CNT      : unsigned(12 downto 0) := (others =>'0');
  
  SIGNAL INTERNAL_RESET : std_logic :='0';
  SIGNAL CONFIGURE      : std_logic :='0';
  
  SIGNAL CON_THRES      : std_logic := '0';
  SIGNAL CONFIGURE_STOP : std_logic := '0';
  --SIGNAL RESET_OFF      : std_logic :='0';
BEGIN 

   
  CLK_DIV <= "0000";
  GND <= '0';
--  trigger_threshold <= "000000111";
  clk_vector(0) <= EXTERN_CLK;
  trig_vector(0) <= trigger_buf;
--  pxladdr_vec <= std_logic_vector(to_unsigned(pxladdr, pxladdr_vec'length));
  ila_tx : ila_0
  port map(
    clk => CLK,
    probe0 => clk_vector,
    probe1 => std_logic_vector(trigger_adc_buf_in(7 downto 0)),
    probe2 => std_logic_vector(trig_vector),
    probe3 => std_logic_vector(trigger_threshold),
    probe4 => std_logic_vector(prev_frame_adc(7 downto 0)),
    probe5 => std_logic_vector(pxladdr(12 downto 0))
  
  );
  
 ila_mask: ila_1
  port map(
   clk => CLK,
    probe0=> std_logic_vector(mask_addr),
    probe1=> std_logic_vector(pxladdr(12 downto 0)),
    probe2 =>std_logic_vector(trig_vector)
  );
  
   buffer_adc_men_inst : buffer_adc_mem
   port map(
    clka => EXTERN_CLK,
    wea => "1",
    addra => std_logic_vector(pxladdr),
    dina => std_logic_vector(trigger_adc_buf_in(7 downto 0)),
    douta => trigger_adc_zeros,
    clkb => EXTERN_CLK,
    web => "0",
    addrb => std_logic_vector(pxladdr_next),
    dinb => trigger_adc_zeros,
    doutb => trigger_adc_buf_out
   );
   
    rx_inst : uart_rx
    port map(
        i_CLK       =>CLK,
	    i_RX_Serial => USB_SERIAL, --serial data in
	    o_RX_valid     => serial_valid, -- data byte valid
	    o_RX_Byte   => serial_out --value out
    );
    
    mask_mem_inst: mask_mem
    port map(
        clka => EXTERN_CLK,
        wea(0) => MASK_WRITE,
        addra => std_logic_vector(mask_addr(12 downto 0)),
        dina(0) => MASK_IN,
        douta(0) => MASK_OUT
    );
    
      clk_proc: PROCESS (BASE_CLK, RESET)
  BEGIN
    IF USE_EXTERN_CLK = '1' THEN
        BASE_CLK <= EXTERN_CLK;
    ELSE
        BASE_CLK <= CLK;
    END IF; 
    
--    IF RESET = '1' THEN
--      clk_cnt <= to_unsigned(0, clk_cnt'length);
--    ELSIF rising_edge(BASE_CLK) THEN
--      clk_cnt <= clk_cnt + 1;
--    END IF;
  END PROCESS clk_proc;
  TM_CLK_buf <= EXTERN_CLK;
--  TM_CLK_buf <= BASE_CLK WHEN to_integer(unsigned(CLK_DIV)) = 0 ELSE
--                clk_cnt(to_integer(unsigned(CLK_DIV))-1);

  tm_proc : PROCESS (TM_CLK_buf, RESET, INTERNAL_RESET, CONFIGURE)
    VARIABLE stopped : std_logic;
  BEGIN
  IF CONFIGURE = '0' THEN
  
    IF RESET = '1' or INTERNAL_RESET = '1' THEN 
      TM_RST_S_buf   <= '0';
      TM_START_S_buf <= '0';
      TM_SPEAK_S_buf <= '0';
      trigger_buf    <= '0';
--      pxladdr        <= (OTHERS => '0');
      pxladdr        <= (OTHERS => '0');
      pxladdr_next   <= to_unsigned(1, CONFIG_WIDTH);
      trigger_cnt    <= (OTHERS => '0');
      stopped        := '0';
      driveState     <= S0;
--      first_frame    <= '0'
                  
--      Initialized trigger arrays
--      frame_buffer <= (others => (others => '0'));
    ELSIF falling_edge(TM_CLK_buf) THEN
      TM_RST_S_buf   <= '0';
      TM_START_S_buf <= '0';
      TM_SPEAK_S_buf <= '0';
      trigger_buf    <= '0';      
      CASE driveState IS
        WHEN S0 =>                      -- wait a clk cycle
          driveState <= S1;
        WHEN S1 =>
          TM_RST_S_buf <= '1';
          driveState   <= S2;
        WHEN S2 =>                      -- wait a clk cycle then start
          driveState <= S3;
        WHEN S3 =>
          TM_START_S_buf <= '1';
          pxladdr        <= (OTHERS => '1');
          pxladdr_next   <= to_unsigned(1, CONFIG_WIDTH);
          driveState     <= S4;
        WHEN S4 =>
          IF STOP_ADDR(STOP_ADDR'length-1) = '0' THEN 
            TM_SPEAK_S_buf <= '1';
          ELSIF stopped = '1' THEN
            TM_SPEAK_S_buf <= '0';
          ELSE
          
            IF pxladdr = unsigned(STOP_ADDR(pxladdr'length -2 DOWNTO 0)) THEN
            
                TM_SPEAK_S_buf <= '0';
                stopped := '1';
            ELSE
                TM_SPEAK_S_buf <= '1';
            END IF;   
          END IF;
        
          IF pxladdr >= npix-1 THEN
            pxladdr <= (OTHERS => '0');
          ELSE
            pxladdr <= pxladdr + 1;
          END IF;
          
          IF pxladdr_next >= npix-1 THEN

            pxladdr_next <= (OTHERS => '0');

          ELSE
            pxladdr_next <= pxladdr_next + 1;
          END IF;
          
          --trigger_threshold(7 downto 0) <= signed(trigger_thresh_switch);
          trigger_adc_buf_in(7 downto 0) <= trigger_adc;
          prev_frame_adc(7 downto 0) <= unsigned(trigger_adc_buf_out);


          --polarity flipped:
         -- diff <= signed(trigger_adc_buf_in - prev_frame_adc);
          
          --default version:
          diff <= signed(prev_frame_adc-trigger_adc_buf_in);
          IF diff > trigger_threshold THEN
            IF MASK_OUT = '0' THEN
                trigger_buf <= '1';
            END IF;
--          ELSE
--            trigger_buf <= '0';
          END IF;
          
--          frame_buffer(pxladdr) <= trigger_adc_buf(5 downto 0);


          
          driveState <= S4;
        WHEN OTHERS =>
          driveState <= S0;
      END CASE;
    END IF;
    END IF;
  END PROCESS;
  
  configure_read : process(serial_valid, CONFIGURE, INTERNAL_RESET, RESET) --occurs on serial_valid changing
  BEGIN
    IF RESET = '1' or INTERNAL_RESET = '1' THEN
      sVal_valid <= '0';
      byte_addr <= '0';
        
    ELSIF RISING_EDGE(serial_valid) THEN
            If CONFIGURE = '0' AND CONFIGURE_STOP ='0' THEN
                If serial_out = "11101101" THEN
                    CONFIGURE <= '1';
                ELSIF serial_out = "11111101" THEN
                    CONFIGURE_STOP <= '1';
                 
                END IF;
            
            ELSIF CONFIGURE =  '1' THEN
                IF byte_addr = '0' THEN
                    led(7 downto 0) <= serial_out;
                    sVal_in(7 downto 0) <= serial_out;
                    sVal_valid <='0';
                    byte_addr <= '1';
                ELSIF byte_addr = '1' THEN
                    led(15 downto 8) <= serial_out;
                    sVal_in(15 downto 8) <= serial_out;
                    IF serial_out(7 downto 6) = "11" THEN
                        CONFIGURE <= '0';
                        CON_THRES <= '0';
                    ELSIF serial_out(7 downto 6) = "10" THEN
                        CONFIGURE <= '0';
                        CON_THRES <= '1';
                    ELSE
                        sVal_valid <= '1';
                    END IF;
                    byte_addr <= '0';
                END IF;
            ELSIF CONFIGURE_STOP = '1' THEN
                IF byte_addr = '0' THEN
                    led(7 downto 0) <= serial_out;
                    STOP_ADDR(7 downto 0) <= serial_out;
                    byte_addr<='1';
                ELSIF byte_addr = '1' THEN
                    byte_addr <='0';
                    led(15 downto 8) <= serial_out;
                    STOP_ADDR(13 downto 8) <= serial_out(5 downto 0);
                    CONFIGURE_STOP <= '0';
                END IF;
                
        END IF;
    END IF;
  END PROCESS;
  write_to : process(TM_CLK_buf,CONFIGURE, INTERNAL_RESET, RESET)
  BEGIN
    IF INTERNAL_RESET ='1' or RESET = '1' THEN
        mask_addr <= (OTHERS =>'0');
         
    ELSIF falling_edge(TM_CLK_buf) THEN
        IF CONFIGURE ='0' THEN --read from mask
            MASK_WRITE <= '0';
            IF mask_addr >= npix-1 THEN
                mask_addr <= (OTHERS => '0');
            ELSE
                mask_addr<= pxladdr_next(12 downto 0)+1;
          END IF;
       
        ELSIF CONFIGURE ='1' THEN
            IF sVAl_valid = '1'THEN
            MASK_WRITE <= '1';
            mask_addr <= unsigned(sVal_in(12 downto 0));
            MASK_IN <= sVal_in(13);
            END IF;
        END IF;
    END IF;
  END PROCESS;
  mask_count : process(sVal_valid, INTERNAL_RESET, RESET)
  BEGIN
    IF INTERNAL_RESET = '1' or RESET='1' THEN
        mask_cnt<= (others => '0');
    ELSIF RISING_EDGE(sVal_valid) THEN
        if sVal_in(13) = '1' THEN
            mask_cnt <= mask_cnt+1;
        END IF;
    END IF;
  END PROCESS;
  post_config_reset: process(CONFIGURE, TM_CLK_buf)
  BEGIN
    IF INTERNAL_RESET = '1' THEN
        INTERNAL_RESET<='0';
    ELSIF falling_edge(CONFIGURE) THEN
        --led(12 downto 0) <= std_logic_vector(MASK_CNT(12 downto 0));
        INTERNAL_RESET <='1';
    END IF;
  END PROCESS;
  
  configure_threshold: process(CON_THRES)
  BEGIN
    IF CON_THRES = '1' THEN
        trigger_threshold <= signed(sVal_in(8 downto 0));
    END IF;
  END PROCESS;
  
    -- output
  TM_RST      <= RESET;
  TM_CLK_S    <= TM_CLK_buf;
  TM_RST_S    <= TM_RST_S_buf;
  TM_START_S  <= TM_START_S_buf;
  TM_SPEAK_S  <= TM_SPEAK_S_buf;
  TRIGGER_OUT <= trigger_buf;


END Behavioral;
