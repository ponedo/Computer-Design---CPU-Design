
module mux_2(d0, d1, s, q);
  
  parameter bit=1;
  
  input [bit-1:0] d0;
  input [bit-1:0] d1;
  input s;
  output reg [bit-1:0] q;
  
  always @ (*)
  begin
    case (s)
      0: q <= d0;
      1: q <= d1;
    endcase
  end
  
endmodule