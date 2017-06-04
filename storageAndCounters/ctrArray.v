// One counter array in each way, each containing four counters - one for each cache line
module ctrArray(input clk, input reset, input [1:0] index, input [3:0] index_dec, input dec, input load, input [2:0] init0,
				input [2:0] init1, input [2:0] init2, input [2:0] init3, output [2:0] ctrOutFinal);

  wire [2:0] ctr0, ctr1, ctr2, ctr3;

  // dec&index_dec[] - If data is being loaded into some other way, then the counter of the set indicated by index is decremented
  // load&index_dec[] - asserted when the associated data block is being replaced. Counter must be set to 3'b111
  ctr_3bit c0(clk, reset, dec&index_dec[0], load&index_dec[0], init0, ctr0);
  ctr_3bit c1(clk, reset, dec&index_dec[1], load&index_dec[1], init1, ctr1);
  ctr_3bit c2(clk, reset, dec&index_dec[2], load&index_dec[2], init2, ctr2);
  ctr_3bit c3(clk, reset, dec&index_dec[3], load&index_dec[3], init3, ctr3);

  // ctrOutFinal gives the counter value stored in the set indicated by the index
  mux4to1_3bits mux1(ctr0, ctr1, ctr2, ctr3, index, ctrOutFinal);

endmodule
