// One data array in each way, each containing four dataLines - one for each cache line
module dataArray(input clk, input reset, input [1:0] index, input [3:0] index_dec, input load, input [3:0] offset,
		 input cycle_en, input rw, input hit_way, input [7:0] dataByteIn, input [127:0] init0,
     input [127:0] init1, input [127:0] init2, input[127:0] init3, input [127:0] dataIn, output [127:0] dataOut);

  wire [15:0] byte_select;
  wire [127:0] data0, data1, data2, data3;
  wire write_enable;

  // write_enable is asserted in the second phase in case of a write hit
  assign write_enable = rw & cycle_en & hit_way;
  // Decoded offset is used to provide byte_select with the dataLines
  decoder4to16 decodeOffset(1'b1, offset, byte_select);

  dataLine L0(clk, reset, write_enable&index_dec[0], load&index_dec[0], byte_select, dataByteIn, init0, dataIn, data0);
  dataLine L1(clk, reset, write_enable&index_dec[1], load&index_dec[1], byte_select, dataByteIn, init1, dataIn, data1);
  dataLine L2(clk, reset, write_enable&index_dec[2], load&index_dec[2], byte_select, dataByteIn, init2, dataIn, data2);
  dataLine L3(clk, reset, write_enable&index_dec[3], load&index_dec[3], byte_select, dataByteIn, init3, dataIn, data3);

  // dataOut gives the data block stored in the set indicated by the index
  mux4to1_128bits dataOutSel0(data0, data1, data2, data3, index, dataOut);

endmodule
