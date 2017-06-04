// Stores a 3 bit value associated with FIFO order of replacement
module ctr_3bit(input clk, input reset, input dec, input load, input [2:0] init, output [2:0] ctrOut);

  reg [2:0] set_bit;
  D_FF ctrBit0(clk, reset, 1'b1, init[0], set_bit[0], ctrOut[0]);
  D_FF ctrBit1(clk, reset, 1'b1, init[1], set_bit[1], ctrOut[1]);
  D_FF ctrBit2(clk, reset, 1'b1, init[2], set_bit[2], ctrOut[2]);

  always @ (negedge clk)
    begin
      if (reset)
        set_bit = init;
      else if (load)              // On loading a new block, the associated FIFO counter is set to 3'b111
        set_bit = 3'b111;
      else if (dec)               // On loading a new block, all counter values greater than the one being replaced are decremented
        set_bit = ctrOut - 1;
      else                        // Do nothing
        set_bit = set_bit;
    end

endmodule
