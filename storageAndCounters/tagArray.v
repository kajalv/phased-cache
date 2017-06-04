// One tag array in each way, each containing four tag lines - one for each cache line
module tagArray(input clk, input reset, input [1:0] index, input [3:0] index_dec, input load, input [25:0] init0,
				input [25:0] init1, input [25:0] init2, input[25:0] init3, input [25:0] tagIn, output [25:0] tagOut);

  wire [25:0] tag0, tag1, tag2, tag3;
  wire [3:0] write_enable;

  // The value in tagLine is modified only on load/replace for that particular set
  and wrTag0(write_enable[0], index_dec[0], load);
  and wrTag1(write_enable[1], index_dec[1], load);
  and wrTag2(write_enable[2], index_dec[2], load);
  and wrTag3(write_enable[3], index_dec[3], load);

  tagLine T0(clk, reset, write_enable[0], init0, tagIn, tag0);
  tagLine T1(clk, reset, write_enable[1], init1, tagIn, tag1);
  tagLine T2(clk, reset, write_enable[2], init2, tagIn, tag2);
  tagLine T3(clk, reset, write_enable[3], init3, tagIn, tag3);

  // tagOut gives the tag of the set indicated by the index
  mux4to1_26bits tag_mux(tag0, tag1, tag2, tag3, index, tagOut);

endmodule
