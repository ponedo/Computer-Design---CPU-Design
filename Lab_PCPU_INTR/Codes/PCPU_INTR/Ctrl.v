`include "./ALU_defines.v"
`include "./EXT_defines.v"
`include "./Instr_defines.v"
`include "./Brch_defines.v"
`include "./INTR_defines.v"

module Ctrl (Instr, rst, clk,
             PCWriteCond, MemRead, MemWrite, RegData, Jump, Link, 
             ALUOp, EXTOp, ALUSrcA, ALUSrcB, RegWrite, RegDst, 
             Intr, Inta, ov, mask, Brch, 
             EPCWrite, StaWrite, CauseWrite,
             EPCSelect, StaSelect, CauseSelect, PCSource, cause, 
             Cancel_IF, Cancel_ID, C0RegData, mfc0, mtc0);
  
  input [31:0] Instr;
  input rst;
  input clk;
  input Intr;
  input ov;
  input [3:0] mask;
  input Brch;
  output reg [3:0] PCWriteCond;
  output reg MemRead;
  output reg MemWrite;
  output reg [1:0] RegData;
  output reg [1:0] Jump;
  output reg [1:0] Link;
  output reg [3:0] ALUOp;
  output reg [1:0] EXTOp;
  output reg ALUSrcA;
  output reg ALUSrcB;
  output reg RegWrite;
  output reg RegDst;
  
  output reg Inta;
  output reg EPCWrite;
  output reg StaWrite;
  output reg CauseWrite;
  output reg [1:0] EPCSelect;
  output reg [1:0] StaSelect;
  output reg CauseSelect;
  output reg [1:0] PCSource;
  output reg [1:0] cause;
  output reg Cancel_IF;
  output reg Cancel_ID;
  output reg [1:0] C0RegData;
  output reg mfc0;
  output reg mtc0;
  
  reg intr;
  
  always @ (posedge clk or posedge Intr or posedge rst)
  begin
    if (rst)
	   intr <= 0;
	  else
	    begin
	      if (Intr)
	        intr <= 1'b1;
	      else
	        intr <= Intr;
		end
  end
  
  always @ (*)
  begin
    if (rst)
      begin
        PCWriteCond <= 4'b0000;
        MemRead <= 0;
        MemWrite <= 0;
        RegData <= 2'b00;
        Jump <= 2'b00;
        Link <= 2'b00;
        ALUOp <= 4'b0000;
        EXTOp <= 2'b00;
        ALUSrcA <= 0;
        ALUSrcB <= 0;
        RegWrite <= 0;
        RegDst <= 0;
        Inta <= 0;
        EPCSelect <= 2'b00;
        EPCWrite <= 0; //Write EPC
        cause <= 2'b00;
        CauseSelect <= 0;
        CauseWrite <= 0; //Write ExeCode into Cause Register
        StaSelect <= 2'b00;
        StaWrite <= 0; //Status << 4
        PCSource <= 2'b00;//Write PC
        Cancel_IF <= 0;
        Cancel_ID <= 0;
        C0RegData <= 2'b00; //arbitrary
        mfc0 <= 0;
        mtc0 <= 0;
      end
    else //not reset
      begin
        if (intr & mask[0]) //External Interrupts & enable
          begin
            Inta <= 1;
            C0RegData <= 2'b00; //arbitrary
            PCWriteCond <= 4'b0000;
            MemRead <= 0;
            MemWrite <= 0;
            RegData <= 2'b00;
            Jump <= 2'b00;
            Link <= 2'b00;
            ALUOp <= 4'b0000;
            EXTOp <= 2'b00;
            ALUSrcA <= 0;
            ALUSrcB <= 0;
            RegWrite <= 0;
            RegDst <= 0;
            if ((!Brch) && (Instr[31:26]==`OP_BEQ || Instr[31:26]==`OP_BGEZ || 
            Instr[31:26]==`OP_BGTZ || Instr[31:26]==`OP_BLEZ || 
            Instr[31:26]==`OP_BLTZ || Instr[31:26]==`OP_BNQ)) //prolonged branch
              begin
                EPCSelect <= 2'b00;
                EPCWrite <= 1; //Write EPC
                cause <= `EXC_CODE_INT;
                CauseSelect <= 0;
                CauseWrite <= 1; //Write ExeCode into Cause Register
                StaSelect <= 2'b00;
                StaWrite <= 1; //Status << 4
                PCSource <= 2'b01;//Write PC
                Cancel_IF <= 1;
                Cancel_ID <= 0;
                mfc0 <= 0;
                mtc0 <= 0;
              end
            else
              begin
                EPCSelect <= 2'b01;
                EPCWrite <= 1; //Write EPC
                cause <= `EXC_CODE_INT;
                CauseSelect <= 0;
                CauseWrite <= 1; //Write ExeCode into Cause Register
                StaSelect <= 2'b00;
                StaWrite <= 1; //Status << 4
                PCSource <= 2'b01;//Write PC
                Cancel_IF <= 1;
                Cancel_ID <= 0;
                mfc0 <= 0;
                mtc0 <= 0;
              end
          end
        else if (ov & mask[3]) //overflow
          begin
            Inta <= 0;
            C0RegData <= 2'b00; //arbitrary
            PCWriteCond <= 4'b0000;
            MemRead <= 0;
            MemWrite <= 0;
            RegData <= 2'b00;
            Jump <= 2'b00;
            Link <= 2'b00;
            ALUOp <= 4'b0000;
            EXTOp <= 2'b00;
            ALUSrcA <= 0;
            ALUSrcB <= 0;
            RegWrite <= 0;
            RegDst <= 0;
            EPCSelect <= 2'b10;
            EPCWrite <= 1; //Write EPC
            cause <= `EXC_CODE_OV;
            CauseSelect <= 0;
            CauseWrite <= 1; //Write ExeCode into Cause Register
            StaSelect <= 2'b00;
            StaWrite <= 1; //Status << 4
            PCSource <= 2'b01;//Write PC
            Cancel_IF <= 1;
            Cancel_ID <= 1;
            mfc0 <= 0;
            mtc0 <= 0;
          end
        else //Normal Execution(including NOP, Syscall and unimplemented instructions)
          begin
            Inta <= 0;
            if (Instr[31:0]==32'h0000_0000) //NOP
              begin
                PCWriteCond <= 4'b0000;
                MemRead <= 0;
                MemWrite <= 0;
                RegData <= 2'b00;
                Jump <= 2'b00;
                Link <= 2'b00;
                ALUOp <= `ALUOP_NOP;
                EXTOp <= 2'b00;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                RegWrite <= 0;
                RegDst <= 0;
                EPCSelect <= 2'b00;
                EPCWrite <= 0;
                cause <= 2'b00;
                CauseSelect <= 0;
                CauseWrite <= 0;
                StaSelect <= 2'b00;
                StaWrite <= 0;
                PCSource <= 2'b00;
                Cancel_IF <= 0;
                Cancel_ID <= 0;
                C0RegData <= 2'b00;
                mfc0 <= 0;
                mtc0 <= 0;
              end
            else // not NOP
              begin
                case (Instr[31:26])
        
                /*==================== R-Format ======================*/
        
                  `OP_R:
                    begin
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                      if (Instr[5:0]==6'b001000) //jr
                        begin
                          Jump <= 2'b11;
                          Link <= 2'b00;
                          ALUOp <= `ALUOP_NOP;
                          RegWrite <= 0;
                          RegDst <= 0;//RegDst is arbitrary
                          EPCSelect <= 2'b00;
                          EPCWrite <= 0;
                          cause <= 2'b00;
                          CauseSelect <= 0;
                          CauseWrite <= 0;
                          StaSelect <= 2'b00;
                          StaWrite <= 0;
                          PCSource <= 2'b00;
                          Cancel_IF <= 0;
                          Cancel_ID <= 0;
                        end
                      else if (Instr[5:0]==6'b001001) //jalr
                        begin
                          Jump <= 2'b11;
                          Link <= 2'b10;
                          ALUOp <= `ALUOP_NOP;
                          RegWrite <= 0;
                          RegDst <= 0;//RegDst is arbitrary
                          EPCSelect <= 2'b00;
                          EPCWrite <= 0;
                          cause <= 2'b00;
                          CauseSelect <= 0;
                          CauseWrite <= 0;
                          StaSelect <= 2'b00;
                          StaWrite <= 0;
                          PCSource <= 2'b00;
                          Cancel_IF <= 0;
                          Cancel_ID <= 0;
                        end
                      else if (Instr[5:0]==6'b001100) //Syscall
                        begin
                          Jump <= 2'b00;
                          Link <= 2'b00;
                          ALUOp <= `ALUOP_NOP;
                          RegWrite <= 0;
                          RegDst <= 0;
                          if (mask[1]) //Enabled
                            begin
                              EPCSelect <= 2'b00;
                              EPCWrite <= 1; //Write EPC
                              cause <= `EXC_CODE_SYS;
                              CauseSelect <= 0;
                              CauseWrite <= 1; //Write ExeCode into Cause Register
                              StaSelect <= 2'b00;
                              StaWrite <= 1; //Status << 4
                              PCSource <= 2'b01;//Write PC
                              Cancel_IF <= 1;
                              Cancel_ID <= 0;
                            end
                          else //Disabled
                            begin
                              EPCSelect <= 2'b00;
                              EPCWrite <= 0;
                              cause <= 2'b00;
                              CauseSelect <= 0;
                              CauseWrite <= 0;
                              StaSelect <= 2'b00;
                              StaWrite <= 0;
                              PCSource <= 2'b00;
                              Cancel_IF <= 0;
                              Cancel_ID <= 0;
                            end
                        end
                      else if (!(Instr[5:0]==6'h20 | Instr[5:0]==6'h21 | Instr[5:0]==6'h22 | 
                      Instr[5:0]==6'h23 | Instr[5:0]==6'h2a | Instr[5:0]==6'h2b | Instr[5:0]==6'h1a | 
                      Instr[5:0]==6'h1b | Instr[5:0]==6'h18 | Instr[5:0]==6'h19 | Instr[5:0]==6'h24 | 
                      Instr[5:0]==6'h27 | Instr[5:0]==6'h25 | Instr[5:0]==6'h26 | Instr[5:0]==6'h00 | 
                      Instr[5:0]==6'h04 | Instr[5:0]==6'h02 | Instr[5:0]==6'h03 | Instr[5:0]==6'h07 | 
                      Instr[5:0]==6'h09 | Instr[5:0]==6'h08)) //Unimpl R-type
                        begin
                          Jump <= 2'b00;
                          Link <= 2'b00;
                          ALUOp <= `ALUOP_NOP;
                          RegWrite <= 0;
                          RegDst <= 0;
                          if (mask[2]) //Enabled
                            begin
                              EPCSelect <= 2'b00;
                              EPCWrite <= 1; //Write EPC(ID)
                              cause <= `EXC_CODE_UNIMPL;
                              CauseSelect <= 0;
                              CauseWrite <= 1; //Write ExeCode into Cause Register
                              StaSelect <= 2'b00;
                              StaWrite <= 1; //Status << 4
                              PCSource <= 2'b01;//Write PC
                              Cancel_IF <= 1;
                              Cancel_ID <= 0; 
                            end
                          else
                            begin
                              EPCSelect <= 2'b00;
                              EPCWrite <= 0;
                              cause <= 2'b00;
                              CauseSelect <= 0;
                              CauseWrite <= 0;
                              StaSelect <= 2'b00;
                              StaWrite <= 0;
                              PCSource <= 2'b00;
                              Cancel_IF <= 0;
                              Cancel_ID <= 0;
                            end
                        end
                      else
                        begin
                          Jump <= 2'b00;
                          Link <= 2'b00;
                          ALUOp <= `ALUOP_R;
                          RegWrite <= 1;
                          RegDst <= 1;
                          EPCSelect <= 2'b00;
                          EPCWrite <= 0;
                          cause <= `EXC_CODE_SYS;
                          CauseSelect <= 0;
                          CauseWrite <= 0;
                          StaSelect <= 2'b00;
                          StaWrite <= 0;
                          PCSource <= 2'b00;
                          Cancel_IF <= 0;
                          Cancel_ID <= 0;
                        end
                      if (Instr[5:0]==6'h00 || Instr[5:0]==6'h02 || Instr[5:0]==6'h03)
                        ALUSrcA <= 1; //shift
                      else
                        ALUSrcA <= 0; 
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      EXTOp <= 2'b00;//EXTOp is arbitrary
                      ALUSrcB <= 0;
                    end        
        
                  /*===================== Branch ======================*/
        
                  `OP_BEQ:
                    begin
                      PCWriteCond <= `COND_BEQ;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;//ALUOp is arbitrary
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_BGEZ:
                    begin
                      PCWriteCond <= (Instr[16]==1)?`COND_BGEZ:`COND_BLTZ;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;//ALUOp is arbitrary
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_BGTZ:
                    begin
                      PCWriteCond <= `COND_BGTZ;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;//ALUOp is arbitrary
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_BLEZ:
                    begin
                      PCWriteCond <= `COND_BLEZ;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;//ALUOp is arbitrary
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_BLTZ:
                    begin
                      PCWriteCond <= (Instr[16]==1)?`COND_BGEZ:`COND_BLTZ;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;//ALUOp is arbitrary
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_BNQ:
                    begin
                      PCWriteCond <= `COND_BNQ;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;//ALUOp is arbitrary
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end

                    /*===================== I-Format =====================*/

                  `OP_ADDI:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADDI;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_ADDIU:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADDIU;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_SLTI:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_SLTI;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_SLTIU:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_SLTIU;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_ANDI:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ANDI;
                      EXTOp <= `EXTOP_LOGIC;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_ORI:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ORI;
                      EXTOp <= `EXTOP_LOGIC;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_XORI:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_XORI;
                      EXTOp <= `EXTOP_LOGIC;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_LUI:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_LUI;
                      EXTOp <= `EXTOP_LOGIC;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end

                    /*======================== S&L ==========================*/

                  `OP_LB:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 1;
                      MemWrite <= 0;
                      RegData <= 2'b01;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_LBU:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 1;
                      MemWrite <= 0;
                      RegData <= 2'b01;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_LH:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 1;
                      MemWrite <= 0;
                      RegData <= 2'b01;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_LHU:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 1;
                      MemWrite <= 0;
                      RegData <= 2'b01;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_LW:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 1;
                      MemWrite <= 0;
                      RegData <= 2'b01;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 1;
                      RegDst <= 0;
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_SB:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 1;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_SH:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 1;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_SW:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 1;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_ADD;
                      EXTOp <= `EXTOP_ARITH;
                      ALUSrcA <= 0;
                      ALUSrcB <= 1;
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end

                    /*======================= Jump =========================*/

                  `OP_J:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b01;
                      Link <= 2'b00;
                      ALUOp <= `ALUOP_NOP;
                      EXTOp <= 2'b00;//EXTOp is arbitrary
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_JAL:
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;//RegData is arbitrary
                      Jump <= 2'b01;
                      Link <= 2'b01;
                      ALUOp <= `ALUOP_NOP;
                      EXTOp <= 2'b00;//EXTOp is arbitrary
                      ALUSrcA <= 0;//ALUSrcA is arbitrary
                      ALUSrcB <= 0;//ALUSrcB is arbitrary
                      RegWrite <= 0;
                      RegDst <= 0;//RegDst is arbitrary
                      EPCSelect <= 2'b00;
                      EPCWrite <= 0;
                      cause <= 2'b00;
                      CauseSelect <= 0;
                      CauseWrite <= 0;
                      StaSelect <= 2'b00;
                      StaWrite <= 0;
                      PCSource <= 2'b00;
                      Cancel_IF <= 0;
                      Cancel_ID <= 0;
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
        
                  `OP_INTR: //mfc0, mtc0, eret
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;
                      EXTOp <= 2'b00;
                      ALUSrcA <= 0;
                      ALUSrcB <= 0;
                      if (Instr[25:21]==5'h00) //mfc0 
                        begin
                          RegData <= 2'b10;
                          RegWrite <= 1;
                          RegDst <= 0; //rt
                          EPCSelect <= 2'b00;
                          EPCWrite <= 0;
                          cause <= `EXC_CODE_UNIMPL;//arbitrary
                          CauseSelect <= 0;
                          CauseWrite <= 0;
                          StaSelect <= 2'b00;
                          StaWrite <= 0;
                          PCSource <= 2'b00;
                          Cancel_IF <= 0;
                          Cancel_ID <= 0;
                          mfc0 <= 1;
                          mtc0 <= 0;
                          case(Instr[15:11])
                            5'd12: C0RegData <= 2'b10; //status
                            5'd13: C0RegData <= 2'b01; //cause
                            5'd14: C0RegData <= 2'b00; //epc
                            default: C0RegData <= 2'b00; //arbitrary
                          endcase
                        end
                      else if(Instr[25:21]==5'h04) //mtc0
                        begin
                          RegData <= 2'b00;//arbitrary
                          RegWrite <= 0;//arbitrary
                          RegDst <= 0; //arbitrary
                          EPCSelect <= 2'b11;
                          EPCWrite <= (Instr[15:11]==5'd14)? 1'b1 : 1'b0;
                          cause <= `EXC_CODE_UNIMPL;//arbitrary
                          CauseSelect <= 1;
                          CauseWrite <= (Instr[15:11]==5'd13)? 1'b1 : 1'b0;
                          StaSelect <= 2'b10;
                          StaWrite <= (Instr[15:11]==5'd12)? 1'b1 : 1'b0;
                          PCSource <= 2'b00;
                          Cancel_IF <= 0;
                          Cancel_ID <= 1; //mtc0 only needs 2 stages. 
                                      //Flush mtc0 itself to eliminate forwarding problems.
                          C0RegData <= 2'b00;
                          mfc0 <= 0;
                          mtc0 <= 1;
                        end
                      else if(Instr[25:21]==5'h10) //eret
                        begin
                          RegData <= 2'b00;
                          RegWrite <= 0;
                          RegDst <= 0;
                          EPCSelect <= 2'b00;
                          EPCWrite <= 0;
                          cause <= `EXC_CODE_UNIMPL;//arbitrary
                          CauseSelect <= 0;
                          CauseWrite <= 0;
                          StaSelect <= 2'b01; //status >> 4
                          StaWrite <= 1;
                          PCSource <= 2'b10;
                          Cancel_IF <= 1;
                          Cancel_ID <= 0;
                          C0RegData <= 2'b00;
                          mfc0 <= 0;
                          mtc0 <= 0;
                        end
                      else
                        begin
                          RegData <= 2'b00;
                          RegWrite <= 0;
                          RegDst <= 0;
                          C0RegData <= 2'b00;
                          mfc0 <= 0;
                          mtc0 <= 0;
                          if (mask[2])
                            begin
                              EPCSelect <= 2'b00;
                              EPCWrite <= 1; //Write EPC(ID)
                              cause <= `EXC_CODE_UNIMPL;
                              CauseSelect <= 0;
                              CauseWrite <= 1; //Write ExeCode into Cause Register
                              StaSelect <= 2'b00;
                              StaWrite <= 1; //Status << 4
                              PCSource <= 2'b01;//Write PC
                              Cancel_IF <= 1;
                              Cancel_ID <= 0;
                            end
                          else
                            begin
                              EPCSelect <= 2'b00;
                              EPCWrite <= 0; //Write EPC(ID)
                              cause <= `EXC_CODE_UNIMPL;
                              CauseSelect <= 0;
                              CauseWrite <= 0; //Write ExeCode into Cause Register
                              StaSelect <= 2'b00;
                              StaWrite <= 0; //Status << 4
                              PCSource <= 2'b00;//Write PC
                              Cancel_IF <= 0;
                              Cancel_ID <= 0;
                            end
                        end
                    end
      
                  default: //Unimpl
                    begin
                      PCWriteCond <= 4'b0000;
                      MemRead <= 0;
                      MemWrite <= 0;
                      RegData <= 2'b00;
                      Jump <= 2'b00;
                      Link <= 2'b00;
                      ALUOp <= 4'b0000;
                      EXTOp <= 2'b00;
                      ALUSrcA <= 0;
                      ALUSrcB <= 0;
                      RegWrite <= 0;
                      RegDst <= 0;
                      if (mask[2])
                        begin
                          EPCSelect <= 2'b00;
                          EPCWrite <= 1; //Write EPC(ID)
                          cause <= `EXC_CODE_UNIMPL;
                          CauseSelect <= 0;
                          CauseWrite <= 1; //Write ExeCode into Cause Register
                          StaSelect <= 2'b00;
                          StaWrite <= 1; //Status << 4
                          PCSource <= 2'b01;//Write PC
                          Cancel_IF <= 1;
                          Cancel_ID <= 0;
                        end
                      else
                        begin
                          EPCSelect <= 2'b00;
                          EPCWrite <= 0; //Write EPC(ID)
                          cause <= `EXC_CODE_UNIMPL;
                          CauseSelect <= 0;
                          CauseWrite <= 0; //Write ExeCode into Cause Register
                          StaSelect <= 2'b00;
                          StaWrite <= 0; //Status << 4
                          PCSource <= 2'b00;//Write PC
                          Cancel_IF <= 0;
                          Cancel_ID <= 0;
                        end
                      C0RegData <= 2'b00;
                      mfc0 <= 0;
                      mtc0 <= 0;
                    end
      
                endcase
               end
          end
      end
  end  

endmodule
