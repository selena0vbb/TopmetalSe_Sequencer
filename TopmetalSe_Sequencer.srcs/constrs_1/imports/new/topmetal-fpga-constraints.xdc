# This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal
set_property PACKAGE_PIN W5 [get_ports INTERN_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports INTERN_CLK]
create_clock -period 10.000 -name sys_clk_pin -add [get_ports INTERN_CLK]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets RESET_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets EXTERN_CLK_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets EXTERN_CLK_IBUF_BUFG]


# Switches
set_property PACKAGE_PIN V17 [get_ports RESET]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]
set_property PACKAGE_PIN V16 [get_ports CONFIGURE_LED]
set_property IOSTANDARD LVCMOS33 [get_ports CONFIGURE_LED]
#set_property PACKAGE_PIN W16 [get_ports {sw[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
#set_property PACKAGE_PIN W17 [get_ports {sw[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
#set_property PACKAGE_PIN W15 [get_ports {sw[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
#set_property PACKAGE_PIN V15 [get_ports {sw[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
#set_property PACKAGE_PIN W14 [get_ports {6sw[6]}]
#	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
#set_property PACKAGE_PIN W13 [get_ports {trigger_thresh_switch[7]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {trigger_thresh_switch[7]}]
#set_property PACKAGE_PIN V2 [get_ports {trigger_thresh_switch[6]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {trigger_thresh_switch[6]}]
#set_property PACKAGE_PIN T3 [get_ports {trigger_thresh_switch[5]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {trigger_thresh_s

# control the small array through switches on the board
set_property PACKAGE_PIN T2 [get_ports {SA_COL_SWITCH[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SA_COL_SWITCH[2]}]
set_property PACKAGE_PIN R3 [get_ports {SA_COL_SWITCH[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SA_COL_SWITCH[1]}]
set_property PACKAGE_PIN W2 [get_ports {SA_COL_SWITCH[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SA_COL_SWITCH[0]}]
set_property PACKAGE_PIN U1 [get_ports {SA_ROW_SWITCH[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SA_ROW_SWITCH[2]}]
set_property PACKAGE_PIN T1 [get_ports {SA_ROW_SWITCH[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SA_ROW_SWITCH[1]}]
set_property PACKAGE_PIN R2 [get_ports {SA_ROW_SWITCH[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SA_ROW_SWITCH[0]}]


## leds
set_property PACKAGE_PIN U16 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]


#7 segment display
#set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
#set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
#set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
#set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
#set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
#set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
#set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

#set_property PACKAGE_PIN V7 [get_ports dp]
#	set_property IOSTANDARD LVCMOS33 [get_ports dp]

#set_property PACKAGE_PIN U2 [get_ports {an[0]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
#set_property PACKAGE_PIN U4 [get_ports {an[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
#set_property PACKAGE_PIN V4 [get_ports {an[2]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
#set_property PACKAGE_PIN W4 [get_ports {an[3]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]


##Buttons
#set_property PACKAGE_PIN U18 [get_ports btnC]
#set_property IOSTANDARD LVCMOS33 [get_ports btnC]
#set_property PACKAGE_PIN T18 [get_ports btnU]
#set_property IOSTANDARD LVCMOS33 [get_ports btnU]
#set_property PACKAGE_PIN W19 [get_ports btnL]
#set_property IOSTANDARD LVCMOS33 [get_ports btnL]
#set_property PACKAGE_PIN T17 [get_ports btnR]
#set_property IOSTANDARD LVCMOS33 [get_ports btnR]
#set_property PACKAGE_PIN U17 [get_ports btnD]
#set_property IOSTANDARD LVCMOS33 [get_ports btnD]



##Pmod Header JA
#Sch name = JA1
#set_property PACKAGE_PIN J1 [get_ports SA_ROW_SEL[0]]
#set_property IOSTANDARD LVCMOS33 [get_ports SA_ROW_SEL[0]]
#Sch name = JA2
#set_property PACKAGE_PIN L2 [get_ports SPI_OUT]
#set_property IOSTANDARD LVCMOS33 [get_ports SPI_OUT]
#Sch name = JA3
#set_property PACKAGE_PIN H1 [get_ports SPI_SCLK]
#set_property IOSTANDARD LVCMOS33 [get_ports SPI_SCLK]
#Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports EXTERN_CLK]
	set_property IOSTANDARD LVCMOS33 [get_ports EXTERN_CLK]
#Sch name = JA7
#set_property PACKAGE_PIN H1 [get_ports TM_RST_S]
#	set_property IOSTANDARD LVCMOS33 [get_ports TM_RST_S]
#Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports GND]
#	set_property IOSTANDARD LVCMOS33 [get_ports GND]
##Sch name = JA9
set_property PACKAGE_PIN H2 [get_ports TRIG_OUT]
	set_property IOSTANDARD LVCMOS33 [get_ports TRIG_OUT]
##Sch name = JA10
set_property PACKAGE_PIN G3 [get_ports FRAME_START]
	set_property IOSTANDARD LVCMOS33 [get_ports FRAME_START]


##Pmod Header JC
#Sch name = JC1
# ADC trigger settings
set_property PACKAGE_PIN A14 [get_ports {SPI_SYNC}]
set_property IOSTANDARD LVCMOS33 [get_ports {SPI_SYNC}]
#Sch name = JC2
set_property PACKAGE_PIN B15 [get_ports {SPI_SCLK}]
set_property IOSTANDARD LVCMOS33 [get_ports {SPI_SCLK}]
#Sch name = JC3
set_property PACKAGE_PIN A16 [get_ports {SPI_OUT}]
set_property IOSTANDARD LVCMOS33 [get_ports {SPI_OUT}]
#Sch name = JC4
#set_property PACKAGE_PIN A17 [get_ports {SA_COL_OUT[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SA_COL_OUT[1]}]
#Sch name = JC7
#set_property PACKAGE_PIN B15 [get_ports {SA_ROW_OUT[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SA_ROW_OUT[2]}]

#set_property PACKAGE_PIN C15 [get_ports {SA_COL_OUT[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {SA_COL_OUT[2]}]

#set_property PACKAGE_PIN B16 [get_ports xclk]
#	set_property IOSTANDARD LVCMOS33 [get_ports xclk]


#Pmod Header JB
#Sch name = JB1ada
set_property PACKAGE_PIN K17 [get_ports LA_COL_RESET]
set_property IOSTANDARD LVCMOS33 [get_ports LA_ROW_RESET]
##Sch name = JB2
set_property PACKAGE_PIN L17 [get_ports LA_ROW_RESET]
set_property IOSTANDARD LVCMOS33 [get_ports LA_COL_RESET]
##Sch name = JB3
set_property PACKAGE_PIN M18 [get_ports LA_COL_DAT_IN]
set_property IOSTANDARD LVCMOS33 [get_ports LA_ROW_DAT_IN]
#Sch name = JB4
set_property PACKAGE_PIN M19 [get_ports LA_ROW_DAT_IN]
set_property IOSTANDARD LVCMOS33 [get_ports LA_COL_DAT_IN]
##Sch name = JB7
set_property PACKAGE_PIN N17 [get_ports LA_COL_SHIFT]
set_property IOSTANDARD LVCMOS33 [get_ports LA_ROW_SHIFT]
##Sch name = JB8
set_property PACKAGE_PIN P17 [get_ports LA_ROW_SHIFT]
set_property IOSTANDARD LVCMOS33 [get_ports LA_COL_SHIFT]
##Sch name = JB9
set_property PACKAGE_PIN P18 [get_ports LA_COL_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports LA_ROW_CLK]
##Sch name = JB10
set_property PACKAGE_PIN R18 [get_ports LA_ROW_CLK]
set_property IOSTANDARD LVCMOS33 [get_ports LA_COL_CLK]



#Sch name = JC8
#set_property PACKAGE_PIN M19 [get_ports CLK_OUT]
#	set_property IOSTANDARD LVCMOS33 [get_ports CLK_OUT]
#Sch name = JC9
#set_property PACKAGE_PIN P17 [get_ports {trigger_adc[3]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {trigger_adc[3]}]
#Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports {trigger_adc[1]}]
#	set_property IOSTANDARD LVCMOS33 [get_ports {trigger_adc[1]}]

# ADC trigger settings
#set_property PACKAGE_PIN K17 [get_ports {ADC_VAL[6]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[6]}]
##Sch name = JC2
#set_property PACKAGE_PIN M18 [get_ports {ADC_VAL[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[4]}]
##Sch name = JC3
#set_property PACKAGE_PIN N17 [get_ports {ADC_VAL[2]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[2]}]
##Sch name = JC4
#set_property PACKAGE_PIN P18 [get_ports {ADC_VAL[0]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[0]}]
##Sch name = JC7
#set_property PACKAGE_PIN L17 [get_ports {ADC_VAL[7]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[7]}]
##Sch name = JC8
#set_property PACKAGE_PIN M19 [get_ports {ADC_VAL[5]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[5]}]
##Sch name = JC9
#set_property PACKAGE_PIN P17 [get_ports {ADC_VAL[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[3]}]
##Sch name = JC10
#set_property PACKAGE_PIN R18 [get_ports {ADC_VAL[1]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[1]}]

#Pmod Header JXADC
#Sch name = XA1_P
set_property PACKAGE_PIN J3 [get_ports {ADC_VAL[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[6]}]
##Sch name = XA2_P
set_property PACKAGE_PIN L3 [get_ports {ADC_VAL[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[4]}]
##Sch name = XA3_P
set_property PACKAGE_PIN M2 [get_ports {ADC_VAL[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[2]}]
##Sch name = XA4_P
set_property PACKAGE_PIN N2 [get_ports ADC_VAL[0]]
set_property IOSTANDARD LVCMOS33 [get_ports ADC_VAL[0]]
##Sch name = XA1_N
set_property PACKAGE_PIN K3 [get_ports {ADC_VAL[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[7]}]
##Sch name = XA2_N
set_property PACKAGE_PIN M3 [get_ports {ADC_VAL[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[5]}]
##Sch name = XA3_N
set_property PACKAGE_PIN M1 [get_ports {ADC_VAL[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[3]}]
##Sch name = XA4_N
set_property PACKAGE_PIN N1 [get_ports {ADC_VAL[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {ADC_VAL[1]}]



##VGA Connector
#set_property PACKAGE_PIN G19 [get_ports {vgaRed[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[0]}]
#set_property PACKAGE_PIN H19 [get_ports {vgaRed[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[1]}]
#set_property PACKAGE_PIN J19 [get_ports {vgaRed[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[2]}]
#set_property PACKAGE_PIN N19 [get_ports {vgaRed[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaRed[3]}]
#set_property PACKAGE_PIN N18 [get_ports {vgaBlue[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[0]}]
#set_property PACKAGE_PIN L18 [get_ports {vgaBlue[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[1]}]
#set_property PACKAGE_PIN K18 [get_ports {vgaBlue[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[2]}]
#set_property PACKAGE_PIN J18 [get_ports {vgaBlue[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaBlue[3]}]
#set_property PACKAGE_PIN J17 [get_ports {vgaGreen[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[0]}]
#set_property PACKAGE_PIN H17 [get_ports {vgaGreen[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[1]}]
#set_property PACKAGE_PIN G17 [get_ports {vgaGreen[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[2]}]
#set_property PACKAGE_PIN D17 [get_ports {vgaGreen[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {vgaGreen[3]}]
#set_property PACKAGE_PIN P19 [get_ports Hsync]
#set_property IOSTANDARD LVCMOS33 [get_ports Hsync]
#set_property PACKAGE_PIN R19 [get_ports Vsync]
#set_property IOSTANDARD LVCMOS33 [get_ports Vsync]


##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports USB_SERIAL]
set_property IOSTANDARD LVCMOS33 [get_ports USB_SERIAL]
#set_property PACKAGE_PIN A18 [get_ports RsTx]
#set_property IOSTANDARD LVCMOS33 [get_ports RsTx


##USB HID (PS/2)
#set_property PACKAGE_PIN C17 [get_ports PS2Clk]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2Clk]
#set_property PULLUP true [get_ports PS2Clk]
#set_property PACKAGE_PIN B17 [get_ports PS2Data]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2Data]
#set_property PULLUP true [get_ports PS2Data]


##Quad SPI Flash
##Note that CCLK_0 cannot be placed in 7 series devices. You can access it using the
##STARTUPE2 primitive.
#set_property PACKAGE_PIN D18 [get_ports {QspiDB[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[0]}]
#set_property PACKAGE_PIN D19 [get_ports {QspiDB[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[1]}]
#set_property PACKAGE_PIN G18 [get_ports {QspiDB[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[2]}]
#set_property PACKAGE_PIN F18 [get_ports {QspiDB[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {QspiDB[3]}]
#set_property PACKAGE_PIN K19 [get_ports QspiCSn]
#set_property IOSTANDARD LVCMOS33 [get_ports QspiCSn]

set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[30]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[31]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[20]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[19]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[17]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[18]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[21]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[22]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[28]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[23]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[24]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[26]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[29]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[27]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[25]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[5]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[6]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[7]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[8]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[9]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[10]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[11]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[12]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[13]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[4]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[14]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[15]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr[16]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[19]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[15]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[14]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[16]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[29]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[17]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[30]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[31]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[18]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[25]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[27]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[24]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[20]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[26]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[21]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[23]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[28]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[22]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[6]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[4]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[5]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[7]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[12]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[13]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[8]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[9]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[10]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/pxl_addr_next[11]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/trigger_threshold[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/trigger_threshold[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/trigger_threshold[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/trigger_threshold[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[6]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[7]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[4]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/diff[5]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[4]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[5]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[6]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_val_prev_frame[7]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[4]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[5]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[6]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[7]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/adc_in_buf_2[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[0]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[1]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[2]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[3]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[4]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[5]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[6]}]
set_property MARK_DEBUG true [get_nets {CLK_SEQ/ADC_IN[7]}]
create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list EXTERN_CLK_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {CLK_SEQ/ADC_IN[0]} {CLK_SEQ/ADC_IN[1]} {CLK_SEQ/ADC_IN[2]} {CLK_SEQ/ADC_IN[3]} {CLK_SEQ/ADC_IN[4]} {CLK_SEQ/ADC_IN[5]} {CLK_SEQ/ADC_IN[6]} {CLK_SEQ/ADC_IN[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 4 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {CLK_SEQ/trigger_threshold[0]} {CLK_SEQ/trigger_threshold[1]} {CLK_SEQ/trigger_threshold[2]} {CLK_SEQ/trigger_threshold[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {CLK_SEQ/adc_in_buf_2[0]} {CLK_SEQ/adc_in_buf_2[1]} {CLK_SEQ/adc_in_buf_2[2]} {CLK_SEQ/adc_in_buf_2[3]} {CLK_SEQ/adc_in_buf_2[4]} {CLK_SEQ/adc_in_buf_2[5]} {CLK_SEQ/adc_in_buf_2[6]} {CLK_SEQ/adc_in_buf_2[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {CLK_SEQ/adc_val_prev_frame[0]} {CLK_SEQ/adc_val_prev_frame[1]} {CLK_SEQ/adc_val_prev_frame[2]} {CLK_SEQ/adc_val_prev_frame[3]} {CLK_SEQ/adc_val_prev_frame[4]} {CLK_SEQ/adc_val_prev_frame[5]} {CLK_SEQ/adc_val_prev_frame[6]} {CLK_SEQ/adc_val_prev_frame[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {CLK_SEQ/diff[0]} {CLK_SEQ/diff[1]} {CLK_SEQ/diff[2]} {CLK_SEQ/diff[3]} {CLK_SEQ/diff[4]} {CLK_SEQ/diff[5]} {CLK_SEQ/diff[6]} {CLK_SEQ/diff[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {CLK_SEQ/pxl_addr[0]} {CLK_SEQ/pxl_addr[1]} {CLK_SEQ/pxl_addr[2]} {CLK_SEQ/pxl_addr[3]} {CLK_SEQ/pxl_addr[4]} {CLK_SEQ/pxl_addr[5]} {CLK_SEQ/pxl_addr[6]} {CLK_SEQ/pxl_addr[7]} {CLK_SEQ/pxl_addr[8]} {CLK_SEQ/pxl_addr[9]} {CLK_SEQ/pxl_addr[10]} {CLK_SEQ/pxl_addr[11]} {CLK_SEQ/pxl_addr[12]} {CLK_SEQ/pxl_addr[13]} {CLK_SEQ/pxl_addr[14]} {CLK_SEQ/pxl_addr[15]} {CLK_SEQ/pxl_addr[16]} {CLK_SEQ/pxl_addr[17]} {CLK_SEQ/pxl_addr[18]} {CLK_SEQ/pxl_addr[19]} {CLK_SEQ/pxl_addr[20]} {CLK_SEQ/pxl_addr[21]} {CLK_SEQ/pxl_addr[22]} {CLK_SEQ/pxl_addr[23]} {CLK_SEQ/pxl_addr[24]} {CLK_SEQ/pxl_addr[25]} {CLK_SEQ/pxl_addr[26]} {CLK_SEQ/pxl_addr[27]} {CLK_SEQ/pxl_addr[28]} {CLK_SEQ/pxl_addr[29]} {CLK_SEQ/pxl_addr[30]} {CLK_SEQ/pxl_addr[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {CLK_SEQ/pxl_addr_next[0]} {CLK_SEQ/pxl_addr_next[1]} {CLK_SEQ/pxl_addr_next[2]} {CLK_SEQ/pxl_addr_next[3]} {CLK_SEQ/pxl_addr_next[4]} {CLK_SEQ/pxl_addr_next[5]} {CLK_SEQ/pxl_addr_next[6]} {CLK_SEQ/pxl_addr_next[7]} {CLK_SEQ/pxl_addr_next[8]} {CLK_SEQ/pxl_addr_next[9]} {CLK_SEQ/pxl_addr_next[10]} {CLK_SEQ/pxl_addr_next[11]} {CLK_SEQ/pxl_addr_next[12]} {CLK_SEQ/pxl_addr_next[13]} {CLK_SEQ/pxl_addr_next[14]} {CLK_SEQ/pxl_addr_next[15]} {CLK_SEQ/pxl_addr_next[16]} {CLK_SEQ/pxl_addr_next[17]} {CLK_SEQ/pxl_addr_next[18]} {CLK_SEQ/pxl_addr_next[19]} {CLK_SEQ/pxl_addr_next[20]} {CLK_SEQ/pxl_addr_next[21]} {CLK_SEQ/pxl_addr_next[22]} {CLK_SEQ/pxl_addr_next[23]} {CLK_SEQ/pxl_addr_next[24]} {CLK_SEQ/pxl_addr_next[25]} {CLK_SEQ/pxl_addr_next[26]} {CLK_SEQ/pxl_addr_next[27]} {CLK_SEQ/pxl_addr_next[28]} {CLK_SEQ/pxl_addr_next[29]} {CLK_SEQ/pxl_addr_next[30]} {CLK_SEQ/pxl_addr_next[31]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets INTERN_CLK_IBUF_BUFG]
