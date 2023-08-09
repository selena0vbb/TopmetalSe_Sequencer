# TopmetalSe Sequencer
Sequencer for TopmetalSe + Test Board
This project contains the Vivado project for the FPGA configuration for the control of the TopmetalSe Pixel Imager.

It is used to handle: the biasing of the device through the TI DAC 8568, the pixel selection of the small 3x3 array (SA), as well as the scan and pixel selection of the Large Array.

We can utilize these functions using UART communication via the USB port, described below:

# UART Control 

The default baud rate over the USB port is set to 9600.
Each word is 8 bits long, with the last 4 bits used primarly as the function control bits. That is:

X X X X C3 C2 C1 C0

where X refers to the "dont care" bits. The control bits are used:

xxxx0000 - DAC SPI Control ( +32 Bits)

D3 D2 D1 D0 0001 - Small Array Pixel Selection via UART

xxxx0011 - Small Array Pixel Selection via Hardware Switches

xxxx0100 - Large Array Pixel Selection + 16 bits (D15 - D0)

The DAC SPI writing is primarily described below as well as in the TI DAC 8568 manual, but the important thing is that after the first word is sent (8 bits), 4 more words are required (32 bits), where the 32 bits are described the manual.

The SA Pixel selection via Hardware sets it such that the switches on the Basys 3 board select the pixels.

The SA Pixel Selection via UART uses the first 4 bits of the initial 8 bit word as data bits. D3 to D0 are then used as an unsigned integer to describe the pixel number (p0 to p8).

The LA Pixel Selection via UART uses two more words of 8 bits to set the pixel number as an unsigned integer. Setting these data bits > 10,000 will turn the pixel scan on.

The code to control the whole system is in https://github.com/selena0vbb/TopmetalSeDrone

# SPI Control for TI DAC 8568
Inside util/, I include a python script which generates the 32-bit values to control a [Texas Instruments DAC 8568](https://www.ti.com/product/DAC8568?utm_source=google&utm_medium=cpc&utm_campaign=asc-null-null-GPN_EN-cpc-pf-google-wwe&utm_content=DAC8568&ds_k=DAC8568&DCM=yes&gclid=EAIaIQobChMIwIbj3O62_wIV-y-tBh3P_wriEAAYASAAEgLwtPD_BwE&gclsrc=aw.ds).

The primary functionality of this program is to convert from an input (voltage for a certain channel) and convert it into a 32 bit command for the DAC8568. There are a few details like setting internal references, loading and resets implemented as well.

The signalling is done via UART to our FPGA (srcs/new/uart_rx.vhd), which sends the signals via SPI (srcs/new/DAC_SPI.vhd) to the DAC.

Usage:
```
user@console$ python main.py --help
 ____       _                    _____ __  __ ____          ____            _             _ 
/ ___|  ___| | ___ _ __   __ _  |_   _|  \/  / ___|  ___   / ___|___  _ __ | |_ _ __ ___ | |
\___ \ / _ \ |/ _ \ '_ \ / _` |   | | | |\/| \___ \ / _ \ | |   / _ \| '_ \| __| '__/ _ \| |
 ___) |  __/ |  __/ | | | (_| |   | | | |  | |___) |  __/ | |__| (_) | | | | |_| | | (_) | |
|____/ \___|_|\___|_| |_|\__,_|   |_| |_|  |_|____/ \___|  \____\___/|_| |_|\__|_|  \___/|_|
                                                                                            

usage: DAC Writer [-h] [-ch [CH [CH ...]]] [-val [VAL [VAL ...]]] [-config CONFIG_FILE] [-i INTERACTIVE]

optional arguments:
  -h, --help            show this help message and exit
  -ch [CH [CH ...]]     Channel number or list of channels
  -val [VAL [VAL ...]]  Voltage value or list of voltages
  -config CONFIG_FILE   Config file
  -i INTERACTIVE        Interactive session
```
To set a voltage on a specific channel:

```
user@console$ python main.py -ch 1 2 3 -val 0.1 0.2 0.3
 ____       _                    _____ __  __ ____          ____            _             _ 
/ ___|  ___| | ___ _ __   __ _  |_   _|  \/  / ___|  ___   / ___|___  _ __ | |_ _ __ ___ | |
\___ \ / _ \ |/ _ \ '_ \ / _` |   | | | |\/| \___ \ / _ \ | |   / _ \| '_ \| __| '__/ _ \| |
 ___) |  __/ |  __/ | | | (_| |   | | | |  | |___) |  __/ | |__| (_) | | | | |_| | | (_) | |
|____/ \___|_|\___|_| |_|\__,_|   |_| |_|  |_|____/ \___|  \____\___/|_| |_|\__|_|  \___/|_|
                                                                                            

Setting DAC Values:

  Channel    Value(V)
---------  ----------
        1         0.1
        2         0.2
        3         0.3
```
I have also included an example config file that can be used. The voltage values in this case are only loaded onto the DAC after every voltage has been read onto the DAC shift registers:

```
user@console$ python main.py -config config.ini 
 ____       _                    _____ __  __ ____          ____            _             _ 
/ ___|  ___| | ___ _ __   __ _  |_   _|  \/  / ___|  ___   / ___|___  _ __ | |_ _ __ ___ | |
\___ \ / _ \ |/ _ \ '_ \ / _` |   | | | |\/| \___ \ / _ \ | |   / _ \| '_ \| __| '__/ _ \| |
 ___) |  __/ |  __/ | | | (_| |   | | | |  | |___) |  __/ | |__| (_) | | | | |_| | | (_) | |
|____/ \___|_|\___|_| |_|\__,_|   |_| |_|  |_|____/ \___|  \____\___/|_| |_|\__|_|  \___/|_|
                                                                                            

Setting DAC Values:

  Channel    Value(V)
---------  ----------
        0       1.3
        1       0.51
        2       0.397
        3       0.696
        4       1.143
        5       0.8
        6       0.35
        7       1
```

#Biasing of the TopmetalSe

