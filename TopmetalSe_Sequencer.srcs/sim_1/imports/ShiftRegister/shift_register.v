module shift_register
  #(
    parameter REG_DEPTH = 100
    )
   (
//`ifdef USE_POWER_PINS
 //   inout VDD,        // User area 1 1.8V supply
  //  inout GND,        // User area 1 digital ground
//`endif
    input  clk, //clock signal
    input  ena, //enable signal
    input  rst, //reset signal
    input  data_in,  //input bit
    output data_out, //output bit
    output [REG_DEPTH-1:0] COL_SEL
    );

   reg [REG_DEPTH-1:0] data_reg;

   always @(posedge clk or posedge rst) begin
      if (rst) begin //asynchronous reset
         data_reg <= {REG_DEPTH{1'b0}}; //load REG_DEPTH zeros
      end else if (ena) begin
         data_reg <= {data_reg[REG_DEPTH-2:0], data_in}; //load input data as LSB and shift (left) all other bits
      end
   end

   assign data_out = data_reg[REG_DEPTH-1]; //MSB is an output bit
   assign COL_SEL = data_reg;
   // pixel_array pixel_array_inst_0(.ROW_SEL(data_reg));

endmodule

// macro
// (* blackbox, keep="true" *)
// module pixel_array (ROW_SEL);
//    parameter NUM_ROWS = 3;
//    input [NUM_ROWS-1:0] ROW_SEL;
// endmodule
