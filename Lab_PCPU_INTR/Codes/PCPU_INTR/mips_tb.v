module mips_tb();
  `timescale 1ns/1ps
  
  reg clk;
  reg rst;
  reg [31:0] queue [4:0];
  
  integer i;
  integer pointer;
  
  MIPS mips(clk, rst);
  
  initial
    begin
      pointer=0;
      $readmemh("test.txt", mips.im.im, 12'hc00);
      clk=1;
      rst=1;
      #1 rst=0;
      #1 rst=1;
      $display("Instrction load complete, IM is as follow:");
      for (i=12'hc00; i<12'hc80; i=i+1)
        $display("%x", mips.im.im[i]);
      $display("=============================================================================================");
    end
    
  always 
    begin
      #5 clk <= ~clk;
    end
    
  always @ (posedge clk)
    begin
      $display("Currently Fetching: Instruction at: \n  %x", mips.pc_out);
      if (mips.Stall==1)
      begin
        queue[pointer]=queue[(pointer+4)%5];
        queue[(pointer+4)%5]=32'h0000_0000;
      end
      else queue[pointer]=mips.pc_out;
      if ((mips.Brch | mips.Jmp[0])==1) queue[pointer]=32'h0000_0000;
      $display("---------------------------------------------------------------------------------------------");
      $display("Currently Queue:\n  %x  %x  %x  %x  %x", queue[pointer], queue[(pointer+4)%5], queue[(pointer+3)%5], queue[(pointer+2)%5], queue[(pointer+1)%5]);
      pointer=(pointer+1)%5;
      $display("---------------------------------------------------------------------------------------------");
      $display("End of Cycle!");
      $display("Register Files:\nRF[0-7]:\t%x  %x  %x  %x  %x  %x  %x  %x\nRF[8-15]:\t%x  %x  %x  %x  %x  %x  %x  %x\nRF[16-23]:\t%x  %x  %x  %x  %x  %x  %x  %x\nRF[24-31]:\t%x  %x  %x  %x  %x  %x  %x  %x\n=============================================================================================",
                mips.rf.RegFile[0], mips.rf.RegFile[1], mips.rf.RegFile[2], mips.rf.RegFile[3],
                mips.rf.RegFile[4], mips.rf.RegFile[5], mips.rf.RegFile[6], mips.rf.RegFile[7],
                mips.rf.RegFile[8], mips.rf.RegFile[9], mips.rf.RegFile[10], mips.rf.RegFile[11],
                mips.rf.RegFile[12], mips.rf.RegFile[13], mips.rf.RegFile[14], mips.rf.RegFile[15],
                mips.rf.RegFile[16], mips.rf.RegFile[17], mips.rf.RegFile[18], mips.rf.RegFile[19],
                mips.rf.RegFile[20], mips.rf.RegFile[21], mips.rf.RegFile[22], mips.rf.RegFile[23],
                mips.rf.RegFile[24], mips.rf.RegFile[25], mips.rf.RegFile[26], mips.rf.RegFile[27],
                mips.rf.RegFile[28], mips.rf.RegFile[29], mips.rf.RegFile[30], mips.rf.RegFile[31]);
    end
endmodule
