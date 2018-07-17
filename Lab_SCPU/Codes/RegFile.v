
module RF(
		input [4:0]ra0_i,  //rs ,read address 0
  		input [4:0]ra1_i,  //rt ,read address 1
  		input [4:0]wa_i,  //rt or rd , write address
  		input [31:0]wd_i,  //write  data
  		input clk,  //clock
  		input regwrite_i,  //Write signal form Control unit
  		input rst_n,  //reset @ negedge clk
  		output [31:0]rd0_o,  //rs,read data
  		output [31:0]rd1_o   //rt,read data
  	);
    
    reg[31:0] RegFile[31:0];
    integer i;
    
    assign rd0_o = RegFile[ra0_i];
    assign rd1_o = RegFile[ra1_i];

    always @(posedge clk or posedge rst_n)
    begin
      if (rst_n)
        begin
          for (i=0; i<32; i=i+1)
          begin
            if (i==28)
              RegFile[i] <= 32'h0000_1800;
            else if (i==29)
              RegFile[i] <= 32'h0000_2ffc;
            else
              RegFile[i] <= 32'h0000_0000;
          end
        end
      else
        begin
          if (regwrite_i && (wa_i!=0))
            RegFile[wa_i] <= wd_i;
        end
    end

endmodule