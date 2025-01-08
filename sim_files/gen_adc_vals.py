import numpy as np

with open('ADC_values.txt', 'w')as f:
    for x in range(0,10000):
        f.write('00001000\n')
    for x in range(0,10000):
        f.write('00000000\n')

    for x in range(0,10000):
        f.write('00010000\n')
