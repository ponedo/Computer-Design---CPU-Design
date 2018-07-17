module mux_2(d0, d1, s, y);
  parameter inputwidth=32;
  input [inputwidth-1:0] d0;
  input [inputwidth-1:0] d1;
  input s;
  output reg [inputwidth-1:0] y;
  
  always @ (*)
  begin
    case (s)
      0: y<=d0;
      1: y<=d1;
    endcase
  end
  
endmodule