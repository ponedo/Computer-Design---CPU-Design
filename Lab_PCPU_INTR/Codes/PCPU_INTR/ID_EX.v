
module ID_EX(pc_i, pc_o, 
             RegWrite_i, RegWrite_o, 
             RegData_i, RegData_o, 
             MemRead_i, MemRead_o, 
             MemWrite_i, MemWrite_o,
             ALUSrcA_i, ALUSrcA_o,
             ALUSrcB_i, ALUSrcB_o,
             ALUOp_i, ALUOp_o,
             RegDst_i, RegDst_o,
             Op_i, Op_o,
             R1_i, R1_o,
             R2_i, R2_o,
             Shamt_i, Shamt_o,
             Imm_i, Imm_o,
             Funct_i, Funct_o,
             Rs_i, Rs_o,
             Rt_i, Rt_o,
             Rd_i, Rd_o,
             c0Data_i, c0Data_o, 
             mfc0_i, mfc0_o, 
             clk, rst, 
             Cancel_ID);
             
  input [31:0] pc_i;
  output reg [31:0] pc_o;
  input RegWrite_i;
  output reg RegWrite_o;
  input [1:0] RegData_i;
  output reg [1:0] RegData_o;
  input MemRead_i;
  output reg MemRead_o;
  input MemWrite_i;
  output reg MemWrite_o;
  input ALUSrcA_i;
  output reg ALUSrcA_o;
  input ALUSrcB_i;
  output reg ALUSrcB_o;
  input [3:0] ALUOp_i;
  output reg [3:0] ALUOp_o;
  input RegDst_i;
  output reg RegDst_o;
  input [5:0] Op_i;
  output reg [5:0] Op_o;
  input [31:0] R1_i;
  output reg [31:0] R1_o;
  input [31:0] R2_i;
  output reg [31:0] R2_o;
  input [4:0] Shamt_i;
  output reg [4:0] Shamt_o;
  input [31:0] Imm_i;
  output reg [31:0] Imm_o;
  input [5:0] Funct_i;
  output reg [5:0] Funct_o;
  input [5:0] Rs_i;
  output reg [5:0] Rs_o;
  input [5:0] Rt_i;
  output reg [5:0] Rt_o;
  input [5:0] Rd_i;       //Rs, Rt and Rd are extended to 6-bit size,
  output reg [5:0] Rd_o;  //discerning cpu regs and c0 regs.
  input [31:0] c0Data_i;
  output reg [31:0] c0Data_o;
  input mfc0_i;
  output reg mfc0_o;
  input clk;
  input rst;
  input Cancel_ID;
  
  always @(posedge clk or posedge rst)
  begin
    if (rst)
      begin
        pc_o <= 32'h0000_0000;
        RegWrite_o <= 0;
        RegData_o <= 0;
        MemRead_o <= 0;
        MemWrite_o <= 0;
        ALUSrcA_o <= 0;
        ALUSrcB_o <= 0;
        ALUOp_o <= 4'b0000;
        RegDst_o <= 0;
        Op_o <= 6'b00_0000;
        R1_o <= 32'h0000_0000;
        R2_o <= 32'h0000_0000;
        Shamt_o <= 5'b0_0000;
        Imm_o <= 16'h0000;
        Funct_o <= 6'b00_0000;
        Rs_o <= 5'b0_0000;
        Rt_o <= 5'b0_0000;
        Rd_o <= 5'b0_0000;
        c0Data_o <= 32'h0000_0000;
        mfc0_o <= 0;
      end
    else
      begin
        if(Cancel_ID)
          begin
            pc_o <= 32'h0000_0000;
            RegWrite_o <= 0;
            RegData_o <= 0;
            MemRead_o <= 0;
            MemWrite_o <= 0;
            ALUSrcA_o <= 0;
            ALUSrcB_o <= 0;
            ALUOp_o <= 4'b0000;
            RegDst_o <= 0;
            Op_o <= 6'b00_0000;
            R1_o <= 32'h0000_0000;
            R2_o <= 32'h0000_0000;
            Shamt_o <= 5'b0_0000;
            Imm_o <= 16'h0000;
            Funct_o <= 6'b00_0000;
            Rs_o <= 5'b0_0000;
            Rt_o <= 5'b0_0000;
            Rd_o <= 5'b0_0000;
            c0Data_o <= 32'h0000_0000;
            mfc0_o <= 0;
          end
        else
          begin 
            pc_o <= pc_i; 
            RegWrite_o <= RegWrite_i;
            RegData_o <= RegData_i;
            MemRead_o <= MemRead_i;
            MemWrite_o <= MemWrite_i;
            ALUSrcA_o <= ALUSrcA_i;
            ALUSrcB_o <= ALUSrcB_i;
            ALUOp_o <= ALUOp_i;
            RegDst_o <= RegDst_i;
            Op_o <= Op_i;
            R1_o <= R1_i;
            R2_o <= R2_i;
            Shamt_o <= Shamt_i;
            Imm_o <= Imm_i;
            Funct_o <= Funct_i;
            Rs_o <= Rs_i;
            Rt_o <= Rt_i;
            Rd_o <= Rd_i;
            c0Data_o <= c0Data_i;
            mfc0_o <= mfc0_i;
          end
      end
  end
  
endmodule