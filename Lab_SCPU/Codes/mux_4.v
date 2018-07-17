
module mux_4(d0, d1, d2, d3, s, y);
  parameter inputwidth=32;
  input [inputwidth-1:0] d0;
  input [inputwidth-1:0] d1;
  input [inputwidth-1:0] d2;
  input [inputwidth-1:0] d3;
  input [1:0] s;
  output reg [inputwidth-1:0] y;
  
  always @ (*)
  begin
    case (s)
      2'b00: y<=d0;
      2'b01: y<=d1;
      2'b10: y<=d2;
      2'b11: y<=d3;
    endcase
  end
  
endmodule