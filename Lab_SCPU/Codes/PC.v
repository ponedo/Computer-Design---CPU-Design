
module PC(PCRst, Jump, Brch, clk, jump_addr, brch_addr, pc);
  
  input PCRst;
  input Jump;
  input Brch;
  input clk;
  input [25:0] jump_addr;
  input [31:0] brch_addr; 
  output reg [31:0] pc;
  
  wire [31:0] Added;
  wire [31:0] ALUresult;
  wire [31:0] pc_added;
  wire [31:0] pc_next;
  
  assign pc_added=pc+4;
  
  mux mux1(pc_added, pc_added+ {brch_addr[29:0], 2'b00}, Brch, ALUresult);
  mux mux2(ALUresult, {pc[31:28],jump_addr,2'b00}, Jump, pc_next);
  
  always @(posedge clk or posedge PCRst)
  begin
    if (PCRst)
      begin
        pc <= 32'h0000_3000;
      end
    else
      begin
        pc <= pc_next;
      end
  end
  
endmodule