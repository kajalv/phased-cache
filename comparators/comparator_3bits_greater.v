module comparator_3bits_greater(input [2:0] in0, input [2:0] in1, output reg compOut);

  always @ (in0, in1)
    begin
      if (in0 > in1)
        compOut = 1'b1;
      else
        compOut = 1'b0;
    end

endmodule
