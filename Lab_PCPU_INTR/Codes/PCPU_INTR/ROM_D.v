module ROM_D (
  input [9:0] a,
  output [31:0] spo
  );
  
  reg [31:0] Mem_unit [79:0];
  
  assign spo = Mem_unit[a];
  
endmodule
