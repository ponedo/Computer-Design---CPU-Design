module IR(instr_i, IRWrite, clk, rst, instr_o);
  
  input [31:0] instr_i;
  input IRWrite;
  input clk;
  input rst;
  output reg [31:0] instr_o;
  
  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      instr_o <= 32'h0000_0000;
    else
      if (IRWrite)
        instr_o <= instr_i;
  end
  
endmodule