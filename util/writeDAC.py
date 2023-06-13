#!/usr/bin/env python
#code to write to DACs
import serial
import pyfiglet
import sys
import argparse


ser = serial.Serial('/dev/ttyUSB1', 9600)



#argument parser
parser = argparse.ArgumentParser( prog = 'DAC Writer')
parser.add_argument('-ch',  type=int)


#args
args = parser.parse_args()

channel = args.ch


#bit conversion place
#DB0-DB3 are feature bits, we will ignore for now
BIT0_4 = "0000"

#DB4-DB19 are data bits, used for controlling voltage
#set it equal to 2^14
data_val = 2**8
data_str = (format(data_val, '016b'))

#channel
addr = (format(channel, '04b'))
print(addr)

test_1 = bytearray()
print(test_1)
#control section
CNTRL = "0001"

#prefix bits
PRFX = "0000"

#feature bits
ft_bits= "0000"

full_dat = (PRFX + CNTRL + addr+data_str+ft_bits)
packets = [int(full_dat[i:i+8],2) for i in range(0,32,8)]
print(full_dat)
print(len(full_dat))
print(packets)


packet_1 = bytearray()
packet_1.append(packets[3])
packet_1.append(packets[2])
packet_1.append(packets[1])
packet_1.append(packets[0])

ser.write(packet_1)


#lets jumper the LDAC pin to ground and use the software LDAC for simplicity, we have to write this


'''
val_1 = sys.argv[1]
val_2 = sys.argv[2]
val_3 = sys.argv[3]
val_4 = sys.argv[4]

banner = pyfiglet.figlet_format("SELENA", font = "slant")
print(banner)

test_packet = bytearray()
#test_packet.append(int(threshold_bin, 2))
t"est_packet.append(int(val_1))

empty_packet = bytearray()
empty_packet.append(int('00000000',2))

test2_packet = bytearray()
test2_packet.append(int(val_2))

test3_packet = bytearray()
test3_packet.append(int(val_3))

test4_packet = bytearray()
test4_packet.append(int(val_4))


ser.write(test_packet)
ser.write(empty_packet)
ser.write(test2_packet)
ser.write(empty_packet)
'''
