transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+adc_frame_mem  -L xpm -L blk_mem_gen_v8_4_6 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.adc_frame_mem xil_defaultlib.glbl

do {adc_frame_mem.udo}

run

endsim

quit -force
