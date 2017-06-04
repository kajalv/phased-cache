// Represents a single byte of data stored in the cache
module dataByte(input clk, input reset, input write_enable, input [7:0] init, input [7:0] dataIn, output [7:0] dataOut);

	D_FF d0(clk, reset, write_enable, init[0], dataIn[0], dataOut[0]);
	D_FF d1(clk, reset, write_enable, init[1], dataIn[1], dataOut[1]);
	D_FF d2(clk, reset, write_enable, init[2], dataIn[2], dataOut[2]);
	D_FF d3(clk, reset, write_enable, init[3], dataIn[3], dataOut[3]);
	D_FF d4(clk, reset, write_enable, init[4], dataIn[4], dataOut[4]);
	D_FF d5(clk, reset, write_enable, init[5], dataIn[5], dataOut[5]);
	D_FF d6(clk, reset, write_enable, init[6], dataIn[6], dataOut[6]);
	D_FF d7(clk, reset, write_enable, init[7], dataIn[7], dataOut[7]);

endmodule
