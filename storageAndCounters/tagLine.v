// tagLine stores the tag associated with one data line. Size: 26 bits
module tagLine(input clk, input reset, input write_enable, input [25:0] init, input [25:0] tagIn, output [25:0] tagOut);

	D_FF t0(clk, reset, write_enable, init[0], tagIn[0], tagOut[0]);
	D_FF t1(clk, reset, write_enable, init[1], tagIn[1], tagOut[1]);
	D_FF t2(clk, reset, write_enable, init[2], tagIn[2], tagOut[2]);
	D_FF t3(clk, reset, write_enable, init[3], tagIn[3], tagOut[3]);
	D_FF t4(clk, reset, write_enable, init[4], tagIn[4], tagOut[4]);
	D_FF t5(clk, reset, write_enable, init[5], tagIn[5], tagOut[5]);
	D_FF t6(clk, reset, write_enable, init[6], tagIn[6], tagOut[6]);
	D_FF t7(clk, reset, write_enable, init[7], tagIn[7], tagOut[7]);
	D_FF t8(clk, reset, write_enable, init[8], tagIn[8], tagOut[8]);
	D_FF t9(clk, reset, write_enable, init[9], tagIn[9], tagOut[9]);
	D_FF t10(clk, reset, write_enable, init[10], tagIn[10], tagOut[10]);
	D_FF t11(clk, reset, write_enable, init[11], tagIn[11], tagOut[11]);
	D_FF t12(clk, reset, write_enable, init[12], tagIn[12], tagOut[12]);
	D_FF t13(clk, reset, write_enable, init[13], tagIn[13], tagOut[13]);
	D_FF t14(clk, reset, write_enable, init[14], tagIn[14], tagOut[14]);
	D_FF t15(clk, reset, write_enable, init[15], tagIn[15], tagOut[15]);
	D_FF t16(clk, reset, write_enable, init[16], tagIn[16], tagOut[16]);
	D_FF t17(clk, reset, write_enable, init[17], tagIn[17], tagOut[17]);
	D_FF t18(clk, reset, write_enable, init[18], tagIn[18], tagOut[18]);
	D_FF t19(clk, reset, write_enable, init[19], tagIn[19], tagOut[19]);
	D_FF t20(clk, reset, write_enable, init[20], tagIn[20], tagOut[20]);
	D_FF t21(clk, reset, write_enable, init[21], tagIn[21], tagOut[21]);
	D_FF t22(clk, reset, write_enable, init[22], tagIn[22], tagOut[22]);
	D_FF t23(clk, reset, write_enable, init[23], tagIn[23], tagOut[23]);
	D_FF t24(clk, reset, write_enable, init[24], tagIn[24], tagOut[24]);
	D_FF t25(clk, reset, write_enable, init[25], tagIn[25], tagOut[25]);

endmodule
