module RAM_B (
  input [9:0] addra,
  input wea,
  input [31:0] dina,
  input clka,
  output [31:0] douta
  );
  
  reg [31:0] Mem_unit [31:0];
  
  assign douta = Mem_unit[addra];
  
  always @ (posedge clka)
  begin
    if (wea)
      Mem_unit[addra] <= dina;
  end

endmodule