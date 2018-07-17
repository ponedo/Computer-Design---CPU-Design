
module IF_ID(Instr_i, PC_4_i,
             Instr_o, PC_4_o, 
             clk, rst, IF_IDWrite, IF_Flush);
  
  input [31:0] Instr_i;
  input [31:0] PC_4_i;
  input clk;
  input rst;
  input IF_IDWrite;
  input IF_Flush; //IF_Flush = Brch | Jmp[0]
  output reg [31:0] Instr_o;
  output reg [31:0] PC_4_o;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        Instr_o <= 32'h0000_0000;
        PC_4_o <= 32'h0000_0000;
      end
    else
      begin
      if (IF_IDWrite)
        begin
          Instr_o <= Instr_i;
          PC_4_o <= PC_4_i; 
        end
      if (IF_Flush)
        begin
          Instr_o <= 32'h0000_0000;
          PC_4_o <= 32'h0000_0000;
        end
      end
  end
  
endmodule