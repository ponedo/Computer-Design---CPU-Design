module SCPU(  
   	input clk,			//
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
  
  wire RegDst;
  wire Jump;
  wire Branch;
  wire MemRead;
  wire MemtoReg;
  wire [1:0] ALUOp;
  wire [1:0] EXTOp;
  wire MemWrite;
  wire ALUSrc;
  wire [31:0] ALUSrc2;
  wire RegWrite;
  wire [31:0] EXTresult;
  wire [31:0] RFReadData1;
  wire [31:0] RFReadData2;
  wire [63:0] ALUresult;
  wire [31:0] PreRFWriteData;
  wire [31:0] RFWriteData;
  wire [4:0] PreRFWriteAddr;
  wire [4:0] RFWriteAddr;
  wire Zero;
  wire [4:0] ALUCtrl;
  wire [5:0] Instr_ALUCtrl;
  wire BrchAndZero;
  wire RaWrite;
  
  assign mem_w = MemWrite;
  assign Addr_out = ALUresult[31:0];
  assign Data_out = RFReadData2;
  
  PC pc(reset, Jump, BrchAndZero, clk, inst_in[25:0], EXTresult, PC_out);
  RF rf(inst_in[25:21], inst_in[20:16], RFWriteAddr, RFWriteData, clk, RegWrite, reset, RFReadData1, RFReadData2);
  EXT ext(inst_in[15:0], EXTOp, EXTresult);
  ALU alu(ALUCtrl, RFReadData1, ALUSrc2, ALUresult, Zero);
  ctrl control(reset, inst_in[31:26], ALUSrc, RegWrite, MemRead, MemWrite, MemtoReg, EXTOp, ALUOp, Jump, Branch, RegDst);
  ALUCtrl aluctrl(ALUOp, Instr_ALUCtrl, ALUCtrl);
  AND BrchZero(Branch, Zero, BrchAndZero);
  AND OPJUMP(inst_in[26], Jump, RaWrite);
  mux mux_ALUSrc(RFReadData2, EXTresult, ALUSrc, ALUSrc2);
  mux mux_MemtoReg(ALUresult[31:0], Data_in, MemtoReg, PreRFWriteData);
  mux mux_RFWriteData(PreRFWriteData, (PC_out + 4), RaWrite, RFWriteData);
  mux #(5) mux_RegDst(inst_in[20:16], inst_in[15:11], RegDst, PreRFWriteAddr);
  mux #(6) mux_IorR(inst_in[5:0], inst_in[31:26], ALUOp[0], Instr_ALUCtrl);
  mux #(5) mux_RFWriteAddr(PreRFWriteAddr, 5'b11111, RaWrite, RFWriteAddr);
  
endmodule

