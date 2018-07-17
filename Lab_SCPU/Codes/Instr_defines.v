`ifndef Instr_DEFINES_V
`define Instr_DEFINES_V
  
  `define OP_R 6'h00
  `define OP_LW 6'h23
  `define OP_SW 6'h2b
  `define OP_BEQ 6'h04
  `define OP_I 6'b001xxx
  `define OP_ADDI 6'h08
  `define OP_ADDIU 6'h09
  `define OP_SLTI 6'h0a
  `define OP_SLTIU 6'h0b
  `define OP_ANDI 6'h0c
  `define OP_ORI 6'h0d
  `define OP_XORI 6'h0e
  `define OP_LUI 6'h0f
  `define OP_J 6'h02
  `define OP_JAL 6'h03
  
`endif