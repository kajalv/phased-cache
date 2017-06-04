// top module
module cache_8way(input clk, input reset, input [25:0] tagIn, input [1:0] index, input [3:0] offset, input cycle_en, input rw,
		  input [127:0] dataIn, input [7:0] dataByteIn, input [3:0] init_dirty0, input [3:0] init_dirty1, input [3:0] init_dirty2,
		  input [3:0] init_dirty3, input [3:0] init_dirty4, input [3:0] init_dirty5, input [3:0] init_dirty6, input [3:0] init_dirty7,
		  input [3:0] init_valid0, input [3:0] init_valid1, input [3:0] init_valid2, input [3:0] init_valid3, input [3:0] init_valid4,
		  input [3:0] init_valid5, input [3:0] init_valid6, input [3:0] init_valid7, input [25:0] init_tag0, input [25:0] init_tag1,
		  input [25:0] init_tag2, input [25:0] init_tag3, input [25:0]init_tag4, input [25:0] init_tag5, input [25:0] init_tag6,
			input [25:0] init_tag7, input [25:0] init_tag8, input [25:0] init_tag9, input [25:0] init_tag10, input [25:0] init_tag11,
			input [25:0] init_tag12, input [25:0] init_tag13, input [25:0] init_tag14, input [25:0] init_tag15, input [25:0] init_tag16,
			input [25:0] init_tag17, input [25:0] init_tag18, input [25:0] init_tag19, input [25:0] init_tag20, input [25:0] init_tag21,
			input [25:0] init_tag22, input [25:0] init_tag23, input [25:0] init_tag24, input [25:0] init_tag25, input [25:0] init_tag26,
			input [25:0] init_tag27, input [25:0] init_tag28, input [25:0] init_tag29, input [25:0] init_tag30, input [25:0] init_tag31,
			input [127:0] init_data0, input [127:0] init_data1, input [127:0] init_data2, input [127:0] init_data3, input [127:0] init_data4,
			input [127:0] init_data5, input [127:0] init_data6, input [127:0] init_data7, input [127:0] init_data8, input [127:0] init_data9,
			input [127:0] init_data10, input [127:0] init_data11, input [127:0]  init_data12, input [127:0] init_data13, input [127:0] init_data14,
			input [127:0] init_data15, input [127:0] init_data16, input [127:0] init_data17, input [127:0] init_data18, input [127:0] init_data19,
			input [127:0] init_data20, input[127:0] init_data21, input [127:0] init_data22, input [127:0] init_data23, input [127:0] init_data24,
			input [127:0] init_data25, input [127:0] init_data26, input [127:0] init_data27, input [127:0] init_data28, input [127:0] init_data29,
			input [127:0] init_data30, input [127:0] init_data31, input [2:0] init_ctr0, input [2:0] init_ctr1, input [2:0] init_ctr2, input[2:0] init_ctr3,
			input [2:0] init_ctr4, input [2:0] init_ctr5, input [2:0] init_ctr6, input [2:0] init_ctr7, input [2:0] init_ctr8, input [2:0] init_ctr9,
			input [2:0] init_ctr10, input [2:0] init_ctr11, input [2:0] init_ctr12, input [2:0] init_ctr13, input [2:0] init_ctr14, input [2:0] init_ctr15,
			input [2:0] init_ctr16, input [2:0] init_ctr17, input [2:0] init_ctr18, input [2:0] init_ctr19, input [2:0] init_ctr20, input [2:0] init_ctr21,
			input [2:0] init_ctr22, input [2:0] init_ctr23, input [2:0] init_ctr24, input [2:0] init_ctr25, input [2:0] init_ctr26, input [2:0] init_ctr27,
			input [2:0] init_ctr28, input [2:0] init_ctr29, input [2:0] init_ctr30, input [2:0] init_ctr31, output [7:0] dataByte_read, output hit);

  wire read_out_cond, replace_cond, allValid;
  wire [2:0] ctr0, ctr1, ctr2, ctr3, ctr4, ctr5, ctr6, ctr7;
  wire [2:0] wayhit_enc, way_in0, way_in1, way_replace, currentCtr;
  wire [3:0] index_dec;
  wire [7:0] dec, dec_in, load, valid, dirty, tagAndValid, tagMatch, selected_byte, or_bits;
  wire [25:0] tag0, tag1, tag2, tag3, tag4, tag5, tag6, tag7;
  wire [127:0] data0, data1, data2, data3, data4, data5, data6, data7, selected_block;

  // FIFO implementation

  // replace_cond enabled in the second phase in case of a read/write miss
  assign replace_cond = cycle_en & ~hit;

  // Noring the counter bits to find the one having value 3'b000. Output in or_bits[] for the counter will be 1'b1 in such a case
  assign or_bits[0] = ~(ctr0[0] | ctr0[1] | ctr0[2]);
  assign or_bits[1] = ~(ctr1[0] | ctr1[1] | ctr1[2]);
  assign or_bits[2] = ~(ctr2[0] | ctr2[1] | ctr2[2]);
  assign or_bits[3] = ~(ctr3[0] | ctr3[1] | ctr3[2]);
  assign or_bits[4] = ~(ctr4[0] | ctr4[1] | ctr4[2]);
  assign or_bits[5] = ~(ctr5[0] | ctr5[1] | ctr5[2]);
  assign or_bits[6] = ~(ctr6[0] | ctr6[1] | ctr6[2]);
  assign or_bits[7] = ~(ctr7[0] | ctr7[1] | ctr7[2]);

  // allValid is 1'b0 if the valid bit of any line is a set is invalid
  assign allValid = valid[0] & valid[1] & valid[2] & valid[3] & valid[4] & valid[5] & valid[6] & valid[7];

  // Gives the way number of the first line in a set which is invalid
  priorityEncoder8to3 prEnc_val(1'b1, ~valid, way_in0);
  // Gives the way number of the first line whose counter value is 3'b000
  priorityEncoder8to3 find000(1'b1, or_bits, way_in1);
  // If any line is invalid, replace it, otherwise the replace the one which has counter 3'b000 by FIFO principles
  mux2to1_3bits wayRep(way_in0, way_in1, allValid, way_replace);
  // If replace_cond is asserted, the way number to be replaced is decoded into 8 load control signals passed to each way
  decoder3to8 load_dec(replace_cond, way_replace, load);

  // Choose counter value of the way being replaced as the reference counter
  mux8to1_3bits curCtrSel0(ctr0, ctr1, ctr2, ctr3, ctr4, ctr5, ctr6, ctr7, way_replace, currentCtr);

  // If a counter value > reference counter value and replace_cond is asserted, decrement signal is asserted
  comparator_3bits_greater comp_dec0(ctr0, currentCtr, dec_in[0]);
  comparator_3bits_greater comp_dec1(ctr1, currentCtr, dec_in[1]);
  comparator_3bits_greater comp_dec2(ctr2, currentCtr, dec_in[2]);
  comparator_3bits_greater comp_dec3(ctr3, currentCtr, dec_in[3]);
  comparator_3bits_greater comp_dec4(ctr4, currentCtr, dec_in[4]);
  comparator_3bits_greater comp_dec5(ctr5, currentCtr, dec_in[5]);
  comparator_3bits_greater comp_dec6(ctr6, currentCtr, dec_in[6]);
  comparator_3bits_greater comp_dec7(ctr7, currentCtr, dec_in[7]);

  assign dec[0] = replace_cond & dec_in[0];
  assign dec[1] = replace_cond & dec_in[1];
  assign dec[2] = replace_cond & dec_in[2];
  assign dec[3] = replace_cond & dec_in[3];
  assign dec[4] = replace_cond & dec_in[4];
  assign dec[5] = replace_cond & dec_in[5];
  assign dec[6] = replace_cond & dec_in[6];
  assign dec[7] = replace_cond & dec_in[7];

  // FIFO end

  // Decoded index is passed to each way to select correct set
  decoder2to4 decodeIndex(~cycle_en, index, index_dec);

  // Instantiation of 8 ways
  way w0(clk, reset, tagIn, index, index_dec, offset, dec[0], load[0], cycle_en, rw, tagAndValid[0], dataByteIn, dataIn, init_dirty0, init_valid0,
	init_tag0, init_tag8, init_tag16, init_tag24, init_ctr0, init_ctr8, init_ctr16, init_ctr24, init_data0, init_data8, init_data16, init_data24,
	tag0, data0, valid[0], dirty[0], ctr0);
  way w1(clk, reset, tagIn, index, index_dec, offset, dec[1], load[1], cycle_en, rw, tagAndValid[1], dataByteIn, dataIn, init_dirty1, init_valid1,
	init_tag1, init_tag9, init_tag17, init_tag25, init_ctr1, init_ctr9, init_ctr17, init_ctr25, init_data1, init_data9, init_data17, init_data25,
	tag1, data1, valid[1], dirty[1], ctr1);
  way w2(clk, reset, tagIn, index, index_dec, offset, dec[2], load[2], cycle_en, rw, tagAndValid[2], dataByteIn, dataIn, init_dirty2, init_valid2,
	init_tag2, init_tag10, init_tag18, init_tag26, init_ctr2, init_ctr10, init_ctr18, init_ctr26, init_data2, init_data10, init_data18, init_data26,
	tag2, data2, valid[2], dirty[2], ctr2);
  way w3(clk, reset, tagIn, index, index_dec, offset, dec[3], load[3], cycle_en, rw, tagAndValid[3], dataByteIn, dataIn, init_dirty3, init_valid3,
	init_tag3, init_tag11, init_tag19, init_tag27, init_ctr3, init_ctr11, init_ctr19, init_ctr27, init_data3, init_data11, init_data19, init_data27,
	tag3, data3, valid[3], dirty[3], ctr3);
  way w4(clk, reset, tagIn, index, index_dec, offset, dec[4], load[4], cycle_en, rw, tagAndValid[4], dataByteIn, dataIn, init_dirty4, init_valid4,
	init_tag4, init_tag12, init_tag20, init_tag28, init_ctr4, init_ctr12, init_ctr20, init_ctr28, init_data4, init_data12, init_data20, init_data28,
	tag4, data4, valid[4], dirty[4], ctr4);
  way w5(clk, reset, tagIn, index, index_dec, offset, dec[5], load[5], cycle_en, rw, tagAndValid[5], dataByteIn, dataIn, init_dirty5, init_valid5,
	init_tag5, init_tag13, init_tag21, init_tag29, init_ctr5, init_ctr13, init_ctr21, init_ctr29, init_data5, init_data13, init_data21, init_data29,
	tag5, data5, valid[5], dirty[5], ctr5);
  way w6(clk, reset, tagIn, index, index_dec, offset, dec[6], load[6], cycle_en, rw, tagAndValid[6], dataByteIn, dataIn, init_dirty6, init_valid6,
	init_tag6, init_tag14, init_tag22, init_tag30, init_ctr6, init_ctr14, init_ctr22, init_ctr30, init_data6, init_data14, init_data22, init_data30,
	tag6, data6, valid[6], dirty[6], ctr6);
  way w7(clk, reset, tagIn, index, index_dec, offset, dec[7], load[7], cycle_en, rw, tagAndValid[7], dataByteIn, dataIn, init_dirty7, init_valid7,
	init_tag7, init_tag15, init_tag23, init_tag31, init_ctr7, init_ctr15, init_ctr23, init_ctr31, init_data7, init_data15, init_data23, init_data31,
	tag7, data7, valid[7], dirty[7], ctr7);

  // Phase 1

  // Checking for tag match
  comparator_26bits_equal comp0(tag0, tagIn, tagMatch[0]);
  comparator_26bits_equal comp1(tag1, tagIn, tagMatch[1]);
  comparator_26bits_equal comp2(tag2, tagIn, tagMatch[2]);
  comparator_26bits_equal comp3(tag3, tagIn, tagMatch[3]);
  comparator_26bits_equal comp4(tag4, tagIn, tagMatch[4]);
  comparator_26bits_equal comp5(tag5, tagIn, tagMatch[5]);
  comparator_26bits_equal comp6(tag6, tagIn, tagMatch[6]);
  comparator_26bits_equal comp7(tag7, tagIn, tagMatch[7]);

  // Hit detected if tags match and corresponding valid bit is 1'b1.
  // tagAndValid[] is passed as hit_way to each way to detect if that way produced a hit
  and hit_way0(tagAndValid[0], tagMatch[0], valid[0]);
  and hit_way1(tagAndValid[1], tagMatch[1], valid[1]);
  and hit_way2(tagAndValid[2], tagMatch[2], valid[2]);
  and hit_way3(tagAndValid[3], tagMatch[3], valid[3]);
  and hit_way4(tagAndValid[4], tagMatch[4], valid[4]);
  and hit_way5(tagAndValid[5], tagMatch[5], valid[5]);
  and hit_way6(tagAndValid[6], tagMatch[6], valid[6]);
  and hit_way7(tagAndValid[7], tagMatch[7], valid[7]);

  // Overall hit detect
  assign hit = tagAndValid[0] | tagAndValid[1] | tagAndValid[2] | tagAndValid[3] | tagAndValid[4] | tagAndValid[5] | tagAndValid[6] | tagAndValid[7];

  // Phase 1 end

  // Find the way number which produced a hit
  encoder8to3 encodeWayHit(1'b1, tagAndValid, wayhit_enc);

  // For read hit - select the 128 bit data block from the way that produced a hit
  mux8to1_128bits selectDataBlock(data0, data1, data2, data3, data4, data5, data6, data7, wayhit_enc, selected_block);

  // Select the byte indicated by the offset from the selected data block
  mux16to1_8bits readByte(selected_block[127:120], selected_block[119:112], selected_block[111:104], selected_block[103:96], selected_block[95:88],
    selected_block[87:80], selected_block[79:72], selected_block[71:64], selected_block[63:56], selected_block[55:48], selected_block[47:40],
    selected_block[39:32], selected_block[31:24], selected_block[23:16], selected_block[15:8], selected_block[7:0], offset, selected_byte);

  // read_out_cond is asserted in second phase in case of a read hit
  assign read_out_cond = ~rw & cycle_en & hit;

  // dataByte_read set to 8'b0 in case of read miss or write operations. Holds non zero data only on read hit.
  and outFinal0(dataByte_read[0], selected_byte[0], read_out_cond);
  and outFinal1(dataByte_read[1], selected_byte[1], read_out_cond);
  and outFinal2(dataByte_read[2], selected_byte[2], read_out_cond);
  and outFinal3(dataByte_read[3], selected_byte[3], read_out_cond);
  and outFinal4(dataByte_read[4], selected_byte[4], read_out_cond);
  and outFinal5(dataByte_read[5], selected_byte[5], read_out_cond);
  and outFinal6(dataByte_read[6], selected_byte[6], read_out_cond);
  and outFinal7(dataByte_read[7], selected_byte[7], read_out_cond);

endmodule
