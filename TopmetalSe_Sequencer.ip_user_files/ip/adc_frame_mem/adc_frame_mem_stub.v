// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Mon Jan  6 15:50:00 2025
// Host        : phys-villain.washington.edu running 64-bit Fedora release 35 (Thirty Five)
// Command     : write_verilog -force -mode synth_stub
//               /home/selena/TopmetalSe_Sequencer/TopmetalSe_Sequencer.gen/sources_1/ip/adc_frame_mem/adc_frame_mem_stub.v
// Design      : adc_frame_mem
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *)
module adc_frame_mem(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="wea[0:0],addra[13:0],dina[7:0],addrb[13:0],doutb[7:0]" */
/* synthesis syn_force_seq_prim="clka" */
/* synthesis syn_force_seq_prim="clkb" */;
  input clka /* synthesis syn_isclock = 1 */;
  input [0:0]wea;
  input [13:0]addra;
  input [7:0]dina;
  input clkb /* synthesis syn_isclock = 1 */;
  input [13:0]addrb;
  output [7:0]doutb;
endmodule
