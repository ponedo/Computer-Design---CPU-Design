module RF (ra0_i, ra1_i, wa_i, wd_i, LinkAddr, LinkData, 
           clk, RegWrite, Link, rst, 
           rd0_o, rd1_o);
		
		input [4:0] ra0_i;  //rs ,read address 0
  		input [4:0] ra1_i;  //rt ,read address 1
  		input [4:0] wa_i;  //rt or rd , write address
  		input [31:0] wd_i;  //write  data
  		input [4:0] LinkAddr; // Address for link_instruction (PC+4)
  		input [31:0] LinkData; // PC+4
  		input clk;  //clock
  		input RegWrite;  //Write signal form Control unit
  		input [1:0] Link;
  		input rst;  //reset @ negedge clk
  		output [31:0] rd0_o;  //rs,read data
  		output [31:0] rd1_o;  //rt,read data
		
    reg[31:0] RegFile[31:0];
    integer i;
	 
    /*
    $zero,  //RegisterNumber 0, The constant value 0
    $v0, $v1,  //RegisterNumber 2-3, Values for results and expression evalution
    $a0, $a1, $a2, $a3,  //RegisterNumber 4-7, Arguments
    $t0, $t1, $t2, $t3, $t4, $t5, $t6, $t7,  //RegisterNumber 8-15, Temporaries
    $s0, $s1, $s2, $s3, $s4, $s5, $s6, $s7,  //RegisterNumber 16-23, Saved
    $t8, $t9,  //RegisterNumber 24-25, More temporaries
    $gp,  //RegisterNumber 28, Global pointer
    $sp,  //RegisterNumber 29, Stack pointer
    $fp,  //RegisterNumber 30, Frame pointer
    $ra;  //RegisterNumber 31, Return address
    $at  //RegisterNumber 1, Reserved for assembler
    $k0, $k1  //RegisterNumber 26-27, reserved for os
    */
    
    assign rd0_o = RegFile[ra0_i];
    assign rd1_o = RegFile[ra1_i];
        
    always @(negedge clk or posedge rst)
    begin
      if (rst)
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
          if (RegWrite && (wa_i!=0)) RegFile[wa_i] <= wd_i;
          if (Link==2'b01) RegFile[31] <= LinkData;
          if (Link==2'b10) RegFile[LinkAddr] <= LinkData; 
        end
    end

endmodule