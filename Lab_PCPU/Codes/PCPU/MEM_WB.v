
module MEM_WB(RegWrite_i, RegWrite_o, 
              RegData_i, RegData_o, 
              ALUResult_i, ALUResult_o,
              MemData_i, MemData_o,
              Rd_i, Rd_o,
              clk, rst);
  
  input RegWrite_i;
  output reg RegWrite_o;
  input RegData_i;
  output reg RegData_o;
  input [31:0] ALUResult_i;
  output reg [31:0] ALUResult_o;
  input [31:0] MemData_i;
  output reg [31:0] MemData_o;
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
        ALUResult_o <= 32'h0000_0000;
        MemData_o <= 32'h0000_0000;
        Rd_o <= 5'b0_0000;
      end
    else
      begin
        RegWrite_o <= RegWrite_i;
        RegData_o <= RegData_i;
        ALUResult_o <= ALUResult_i;
        MemData_o <= MemData_i;
        Rd_o <= Rd_i;
      end
  end
  
endmodule