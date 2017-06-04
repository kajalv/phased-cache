// One valid array in each way, each containing four valid bits - one for each line
// Valid bit is used to indicate if the cache line contains valid data
module validArray(input clk, input reset, input [1:0] index, input [3:0] index_dec, input [3:0] init, input load, output validOut);

  wire vOut0, vOut1, vOut2, vOut3;
  wire [3:0] write_enable;

  // write_enable is asserted for the set corresponding to the index if load is 1'b1
  and wrVal0(write_enable[0], index_dec[0], load);
  and wrVal1(write_enable[1], index_dec[1], load);
  and wrVal2(write_enable[2], index_dec[2], load);
  and wrVal3(write_enable[3], index_dec[3], load);

  // D flip flops used to store the valid bits. If data is loaded onto cache line, its valid bit is set to 1'b1
  D_FF v0(clk, reset, write_enable[0], init[0], 1'b1, vOut0);
  D_FF v1(clk, reset, write_enable[1], init[1], 1'b1, vOut1);
  D_FF v2(clk, reset, write_enable[2], init[2], 1'b1, vOut2);
  D_FF v3(clk, reset, write_enable[3], init[3], 1'b1, vOut3);

  // validOut gives the valid bit of the set indicated by the index
  mux4to1_1bit valid_mux(vOut0, vOut1, vOut2, vOut3, index, validOut);

endmodule
