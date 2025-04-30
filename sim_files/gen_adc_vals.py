import numpy as np

with open('ADC_values.txt', 'w')as f:
    f.write('00000101\n')
    for x in range(0,10000-1):
        f.write('00000100\n')
    f.write('00000000\n')

    for x in range(0,5000):
        f.write('00000100\n')
#    f.write('00001000\n')
    for x in range(0,10000):
        f.write('00000000\n')
