module IM (addr, dout);
  
  input [31:2] addr;
  output [31:0] dout;
  
  reg [31:0] im [12'hcff:12'hc00];
  
  assign dout = im[addr];
  
endmodule
