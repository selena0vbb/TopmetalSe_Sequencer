import DAC_control

import argparse
import configparser

from tabulate import tabulate
import pyfiglet

import numpy as np

if __name__ == '__main__':

    #Argument Parser
    parser = argparse.ArgumentParser(prog = 'DAC Writer')
    
    parser.add_argument('-ch', nargs='*', type=int)
    parser.add_argument('-val', nargs='*', type=int,)
    
    parser.add_argument('-config', nargs=1, type=argparse.FileType('r', encoding='UTF-8'), dest='config_file')

    parser.add_argument('-i',dest='interactive', type=bool)
   
    args=parser.parse_args()
    if (args.ch is not None) and (args.val is not None):
        use_config=False 
        if(len(args.ch) != len(args.val)):
            print('Num. Channels not the same as num. values')
            quit()
    else:
        use_config=True

    #Banner
    Banner = pyfiglet.figlet_format("Selena TMSe")#, font="doh", width=800)
    print(Banner)
    print("\nCode to control the TMSe\n\n") 

    #Setup DAC
    dac_device = DAC_control.DAC_8568()
    dac_device.set_internal_ref()

    #Begin Program
    if(args.interactive == True):
        print("Interactive Mode")

    else:
        print("Setting DAC Values:\n")
        
        if not use_config:
            table_ch_val = list(zip(args.ch, args.val))
        else:
            config=configparser.ConfigParser()
            config.read(args.config_file[0].name)
            
            ch = np.arange(0,8,1)
            val = []
            for ch_num in ch:
                ch_attr = 'ch_%i'%(ch_num)
                val.append(int(config['DAC'][ch_attr]))
                

            table_ch_val = list(zip(ch, val))

        print(tabulate(table_ch_val, headers=['Channel', 'Value']))
        
        for value_set in table_ch_val:
            channel = value_set[0]
            dac_value = value_set[1]

            dac_device.set_dac_voltage(channel, dac_value, load=True) #write DAC value and instantly load onto DAC
            

         
