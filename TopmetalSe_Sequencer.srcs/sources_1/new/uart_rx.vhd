--UART Receiver for BASYS 3 FPGA
--waits for data stream to go loww
-- over samples and waits for middle of bit then starts reading at middle at baud rate
--we have a master clock of 100 MHz
-- baud rate of UART is 9600
-- g_CLKS_PER_BIT = 100000000/9600 = 10417, used for counting to middle of bit 

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity uart_rx is
	generic(g_CLKS_PER_BIT : integer :=10417); --counter
	port(
		i_CLK       : in std_logic; --in clock
	    i_RX_Serial : in std_logic; --serial data in
	    o_RX_valid     : out std_logic; -- data byte valid
	    o_RX_Byte   : out std_logic_vector(7 downto 0) --value out 
		);
end UART_RX;

architecture recieve of uart_rx is

	TYPE rxState_t IS (s_idle, s_start, s_data, s_stop, s_reset);
	signal rxState : rxState_t := s_idle;
	
	signal clk_count : integer range 0 to g_CLKS_PER_BIT-1 :=0;
	signal bit_index : integer range 0 to 15 := 0;
	signal rx_byte : std_logic_vector(7 downto 0) := (others => '0');
	signal rx_valid : std_logic := '0';

BEGIN

	receiver : process (i_CLK)
	begin
		if rising_edge(i_CLK) then
			case rxState is
				when s_idle =>
					rx_valid <=  '0'; -- sets values to 0
					clk_count <=  0;
					bit_index <=  0;
					
					if i_RX_Serial = '0' then -- checks if data stream has fallen and moves onto start bit if low
						rxState <= s_start; 
					else
						rxState <= s_idle;
					end if;
				when s_start =>
					-- on falling bit, wait half a clock cycle 
					if clk_count = (g_CLKS_PER_BIT-1)/2 then
						if i_RX_Serial = '0' then --confirm start bit
							clk_count <= 0;
							rxState <= s_data; -- start reading data
						else
							rxState <= s_idle;
						end if;
					else
						clk_count <= clk_count + 1;
						rxState<= s_start;
					end if;
				when s_data =>
					if clk_count = (g_CLKS_PER_BIT-1) then 
						rx_byte(bit_index) <= i_RX_Serial;
						clk_count <= 0;
						if bit_index < 7 then --receive all bits 
							bit_index <= bit_index + 1;
							rxState <= s_data;
						else
							bit_index <= 0;
							rxState <= s_stop;
						end if;
					else
						clk_count <= clk_count + 1;
						rxState <= s_data;
					end if;
				when s_stop =>
					--stop bit, sends data valid signal
					if clk_count = (g_CLKS_PER_BIT-1) then 
						rx_valid <= '1';
						clk_count <= 0;
						rxState <= s_reset ;
					else
						clk_count <= clk_count + 1;
						rxState <= s_stop;
					end if;
				when s_reset=> 
						rx_valid <= '0';
						clk_count <= 0;
						rxState <= s_idle ;
				end case;
			end if;
	end process receiver;
	o_RX_valid   <= rx_valid;
	o_RX_Byte <= rx_byte;
	
END recieve;







