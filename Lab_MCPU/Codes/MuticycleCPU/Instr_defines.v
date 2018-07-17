`ifndef Instr_DEFINES_V
`define Instr_DEFINES_V
  
  `define OP_R 6'h00
  `define OP_LW 6'h23
  `define OP_SW 6'h2b
  `define OP_BEQ 6'h04
  `define OP_BGEZ 6'h01
  `define OP_BGTZ 6'h07
  `define OP_BLEZ 6'h06
  `define OP_BLTZ 6'h01
  `define OP_BNQ 6'h05
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
  `define OP_LB 6'h20
  `define OP_LBU 6'h24
  `define OP_LH 6'h21
  `define OP_LHU 6'h25
  `define OP_LW 6'h23
  `define OP_SB 6'h28
  `define OP_SH 6'h29
  `define OP_SW 6'h2b
  
`endif