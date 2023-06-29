# TopmetalSe Sequencer
Sequencer for TopmetalSe + Test Board
This project contains the Vivado project for the FPGA firmware for the TopmetalSe Pixel Imager.



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

