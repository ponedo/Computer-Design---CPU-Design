`include "./Instr_defines.v"
`include "./ALU_defines.v"
`include "./EXT_defines.v"

module ctrl(
  input rst,
  input [5:0] OP,
  output reg ALUSrc,
  output reg RegWrite,
  output reg MemRead,
  output reg MemWrite,
  output reg MemtoReg,
  output reg [1:0] EXTOp,
  output reg [1:0] ALUOp,
  output reg Jump,
  output reg Branch,
  output reg RegDst);
  
  always @ (*)
  begin
    if (rst)
      begin
        RegDst <= 0;
        ALUSrc <= 0;
        MemtoReg <= 0;
        RegWrite <= 0;
        MemRead <= 0;
        MemWrite <= 0;
        Jump <= 0;
        Branch <= 0;
        EXTOp <= 2'b00;
        ALUOp <= 2'b00;
      end
    else
      begin
        case (OP)
        //R-format
        `OP_R:
          begin
            RegDst <= 1;
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 0;
            Branch <= 0;
            EXTOp <= 2'b00;//EXTOp is arbitrary
            ALUOp <= `ALUOP_R;
          end
        //I-format
        6'h08,
        6'h09,
        6'h0a,
        6'h0b:
          begin 
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 0;
            Branch <= 0;
            EXTOp <= `EXTOP_ARITH;
            ALUOp <= `ALUOP_I;
          end
        6'h0c,
        6'h0d,
        6'h0e,
        6'h0f:
          begin 
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 0;
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 0;
            Branch <= 0;
            EXTOp <= `EXTOP_LOGIC;
            ALUOp <= `ALUOP_I;
          end
        //J-format(j)
        `OP_J:
          begin
            RegDst <= 1'b0;//RegDst is arbitrary
            ALUSrc <= 1'b0;//ALUSrc is arbitrary
            MemtoReg <= 1'b0;//MemtoReg is arbitrary
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 1;
            Branch <= 0;
            EXTOp <= 2'b00;//EXTOp is arbitrary
            ALUOp <= 2'b00;//ALUOp is arbitrary
          end
        //J-format(jal)
        `OP_JAL:
           begin
            RegDst <= 1'b0;//RegDst is arbitrary
            ALUSrc <= 1'b0;//ALUSrc is arbitrary
            MemtoReg <= 1'b0;//MemtoReg is arbitrary
            RegWrite <= 1;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 1;
            Branch <= 0;
            EXTOp <= 2'b00;//EXTOp is arbitrary
            ALUOp <= 2'b00;//ALUOp is arbitrary
          end
        
        //lw
        `OP_LW:
          begin 
            RegDst <= 0;
            ALUSrc <= 1;
            MemtoReg <= 1;
            RegWrite <= 1;
            MemRead <= 1;
            MemWrite <= 0;
            Jump <= 0;
            Branch <= 0;
            EXTOp <= `EXTOP_ARITH;
            ALUOp <= `ALUOP_LW;
          end
        //sw
        `OP_SW:
          begin
            RegDst <= 1'b0;//RegDst is arbitrary
            ALUSrc <= 1;
            MemtoReg <= 1'b0;//MemtoReg is arbitrary
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 1;
            Jump <= 0;
            Branch <= 0;
            EXTOp <= `EXTOP_ARITH;
            ALUOp <= `ALUOP_SW;
          end
        //beq
        `OP_BEQ:
          begin
            RegDst <= 1'b0;//RegDst is arbitrary
            ALUSrc <= 0;
            MemtoReg <= 1'b0;//MemtoReg is arbitrary
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 0;
            Branch <= 1;
            EXTOp <= `EXTOP_ARITH;
            ALUOp <= `ALUOP_BEQ;
          end
		  default:
			 begin
			   RegDst <= 0;
            ALUSrc <= 0;
            MemtoReg <= 0;
            RegWrite <= 0;
            MemRead <= 0;
            MemWrite <= 0;
            Jump <= 0;
            Branch <= 0;
            EXTOp <= 2'b00;
            ALUOp <= 2'b00;
			 end
      endcase
    end
  end
  
endmodule