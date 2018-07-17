`ifndef ALU_DEFINES_V
`define ALU_DEFINES_V

  `define ALUOP_ADD 4'b0000
  `define ALUOP_SUB 4'b0001
  `define ALUOP_R 4'b0010
  `define ALUOP_ADDI 4'b0100
  `define ALUOP_ADDIU 4'b0101
  `define ALUOP_SLTI 4'b0110
  `define ALUOP_SLTIU 4'b0111
  `define ALUOP_ANDI 4'b1000
  `define ALUOP_ORI 4'b1001
  `define ALUOP_XORI 4'b1010
  `define ALUOP_LUI 4'b1011
  
  `define ALUCtrl_NOP   5'd0
  `define ALUCtrl_ADD   5'd1
  `define ALUCtrl_ADDU  5'd17
  `define ALUCtrl_SUB   5'd2
  `define ALUCtrl_SUBU  5'd18
  `define ALUCtrl_SLT   5'd3  //optional
  `define ALUCtrl_SLTU  5'd4  //optional
  
  `define ALUCtrl_DIV   5'd5  //optional
  `define ALUCtrl_DIVU  5'd6  //optional
  `define ALUCtrl_MULT  5'd7  //optional
  `define ALUCtrl_MULTU 5'd8  //optional
  
  `define ALUCtrl_AND   5'd9
  `define ALUCtrl_NOR   5'd10
  `define ALUCtrl_OR    5'd11
  `define ALUCtrl_XOR   5'd12
  `define ALUCtrl_LUI   5'd13
  
  `define ALUCtrl_SLL   5'd14
  `define ALUCtrl_SRL   5'd15
  `define ALUCtrl_SRA   5'd16
  
`endif
