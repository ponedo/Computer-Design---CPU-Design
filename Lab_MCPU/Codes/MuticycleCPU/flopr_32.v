module flopr_32 (d, q, rst, clk);
  
  input [31:0] d;
  input rst;
  input clk;
  output reg [31:0] q;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst)
      q <= 32'h0000_0000;
    else
      q <= d;
  end
  
endmodule