
module mux_4(d0, d1, d2, d3, s, q);
  
  parameter bit=1;
  
  input [bit-1:0] d0;
  input [bit-1:0] d1;
  input [bit-1:0] d2;
  input [bit-1:0] d3;
  input [1:0] s;
  output reg [bit-1:0] q;
  
  always @ (*)
  begin
    case (s)
      2'b00: q <= d0;
      2'b01: q <= d1;
      2'b10: q <= d2;
      2'b11: q <= d3;
    endcase
  end
  
endmodule