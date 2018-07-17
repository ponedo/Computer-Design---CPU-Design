module PCPU(  
   	input clk,
	  input reset,
		input MIO_ready,
		input [31:0]inst_in,
		input [31:0]Data_in,								
		output mem_w,
		output[31:0]PC_out,
		output[31:0]Addr_out,
		output[31:0]Data_out, 
		output CPU_MIO,
		input INT
		);
  
  /*Wires*/
  wire [31:0] pc_next;
  wire [31:0] pre_pc_next;
  wire [31:0] pc_4_ID;
  
  wire [31:0] Instr_ID;
  wire [31:0] ReadData1_ID;
  wire [31:0] ReadData2_ID;
  wire [31:0] Imm_ID;
  wire [31:0] CmpA_wire;
  wire [31:0] CmpB_wire;
  
  wire [5:0] Op_EX;
  wire [31:0] ReadData1_EX;
  wire [31:0] ReadData2_EX;
  wire [4:0] Shamt_EX;
  wire [31:0] Imm_EX;
  wire [5:0] Funct_EX;
  wire [4:0] Rs_EX;
  wire [4:0] Rt_EX;
  wire [4:0] Rd_EX;
  wire [31:0] pre_ALU_A;
  wire [31:0] pre_ALU_B;
  wire [31:0] ALU_A;
  wire [31:0] ALU_B;
  wire [63:0] ALUResult_EX;
  wire [4:0] Rd_real_EX;
  
  wire [5:0] Op_MEM;
  wire [31:0] ALUResult_MEM;
  wire [31:0] Data_MEM;
  wire [4:0] Rd_MEM;
  wire [31:0] MemData_MEM;
  
  wire [31:0] ALUResult_WB;
  wire [31:0] MemData_WB;
  wire [4:0] Rd_WB;
  
  wire [31:0] WriteData;
  
  
  

  /*Signals*/
  wire MemRead;
  wire MemWrite;
  wire RegData; 
  wire [3:0] ALUOp;
  wire ALUSrcA;
  wire ALUSrcB;
  wire RegWrite;
  wire RegDst;
  wire RegWrite_ID;
  wire RegData_ID;
  wire MemRead_ID;
  wire MemWrite_ID;
  wire ALUSrcA_ID;
  wire ALUSrcB_ID;
  wire [3:0] ALUOp_ID;
  wire RegDst_ID;
  wire [1:0] EXTOp;
  wire [3:0] PCWriteCond;
  wire [1:0] Jump;
  wire [1:0] Link;
  wire Stall;
  wire PCWrite;
  wire IF_IDWrite;
  wire Brch;
  wire [1:0] Jmp;
  wire [1:0] CmpA;
  wire [1:0] CmpB;
  wire RegWrite_EX;
  wire RegData_EX;
  wire MemRead_EX;
  wire MemWrite_EX;
  wire ALUSrcA_EX;
  wire ALUSrcB_EX;
  wire [3:0] ALUOp_EX;
  wire RegDst_EX;
  wire [1:0] ForwardA;
  wire [1:0] ForwardB;
  wire [4:0] ALUCtrl;
  wire RegWrite_MEM;
  wire RegData_MEM;
  wire MemRead_MEM;
  wire MemWrite_MEM;
  wire [3:0] Be;
  wire U;
  wire RegWrite_WB;
  wire RegData_WB;
  
  assign mem_w = MemWrite_MEM;
  assign Addr_out = ALUResult_MEM;
  assign MemData_MEM = Data_in;
  assign Data_out = Data_MEM;
  
  /*Datapath*/
  //IM im(PC_out[31:2], inst_in);
  PC pc(pc_next, PC_out, reset, clk, PCWrite);
  
  RF rf(Instr_ID[25:21], Instr_ID[20:16], Rd_WB, WriteData, Instr_ID[15:11], pc_4_ID, 
           clk, RegWrite_WB, Link, reset, ReadData1_ID, ReadData2_ID);
  EXT ext(Instr_ID[15:0], EXTOp, Imm_ID);
  
  ALU alu(ALUCtrl, ALU_A, ALU_B, ALUResult_EX, zero, sign);
  
  BE be(Op_MEM, ALUResult_MEM[1:0], Be, U);
  //DM dm(ALUResult_MEM[31:2], Be, U, Data_MEM, MemRead_MEM, MemWrite_MEM, clk, MemData_MEM);
  
  /*Floprs*/
  IF_ID if_id(inst_in, (PC_out + 4), Instr_ID, pc_4_ID, clk, reset, IF_IDWrite, (Brch | Jmp[0]));
  ID_EX id_ex(RegWrite_ID, RegWrite_EX, RegData_ID, RegData_EX, MemRead_ID, MemRead_EX, 
              MemWrite_ID, MemWrite_EX, ALUSrcA_ID, ALUSrcA_EX, ALUSrcB_ID, ALUSrcB_EX,
              ALUOp_ID, ALUOp_EX, RegDst_ID, RegDst_EX, Instr_ID[31:26], Op_EX,
              ReadData1_ID, ReadData1_EX, ReadData2_ID, ReadData2_EX,
              Instr_ID[10:6], Shamt_EX, Imm_ID, Imm_EX, Instr_ID[5:0], Funct_EX,
              Instr_ID[25:21], Rs_EX, Instr_ID[20:16], Rt_EX, Instr_ID[15:11], Rd_EX,
              clk, reset);
  EX_MEM ex_mem
             (RegWrite_EX, RegWrite_MEM, RegData_EX, RegData_MEM, 
              MemRead_EX, MemRead_MEM, MemWrite_EX, MemWrite_MEM,
              Op_EX, Op_MEM, ALUResult_EX[31:0], ALUResult_MEM,
              pre_ALU_B, Data_MEM, Rd_real_EX, Rd_MEM,
              clk, reset);
  MEM_WB mem_wb
             (RegWrite_MEM, RegWrite_WB, 
              RegData_MEM, RegData_WB, 
              ALUResult_MEM, ALUResult_WB,
              MemData_MEM, MemData_WB,
              Rd_MEM, Rd_WB,
              clk, reset);
  
  /*Mutiplexors*/
  mux_2 #32 branch((PC_out + 4), (pc_4_ID + (Imm_ID << 2)), Brch, pre_pc_next);
  mux_4 #32 jump(pre_pc_next,{ pc_4_ID[31:28] , Instr_ID[25:0] , 2'b00}, 0, CmpA_wire, Jmp, pc_next);
  
  mux_4 #32 cmpA(ReadData1_ID, WriteData, ALUResult_MEM, 32'h0000_0000, CmpA, CmpA_wire);
  mux_4 #32 cmpB(ReadData2_ID, WriteData, ALUResult_MEM, 32'h0000_0000, CmpB, CmpB_wire);
  mux_2 #1 mr_stall(MemRead, 1'b0, Stall, MemRead_ID);
  mux_2 #1 mw_stall(MemWrite, 1'b0, Stall, MemWrite_ID);
  mux_2 #1 rdata_stall(RegData, 1'b0, Stall, RegData_ID);
  mux_2 #4 aluop_stall(ALUOp, 4'b0000, Stall, ALUOp_ID);
  mux_2 #1 aluA_stall(ALUSrcA, 1'b0, Stall, ALUSrcA_ID);
  mux_2 #1 aluB_stall(ALUSrcB, 1'b0, Stall, ALUSrcB_ID);
  mux_2 #1 rw_stall(RegWrite, 1'b0, Stall, RegWrite_ID);
  mux_2 #1 rdst_stall(RegDst, 1'b0, Stall, RegDst_ID);
  
  mux_4 #32 forwardA(ReadData1_EX, WriteData, ALUResult_MEM, 0, ForwardA, pre_ALU_A);
  mux_4 #32 forwardB(ReadData2_EX, WriteData, ALUResult_MEM, 0, ForwardB, pre_ALU_B);
  mux_2 #32 shift(pre_ALU_A, { 27'h000_0000 , Shamt_EX }, ALUSrcA_EX, ALU_A);
  mux_2 #32 imm(pre_ALU_B, Imm_EX, ALUSrcB_EX, ALU_B);
  mux_2 #5 rdst(Rt_EX, Rd_EX, RegDst_EX, Rd_real_EX);
  
  mux_2 #32 rdata(ALUResult_WB, MemData_WB, RegData_WB, WriteData);
  
  
  /*Control*/
  Hazard_detection_unit hdu
           (MemRead_EX, MemRead_MEM, RegWrite_EX, 
            PCWriteCond, Jump, 
            Rd_real_EX, Rd_MEM, Instr_ID[25:21], Instr_ID[20:16], 
            Stall, PCWrite, IF_IDWrite);
  Ctrl ctrl(Instr_ID[31:26], reset, clk,
            Instr_ID[16], Instr_ID[5:0], 
            PCWriteCond, MemRead, MemWrite, RegData, Jump, Link, 
            ALUOp, EXTOp, ALUSrcA, ALUSrcB, RegWrite, RegDst);
  BrchCtrl brchctrl(PCWriteCond, Stall, CmpA_wire, CmpB_wire, Brch);
  assign Jmp = Stall ? 2'b00 : Jump;
  
  ALUCtrl aluctrl(ALUOp_EX, Funct_EX, ALUCtrl);
  Forwarding_unit fwdu
           (Rs_EX, Rt_EX, Instr_ID[25:21], Instr_ID[20:16], 
            Rd_MEM, Rd_WB, PCWriteCond, Jump, RegWrite_MEM, RegWrite_WB, 
            ForwardA, ForwardB, CmpA, CmpB);
  
  
endmodule

