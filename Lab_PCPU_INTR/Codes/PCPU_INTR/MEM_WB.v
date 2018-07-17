
module MEM_WB(RegWrite_i, RegWrite_o, 
              RegData_i, RegData_o, 
              ALUResult_i, ALUResult_o,
              MemData_i, MemData_o,
              Rd_i, Rd_o, 
              c0Data_i, c0Data_o, 
              mfc0_i, mfc0_o,  
              clk, rst);
  
  input RegWrite_i;
  output reg RegWrite_o;
  input [1:0] RegData_i;
  output reg [1:0] RegData_o;
  input [31:0] ALUResult_i;
  output reg [31:0] ALUResult_o;
  input [31:0] MemData_i;
  output reg [31:0] MemData_o;
  input [5:0] Rd_i;       //Rs, Rt and Rd are extended to 6-bit size,
  output reg [5:0] Rd_o;  //discerning cpu regs and c0 regs.
  input [31:0] c0Data_i;
  output reg [31:0] c0Data_o;
  input mfc0_i;
  output reg mfc0_o;
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
        c0Data_o <= 32'h0000_0000;
        mfc0_o <= 0;
      end
    else
      begin
        RegWrite_o <= RegWrite_i;
        RegData_o <= RegData_i;
        ALUResult_o <= ALUResult_i;
        MemData_o <= MemData_i;
        Rd_o <= Rd_i;
        c0Data_o <= c0Data_i;
        mfc0_o <= mfc0_i;
      end
  end
  
endmodule