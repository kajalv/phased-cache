// dataLine stores the data associated with one cache line. Size: 128 bits or 16 B
module dataLine(input clk, input reset, input write_enable, input load, input [15:0] byte_select, input [7:0] dataByteIn, input [127:0] init, input [127:0] dataIn, output [127:0] dataOut);

  // byte_select is the decoded offset used to select one particular byte to write into
	reg [7:0] dat0, dat1, dat2, dat3, dat4, dat5, dat6, dat7, dat8, dat9, dat10, dat11, dat12, dat13, dat14, dat15;

  // (write_enable&byte_select[0])|load -
  // write signal for the data byte has to be enabled either during load or write operations
  // In case of load, all 16 B are replaced whereas in case of write, 1 B is replaced indicated by byte_select.
	dataByte D0(clk, reset, (write_enable&byte_select[0])|load, init[7:0], dat0, dataOut[7:0]);
	dataByte D1(clk, reset, (write_enable&byte_select[1])|load, init[15:8], dat1, dataOut[15:8]);
	dataByte D2(clk, reset, (write_enable&byte_select[2])|load, init[23:16], dat2, dataOut[23:16]);
	dataByte D3(clk, reset, (write_enable&byte_select[3])|load, init[31:24], dat3, dataOut[31:24]);
	dataByte D4(clk, reset, (write_enable&byte_select[4])|load, init[39:32], dat4, dataOut[39:32]);
	dataByte D5(clk, reset, (write_enable&byte_select[5])|load, init[47:40], dat5, dataOut[47:40]);
	dataByte D6(clk, reset, (write_enable&byte_select[6])|load, init[55:48], dat6, dataOut[55:48]);
	dataByte D7(clk, reset, (write_enable&byte_select[7])|load, init[63:56], dat7, dataOut[63:56]);
	dataByte D8(clk, reset, (write_enable&byte_select[8])|load, init[71:64], dat8, dataOut[71:64]);
	dataByte D9(clk, reset, (write_enable&byte_select[9])|load, init[79:72], dat9, dataOut[79:72]);
	dataByte D10(clk, reset, (write_enable&byte_select[10])|load, init[87:80], dat10, dataOut[87:80]);
	dataByte D11(clk, reset, (write_enable&byte_select[11])|load, init[95:88], dat11, dataOut[95:88]);
	dataByte D12(clk, reset, (write_enable&byte_select[12])|load, init[103:96], dat12, dataOut[103:96]);
	dataByte D13(clk, reset, (write_enable&byte_select[13])|load, init[111:104], dat13, dataOut[111:104]);
	dataByte D14(clk, reset, (write_enable&byte_select[14])|load, init[119:112], dat14, dataOut[119:112]);
	dataByte D15(clk, reset, (write_enable&byte_select[15])|load, init[127:120], dat15, dataOut[127:120]);

  // dat0 - dat15 hold the values to be written into each dataByte (if write condition is asserted)
  // dat0 - dat15 hold the data block in case of load and one of these is set to dataByteIn in case of write
	always @ (clk, load, write_enable, byte_select, dataByteIn, dataIn)
	  begin
		  if (load)
		    begin
			    dat0 = dataIn[7:0];
			    dat1 = dataIn[15:8];
			    dat2 = dataIn[23:16];
			    dat3 = dataIn[31:24];
			    dat4 = dataIn[39:32];
			    dat5 = dataIn[47:40];
    			dat6 = dataIn[55:48];
		    	dat7 = dataIn[63:56];
    			dat8 = dataIn[71:64];
			    dat9 = dataIn[79:72];
		    	dat10 = dataIn[87:80];
		    	dat11 = dataIn[95:88];
		    	dat12 = dataIn[103:96];
		    	dat13 = dataIn[111:104];
		    	dat14 = dataIn[119:112];
		    	dat15 = dataIn[127:120];
	     	end
		  else
		    begin
    			case (byte_select) //on selection of byte,control signals activated, dataByteIn fed into particular byte within 16 bytes
				    16'b0000000000000001 : dat0 = dataByteIn;
		        16'b0000000000000010 : dat1 = dataByteIn;
		        16'b0000000000000100 : dat2 = dataByteIn;
		        16'b0000000000001000 : dat3 = dataByteIn;
		        16'b0000000000010000 : dat4 = dataByteIn;
		        16'b0000000000100000 : dat5 = dataByteIn;
		        16'b0000000001000000 : dat6 = dataByteIn;
		        16'b0000000010000000 : dat7 = dataByteIn;
		        16'b0000000100000000 : dat8 = dataByteIn;
		        16'b0000001000000000 : dat9 = dataByteIn;
		        16'b0000010000000000 : dat10 = dataByteIn;
		        16'b0000100000000000 : dat11 = dataByteIn;
		        16'b0001000000000000 : dat12 = dataByteIn;
		        16'b0010000000000000 : dat13 = dataByteIn;
		        16'b0100000000000000 : dat14 = dataByteIn;
			      16'b1000000000000000 : dat15 = dataByteIn;
			    endcase
		    end
	  end

endmodule
