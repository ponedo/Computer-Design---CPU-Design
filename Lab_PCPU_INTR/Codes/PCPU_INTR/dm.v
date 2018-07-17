module DM(addr, Be, U, din, DMRead, DMWr, clk, dout);
  
  input [31:2] addr;
  input U;
  input [3:0] Be; //byte enables
  input [31:0] din; //32-bit input data
  input DMRead;
  input DMWr;
  input clk;
  output reg [31:0] dout;
  
  reg [31:0] dm [23:0];
  
  always @(*)
  begin
    if (DMRead)
      begin
      if (U==1)
        begin
          case (Be)
            4'b0001: dout <= { 24'h00_0000 , dm[addr][7:0] };
            4'b0010: dout <= { 24'h00_0000 , dm[addr][15:8] };
            4'b0100: dout <= { 24'h00_0000 , dm[addr][23:16] };
            4'b1000: dout <= { 24'h00_0000 , dm[addr][31:24] };
            4'b0011: dout <= { 16'h0000 , dm[addr][15:0] };
            4'b1100: dout <= { 16'h0000 , dm[addr][31:16] };
            4'b1111: dout <= dm[addr];
          endcase
        end
      else
        begin
          case (Be)
            4'b0001: dout <= dm[addr][7]==1 ? { 24'hff_ffff , dm[addr][7:0] } : { 24'h00_0000 , dm[addr][7:0] };
            4'b0010: dout <= dm[addr][15]==1 ? { 24'hff_ffff , dm[addr][15:7] } : { 24'h00_0000 , dm[addr][15:7] };
            4'b0100: dout <= dm[addr][23]==1 ? { 24'hff_ffff , dm[addr][23:16] } : { 24'h00_0000 , dm[addr][23:16] };
            4'b1000: dout <= dm[addr][31]==1 ? { 24'hff_ffff , dm[addr][31:24] } : { 24'h00_0000 , dm[addr][31:24] };
            4'b0011: dout <= dm[addr][15]==1 ? { 16'hffff , dm[addr][15:0] } : { 16'h0000 , dm[addr][15:0] };
            4'b1100: dout <= dm[addr][31]==1 ? { 16'hffff , dm[addr][31:16] } : { 16'h0000 , dm[addr][31:16] };
            4'b1111: dout <= dm[addr];
          endcase
        end
      end
  end    
  
  //Write
  always @(posedge clk)
  begin
    if (DMWr)
      begin
        case (Be)
          4'b0001: dm[addr][7:0] <= din[7:0];
          4'b0010: dm[addr][15:8] <= din[7:0];
          4'b0100: dm[addr][23:16] <= din[7:0];
          4'b1000: dm[addr][31:24] <= din[7:0];
          4'b0011: dm[addr][15:0] <= din[15:0];
          4'b1100: dm[addr][31:16] <= din[15:0];
          4'b1111: dm[addr][31:0] <= din[31:0];
        endcase
     end
  end
  
endmodule