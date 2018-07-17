`ifndef ALU_DEFINES_V
`define ALU_DEFINES_V

  `define ALUOP_R 2'b10
  `define ALUOP_I 2'b11
  `define ALUOP_LW 2'b00
  `define ALUOP_SW 2'b00
  `define ALUOP_BEQ 2'b01
  
  `define ALUCtrl_NOP   5'd0
  `define ALUCtrl_ADD   5'd1
  `define ALUCtrl_SUB   5'd2
  `define ALUCtrl_SLT   5'd3  //optional
  `define ALUCtrl_SLTU  5'd4  //optional
  
  `define ALUCtrl_DIV   5'd5  //optional
  `define ALUCtrl_DIVU  5'd6  //optional
  `define ALUCtrl_MULT  5'd7  //optional
  `define ALUCtrl_MULTU 5'd8  //optional
  
  `define ALUCtrl_AND   5'd9
  `define ALUCtrl_NOR   5'd10
  `define ALUCtrl_OR    5'd11
  `define ALUCtrl_LUI   5'd12
  
  `define ALUCtrl_SLL   5'd13
  `define ALUCtrl_SRL   5'd14
  `define ALUCtrl_SRA   5'd15
  
`endif
