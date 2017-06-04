// One dirty array in each way, each containing four dirty bits - one for each line
// Dirty bit is set to 1'b1 if the data held in the cache line has been modified
module dirtyArray(input clk, input reset, input [1:0] index, input [3:0] index_dec, input load, input cycle_en, input rw, input hit_way, input [3:0] init, output dirtyOut);

  wire dOut0, dOut1, dOut2, dOut3;
  wire [3:0] write_enable;
  wire write_cond;

  // write_cond is asserted whenever the data line or data byte is being changed
  assign write_cond = cycle_en & (load | (rw & hit_way) );

  // Enables the write signal for the set indicated by the index
  and wrDirt0(write_enable[0], index_dec[0], write_cond);
  and wrDirt1(write_enable[1], index_dec[1], write_cond);
  and wrDirt2(write_enable[2], index_dec[2], write_cond);
  and wrDirt3(write_enable[3], index_dec[3], write_cond);

  // When a new data block is being loaded in case of a miss, dirty bit is set to 1'b0 (hit_way = 1'b0)
  // When a data byte in the block is modified, dirty bit is set to 1'b1 (hit_way = 1'b1)
  D_FF d0(clk, reset, write_enable[0], init[0], hit_way, dOut0);
  D_FF d1(clk, reset, write_enable[1], init[1], hit_way, dOut1);
  D_FF d2(clk, reset, write_enable[2], init[2], hit_way, dOut2);
  D_FF d3(clk, reset, write_enable[3], init[3], hit_way, dOut3);

  // dirtyOut gives the dirty bit of the set indicated by the index
  mux4to1_1bit dirty_mux(dOut0, dOut1, dOut2, dOut3, index, dirtyOut);

endmodule
