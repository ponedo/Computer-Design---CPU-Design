module EPC(data_in, data_out, rst, clk, EPCWrite);
  
  input [31:0] data_in;
  input rst;
  input clk;
  input EPCWrite;
  output reg [31:0] data_out;
  
  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      data_out <= 32'h0000_0000;
    else
      begin
        if (EPCWrite)
          data_out <= data_in;
      end
  end 
  
endmodule