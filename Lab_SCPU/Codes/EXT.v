`include "./EXT_defines.v"
module EXT(data_16, EXTOp, data_32);
  input [15:0] data_16;
  input [1:0] EXTOp;
  output reg [31:0] data_32;
  
  always @ (*)
  begin
    case (EXTOp)
      `EXTOP_LOGIC:
        data_32 <= { 16'h0000 , data_16 };
      `EXTOP_ARITH:
        if (data_16[15]==1)
          data_32 <= { 16'hffff , data_16};
        else
          data_32 <= { 16'h0000 , data_16};
      `EXTOP_HIGHER_16:
        data_32 <= { data_16 , 16'h0000 };
       default:
         data_32 <= { 16'h0000 , data_16 };
    endcase
  end
  
endmodule