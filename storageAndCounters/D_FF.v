/*
D flip flop - the basic unit of storage for any data
*/

module D_FF(input clk, input reset, input writeEn, input init, input in, output reg out);

  always @ (negedge clk)
  begin
    if (reset)
      out = init;       // On reset, the initial value from testbench is loaded into the D flip flop
    else if (writeEn)
      out = in;
  end

endmodule
