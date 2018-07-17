`include "./Instr_defines.v"
module BE (op, addr, Be, U);
  
  input [31:26] op;
  input [1:0] addr;
  output reg [3:0] Be;
  output reg U;
  
  always @(*)
  begin
    if (op==`OP_LBU || op==`OP_LHU)
      U<=1;
    else
      U<=0;
      
    case (op)
      `OP_SB,
      `OP_LB,
      `OP_LBU:
      begin
        case (addr)
          2'b00: Be<=4'b0001;
          2'b01: Be<=4'b0010;
          2'b10: Be<=4'b0100;
          2'b11: Be<=4'b1000;
        endcase
      end
      `OP_SH,
      `OP_LH,
      `OP_LHU:
      begin
        case (addr)
          2'b00,
          2'b01:
            Be<=4'b0011;
          2'b10,
          2'b11:
            Be<=4'b1100;
        endcase
      end
      `OP_SW,
      `OP_LW:
        Be <= 4'b1111;
    endcase
  end
  
endmodule
