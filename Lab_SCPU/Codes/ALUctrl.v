`include "./ALU_defines.v"
`include "./Instr_defines.v"
module ALUCtrl(
  input [1:0] ALUOp,
  input [5:0] instr,
  output reg [4:0] ALUCtrl);
  
  always @(*)
  begin
    case (ALUOp)
      //lw, sw
		`ALUOP_LW,
      `ALUOP_SW:
        ALUCtrl <= `ALUCtrl_ADD;
      //beq
      `ALUOP_BEQ:
        ALUCtrl <= `ALUCtrl_SUB;
      //I-format
      `ALUOP_I:
        case (instr)
          `OP_ADDI:
            ALUCtrl <= `ALUCtrl_ADD;
          `OP_ADDIU://(tentatively)
            ALUCtrl <= `ALUCtrl_ADD;
          `OP_SLTI:
            ALUCtrl <= `ALUCtrl_SLT;
          `OP_SLTIU:
            ALUCtrl <= `ALUCtrl_SLTU;
          `OP_ANDI:
            ALUCtrl <= `ALUCtrl_AND;
          `OP_ORI:
            ALUCtrl <= `ALUCtrl_OR;
          `OP_XORI://tentatively
            ALUCtrl <= `ALUCtrl_NOP;
          `OP_LUI:
            ALUCtrl <= `ALUCtrl_LUI;
          default:
            ALUCtrl <= `ALUCtrl_NOP;
        endcase
      //J-format
        
      //R-format
      `ALUOP_R:
        case (instr)
          //add,addu(tentatively)
          6'h20,
          6'h21:
            ALUCtrl <= `ALUCtrl_ADD;
          //sub,subu(tentatively)
          6'h22,
          6'h23:
            ALUCtrl <= `ALUCtrl_SUB;
          6'h2a:
            ALUCtrl <= `ALUCtrl_SLT;
          6'h2b:
            ALUCtrl <= `ALUCtrl_SLTU;
          6'h1a:
            ALUCtrl <= `ALUCtrl_DIV;
          6'h1b:
            ALUCtrl <= `ALUCtrl_DIVU;
          6'h18:
            ALUCtrl <= `ALUCtrl_MULT;
          6'h19:
            ALUCtrl <= `ALUCtrl_MULTU;
          6'h24:
            ALUCtrl <= `ALUCtrl_AND;
          6'h27:
            ALUCtrl <= `ALUCtrl_NOR;
          6'h25:
            ALUCtrl <= `ALUCtrl_OR;
          6'h00:  
            ALUCtrl <= `ALUCtrl_SLL;
          6'h02:
            ALUCtrl <= `ALUCtrl_SRL;
          6'h03:
            ALUCtrl <= `ALUCtrl_SRA;
          default:
            ALUCtrl <= `ALUCtrl_NOP;
        endcase
		 
		default:
		    ALUCtrl <= `ALUCtrl_NOP;
    endcase
  end
  
endmodule