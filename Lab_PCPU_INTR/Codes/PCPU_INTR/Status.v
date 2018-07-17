module Status(data_in, data_out, rst, clk, StaWrite);
  
  /*
  *[31:8] Unused
  *[7:4] S
  *[3:0] INTR Mask
  */
  
  input [31:0] data_in;
  input rst;
  input clk;
  input StaWrite;
  output reg [31:0] data_out;
  
  always @ (posedge clk or posedge rst)
  begin
    if (rst)
      data_out <= 32'h0000_000f; //Enable
    else
      begin
        if(StaWrite)
          data_out <= data_in;
      end
  end
  
endmodule
