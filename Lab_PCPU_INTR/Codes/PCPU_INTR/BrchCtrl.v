`include "./Brch_defines.v"
module BrchCtrl(PCWriteCond, Stall, Rs, Rt, Brch);
  
  input [3:0] PCWriteCond;
  input Stall;
  input [31:0] Rs;
  input [31:0] Rt;
  output reg Brch;
  
  wire zero;
  
  assign zero = (Rs==32'h0000_0000) ? 1 : 0;
 
  always @(*)
  begin
    if (!Stall)
      begin
      case(PCWriteCond)
        `COND_BEQ: Brch <= (Rs == Rt) ? 1'b1 : 1'b0;
        `COND_BGEZ: Brch <= ~Rs[31];
        `COND_BGTZ: Brch <= ~(zero | Rs[31]);
        `COND_BLEZ: Brch <= Rs[31] | zero;
        `COND_BLTZ: Brch <= Rs[31];
        `COND_BNQ: Brch <= (Rs == Rt) ? 1'b0 : 1'b1;
        default: Brch <= 0;
      endcase
      end
	 else
	   Brch <= 0;
  end
endmodule
