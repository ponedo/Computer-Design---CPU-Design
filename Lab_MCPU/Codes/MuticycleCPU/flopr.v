
module flopr(d, q, clk, rst);
  
  parameter bit=1;
  
  input [bit-1:0] d;
  input clk;
  input rst;
  output reg [bit-1:0] q;
  
  always @ (posedge clk)
  begin
    q <= d;
  end
  
endmodule