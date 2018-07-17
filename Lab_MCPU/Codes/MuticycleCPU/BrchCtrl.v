`include "./Brch_defines.v"
module BrchCtrl(PCWriteCond, sign, zero, Instr_16, Brch);
  
  input [3:0] PCWriteCond;
  input sign;
  input zero;
  input Instr_16;
  output reg Brch;
  
  always @(*)
  begin
    case(PCWriteCond)
      `COND_BEQ: Brch <= zero;
      `COND_1: Brch <= sign ^ Instr_16;
      `COND_BGTZ: Brch <= ~(zero | sign);
      `COND_BLEZ: Brch <= sign | zero;
      `COND_BNQ: Brch <= ~zero;
      default: Brch <= 0;
    endcase
  end
endmodule
