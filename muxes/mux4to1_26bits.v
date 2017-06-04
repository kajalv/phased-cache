module mux4to1_26bits(input [25:0] in0, input [25:0] in1, input [25:0] in2, input [25:0] in3, input [1:0] sel, output reg [25:0] muxOut);

	always @ (in0, in1, in2, in3, sel)
	  begin
		  case (sel)
			  2'b00: muxOut = in0;
			  2'b01: muxOut = in1;
			  2'b10: muxOut = in2;
			  2'b11: muxOut = in3;
		  endcase
	  end

endmodule
