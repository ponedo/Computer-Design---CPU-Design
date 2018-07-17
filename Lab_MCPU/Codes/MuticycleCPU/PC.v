module PC(pc_next, pc, PCRst, clk, PCWr);
  
  input [31:0] pc_next;
  input PCRst;
  input clk;
  input PCWr;
  output reg [31:0] pc;
  
  always @(posedge clk or posedge PCRst)
  begin
    if (PCRst)
      pc <= 32'h0000_0000;
    else
      if (PCWr)
        pc <= pc_next;
  end
  
endmodule