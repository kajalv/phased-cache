module way(input clk, input reset, input [25:0] tagIn, input [1:0] index, input [3:0] index_dec, input [3:0] offset,
			input dec, input load, input cycle_en, input rw, input hit_way, input [7:0] dataByteIn, input [127:0] dataIn,
			input [3:0] init_dirty, input [3:0] init_valid, input [25:0] init_tag0, input [25:0] init_tag1, input [25:0] init_tag2,
			input [25:0] init_tag3, input[2:0] init_ctr0, input [2:0] init_ctr1, input [2:0] init_ctr2, input [2:0] init_ctr3,
			input [127:0] init_data0, input [127:0] init_data1, input [127:0] init_data2, input [127:0] init_data3,
			output [25:0] tagOut, output [127:0] dataOut, output validOut, output dirtyOut, output [2:0] ctrOut);

  // A way consists of four sets. Each set has a tag line, data line, valid bit, dirty bit and counter associated with it.
  tagArray tag_way(clk, reset, index, index_dec, load, init_tag0, init_tag1, init_tag2, init_tag3, tagIn, tagOut);
  dataArray data_way(clk, reset, index, index_dec, load, offset, cycle_en, rw, hit_way, dataByteIn, init_data0, init_data1,
					 init_data2, init_data3, dataIn, dataOut);
  validArray valid_way(clk, reset, index, index_dec, init_valid, load, validOut);
  dirtyArray dirty_way(clk, reset, index, index_dec, load, cycle_en, rw, hit_way, init_dirty, dirtyOut);
  ctrArray ctr_way(clk, reset, index, index_dec, dec, load, init_ctr0, init_ctr1, init_ctr2, init_ctr3, ctrOut);

endmodule
