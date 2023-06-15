# TopmetalSe Sequencer
Sequencer for TopmetalSe + Test Board
This project contains the Vivado project for the FPGA firmware for the TopmetalSe Pixel Imager.



# SPI Control for TI DAC 8568
Inside util/, I include a python script which generates the 32-bit values to control a [Texas Instruments DAC 8568]{https://www.ti.com/product/DAC8568?utm_source=google&utm_medium=cpc&utm_campaign=asc-null-null-GPN_EN-cpc-pf-google-wwe&utm_content=DAC8568&ds_k=DAC8568&DCM=yes&gclid=EAIaIQobChMIwIbj3O62_wIV-y-tBh3P_wriEAAYASAAEgLwtPD_BwE&gclsrc=aw.ds}.

The primary functionality of this program is to convert from a given voltage for a certain channel and convert it into a 32 bit value for the DAC8568.

These value are sent via UART to our FPGA, which sends the signals via SPI to the DAC.


