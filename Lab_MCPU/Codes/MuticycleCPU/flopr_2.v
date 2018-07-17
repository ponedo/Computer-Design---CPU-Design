module flopr_2 (d, q, rst, clk);
  
  input [1:0] d;
  input rst;
  input clk;
  output reg [1:0] q;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst)
      q <= 2'b00;
    else
      q <= d;
  end
  
endmodule
