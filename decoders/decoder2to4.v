/*
A 2 to 4 decoder
*/

module decoder2to4(input enable, input [1:0] in, output reg [3:0] out);

  always @ (in)
    case (enable)
      1'b0: out = 4'b0000;
      1'b1: begin
              case (in)
                2'b00: out = 4'b0001;
                2'b01: out = 4'b0010;
                2'b10: out = 4'b0100;
                2'b11: out = 4'b1000;
              endcase
            end
    endcase

endmodule
