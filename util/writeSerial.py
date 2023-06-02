#!/usr/bin/env python

import serial
import pyfiglet
import sys

val_1 = sys.argv[1]
val_2 = sys.argv[2]
val_3 = sys.argv[3]
val_4 = sys.argv[4]

banner = pyfiglet.figlet_format("SELENA", font = "slant")
print(banner)
ser = serial.Serial('/dev/ttyUSB1', 9600)

test_packet = bytearray()
#test_packet.append(int(threshold_bin, 2))
test_packet.append(int(val_1))

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
