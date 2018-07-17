module BE (op, addr, be);
  
  input [31:26] op;
  input [1:0] addr;
  output reg [3:0] be;
  
  always @(*)
  begin
    case (op)
      //sb
      6'h28:
      begin
        case (addr)
          2'b00: be<=4'b0001;
          2'b01: be<=4'b0010;
          2'b10: be<=4'b0100;
          2'b11: be<=4'b1000;
        endcase
      end
      //sh
      6'h29:
      begin
        case (addr)
          2'b00,
          2'b01:
            be<=4'b0011;
          2'b10,
          2'b11:
            be<=4'b1100;
        endcase
      end
      //sw
      6'h2b:
        be <= 4'b1111;
    endcase
  end
  
endmodule
