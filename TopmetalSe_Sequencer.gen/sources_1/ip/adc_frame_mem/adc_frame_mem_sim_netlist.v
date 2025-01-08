// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Mon Jan  6 15:50:00 2025
// Host        : phys-villain.washington.edu running 64-bit Fedora release 35 (Thirty Five)
// Command     : write_verilog -force -mode funcsim
//               /home/selena/TopmetalSe_Sequencer/TopmetalSe_Sequencer.gen/sources_1/ip/adc_frame_mem/adc_frame_mem_sim_netlist.v
// Design      : adc_frame_mem
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "adc_frame_mem,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module adc_frame_mem
   (clka,
    wea,
    addra,
    dina,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [13:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [13:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [13:0]addra;
  wire [13:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [13:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [13:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "14" *) 
  (* C_ADDRB_WIDTH = "14" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.153434 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "adc_frame_mem.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "10000" *) 
  (* C_READ_DEPTH_B = "10000" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "10000" *) 
  (* C_WRITE_DEPTH_B = "10000" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  adc_frame_mem_blk_mem_gen_v8_4_6 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[13:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[13:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aMT3usC6uizzcwnzOCX4OsS16Ob+YxFcsGovFpFklbnaIaD1S0lVdxenTwHPp6ByIEi+ehwr6Rgg
z/3AlTheI5NFTM8ihiMA18/wmUxI7EbaftJACA1LykUKCuj5myy0T+DACuv3sGYIZS38TZTZnnBC
FGAlvTZmRWs+JzneH3o=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lR9ZerhYSAb39nzEkeYvhnwEs5t9y/+yTDf8KuoUtR1BGeHZq8pA/YxtjzQLtaOW1R1IQUb0FtSI
e3CYAb7WHYbIjcpw3vKHvW1SqcGn9CMGa556CYKmD2oF12Kow8xRaFvMSBUVxX7HsHxNWnRd+PU1
+C0YayU2KFIY/7Yl6cZ5luAzhw/6SW3PFYUIyyqWy5MCIXweHOwQR2IpQEdlDur5nluN7i7BeB+i
fxwwHh8TU/g7T4mhZFkiTuBKdLAtQOjxWxzqTMxgcuAjlTylY16FgMFOASdvvSbqBZJjbxMdVloU
rYjS8O/8rWktv8GXcaIdBJ2BRj01q7jsChsbwA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Qvl63GHz9mq2xOB7elt/vAQ7URLGdD1Lkcz7f3Wtw31dwjjjbP62Ny/Jr6OmBIheWlgejx38qxAT
TrHiiEyjKmGcnPn1Tn2n+cH4RAxCbOFnCI9n6+YsYMTe9JkplGhGGr39SkFgJz0I2IKpPsuqTjCj
rhf49TAryNMQeRpREJA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MA+9Ro+dh339m0iZrkKbqTKN8gQ5xkxN/SPCfhkOn+5jjgCTS5IOKLHil+HsZDjX333ebxnornwG
MOBxyEdFfLM8SA+bs2r41J/j0af2VVMmCM3hOh8JmZxB4X9Jg/glegNCbvwzqxMbOQNEy+zt7j5t
TFVD82RtPFmYVVYZZyll/WvAA+0aVpyjzLCIM1GznFky0RWLv65Wp4MJJnNRRrtG3muMznVO/u2s
tACsJ9jzv9M0IlMYjYH9BixhG6cZX02I4LEXXaPkhdOINlMMhsbArXtc9NphzmS4bY1/1yF1D6YD
EKLyS2Sr3HDl0O/lefN+jvfG8iKuVl55PNNrVQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
wpMTg7STjFkUDhOqdNPa0FHXTnHQgKmhvqDv+rRVBvMiQ8O7u8oj7ibITq3o+jugJsMJ60B410gQ
JFTcqCJKYmYJvqi8rPLLOYDmFG6ZLP/Ixr3n62IyIaCeDltBahi3yV009QN0X+iuzuFCL+Y7g9ff
IvAgyBly+Z3Itv2H9EJMZPMl17Sa7IkgjmWqzVXIKNMKn0iDVYsQw6ZgzQDYQ8N8IvTIEggU3/lh
6Nf0hV0ev3qOv/2P+4w0U766Ux3yLuzPJSI7bKm3/ip9NjhOytxOiKKqVXhKG8dzbbuS5u3EE/eq
q6YxkL7gpvNltVqqBnJB6vHSyWrD6+MqsCtR9A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q7Q4SSp70lxFryaopuic9VVP/Ire0pSsPEIMYdURBAczC7ShkuYeV02U7L3BlAiyBE4vBKcwYSQd
cWiaj8sVP7q4kxoRHKxLV1R5PIO6l4DsLWE2E+1MLyUPME0w5KTular/oX8EPCJ5n/8VCtW7x4Vf
dpeyki1/IAPJkAyi3zVZKHzgKhEwnZaZZtZYuMWoPZMt4V38sAcE42Raf+7yfFWG5HO74JY6iEnW
gJeRk58K+avB/XLF2/j2RQZfjTYizrprT2tUMBK6e7DRWZZtk8AOcsMhUikev44IFGNbNXjP8BXC
0J3y3P7pCFT6l+saU83nRwi/H25fSA34diJtNw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a/8ooC+s+6nfvfa1+oBhsvYWLJjFgp83DI1kNyOi5Am+ugPbGRmgGZudfyo6yw6Yd5gGbLm5aToQ
5G4cGF5HaXD5TU6A0ZZFMTIbzFLE76JMjjIxX8JcaJIZpSmrXqlru8l5gDINUEAmwUY3mRQnjcGJ
0Z+kMRH8iAEF+gEviPiFZSBbJeOPqivIS217kimQJX3BeNbNPQTP+GUidcRywpGMh5avxtA0kDRO
F9SoCSyTm9hr2v9hsK1IUAYQLb7n2/R+z5YNKNzt1oN4qgJH1wZfdI8if2K8+ohyOdnxrrgJOWdj
cOqr7cGqEOYfBMTIQeHVZzb7NGWVN+9B8XSUaQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FLPvOUNRWNW2GU+FEGmt2XWthOT5bY/31DRbol2cUmEGNF6b2XzpCosNKGx/o2n6sQvGP39KRFCs
nJu0ihe2dUGee9nEZZUcpwPjnEfXVI3yJaRVYy8iL+rm59lXq0jX4sjAPieDvv8shgAnoXLTZGlq
K+2c1JhaHt+nFi27TDrYar/+P8nP1MhocOS7BjzCvSs0foEXj92/qD+71Sm/LqGr8cjlH2qTJJ8B
ynxoH6iT+bksVA2VbtPT9o6h1kJ/zwP4wcsL9l+qSlJhd4GI11JPux26DlNyIi41WmufQcfiT0PB
r6O9+0E9lV9ODwKdjaxfZRK29rjKeq2yr0jWhMV38XKKqHAJli7MIypGRXcCo+u89H87KgYt+ebw
s3foIqCe0JKR57WzI8VD6XdNtOL8eBxK539oemx4vkE0cGYECZKYru6A2hPeZOYDD5eyWSUlQl1R
EciK49WM8HnssyRVcmE6di6bISMbVi0TZG/v98bz+9UZa8DtqMVYH0tz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fphquQOeFuqByo36Gh2C1zEC1J6u9swSMbMzsKldIvLm+SZ6/hr/N8KJ/G2vBABzX6UtbVuP1ZXx
AxdftP4Aqis1B3Bs6989aQG9eo0SOHA7r6aFLtFb3qoD5Pvqw4aVNU4z4EtTpFpn/jCWD21lKROf
q5X32HRfFq1jwqod+9vIbUNRRzz5y9VHvXfacZlxDazSPmcCF4hxB1KqWqT44KmYVkDedgkgnYgb
ZGidHnTb3W7C8tSqC9ac4kNJCL429QndtddweESJNlpX+65pt9Irok9pkOodwoj0QScswOIFjhBZ
/GrzZLQcFWiD3gXRU4DazzxQnGdRH4qEIRWziw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1lUYYHPCt1BUJOvcBbgMU2GSQiqfxItz4ntieMaenjrtsE9SLwaU6xB0tBl8Atw5yP/RRNww1kX/
9uZbTz5He3r9mPVt+mGxB4N3f9BbCrQRb4USVPgKO/+vWUfMQERGklScy0+fz75WuxH74CjRUoDI
8iyssb2cUNnfDe13jIoI8gM1w4w/Pkxkmb6Mef53QMxacHAWEZeytcH3fuL/adO263D8P90U3XJv
vBXJmbjkRVi9qzjBzfMxuOy2KbZaZgR3BLzaffIfFnMwg/Rb8sGls5pQsZv5jL2wk3+Bj3OXBYdd
pDyjGoalJBzObKzd/t15kNHwY4FXYFcZLQPncw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YRmSEzaa2WFVvMH1BwWc1TIUpVbzSEIP0VbI6n0sEgct/X4PiTfMQmK1jBVCaISIzwBxscKQwZOt
mb/nmINGg6I7ih39LSbBMtx6cdCUiyaLkPeRbqfyPpKhvnUIFmdKVvTd1dYzxeOeuDnhSVaBaAcN
3lngSg7lIbmhLIGjC29yQrBTiLArbVZi6IRGronMK51e3UrYa6GspsznhiuRcXjEb4bHKrJ2CM5Z
BUwA+E9949sQgyOagFZbLVle2ESbwBaoxcAPn2gxfRHlT0leqyLgUGDZLsfArzGzw9BTGzyEG2TR
XOrKFNYRfMXMrnGsBM7acIelY4LdAMgsKgDH/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 61872)
`pragma protect data_block
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
po7GhCd/P0vBDOgo8Y0Pr5rXaIil13ArCtTL
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
