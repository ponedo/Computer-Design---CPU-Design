
module EX_MEM(RegWrite_i, RegWrite_o, 
             RegData_i, RegData_o, 
             MemRead_i, MemRead_o, 
             MemWrite_i, MemWrite_o,
             Op_i, Op_o,
             ALUResult_i, ALUResult_o,
             Data_i, Data_o,
             Rd_i, Rd_o,
             clk, rst);
  
  input RegWrite_i;
  output reg RegWrite_o;
  input RegData_i;
  output reg RegData_o;
  input MemRead_i;
  output reg MemRead_o;
  input MemWrite_i;
  output reg MemWrite_o;
  input [5:0] Op_i;
  output reg [5:0] Op_o;
  input [31:0] ALUResult_i;
  output reg [31:0] ALUResult_o;
  input [31:0] Data_i;
  output reg [31:0] Data_o;
  input [4:0] Rd_i;
  output reg [4:0] Rd_o;
  input clk;
  input rst;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        RegWrite_o <= 0;
        RegData_o <= 0;
        MemRead_o <= 0;
        MemWrite_o <= 0;
        Op_o <= 6'b00_0000;
        ALUResult_o <= 32'h0000_0000;
        Data_o <= 32'h0000_0000;
        Rd_o <= 5'b0_0000;
      end
    else
      begin
        RegWrite_o <= RegWrite_i;
        RegData_o <= RegData_i;
        MemRead_o <= MemRead_i;
        MemWrite_o <= MemWrite_i;
        Op_o <= Op_i;
        ALUResult_o <= ALUResult_i;
        Data_o <= Data_i;
        Rd_o <= Rd_i;
      end
  end
  
endmodule