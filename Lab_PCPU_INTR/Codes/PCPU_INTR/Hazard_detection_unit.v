
module Hazard_detection_unit(ID_EX_MemRead, EX_MEM_MemRead, ID_EX_RegWrite, 
                             PCWriteCond, Jump, mtc0, 
                             ID_EX_Rdst, EX_MEM_Rd, 
                             IF_ID_Rs, IF_ID_Rt, 
                             Stall, PCWrite, IF_IDWrite);
  input ID_EX_MemRead;
  input EX_MEM_MemRead;
  input ID_EX_RegWrite;
  input [3:0] PCWriteCond;
  input [1:0] Jump;
  input mtc0;
  input [5:0] ID_EX_Rdst;
  input [5:0] EX_MEM_Rd;
  input [5:0] IF_ID_Rs;
  input [5:0] IF_ID_Rt;
  output reg Stall;
  output reg PCWrite;
  output reg IF_IDWrite;
  
  always @ (*)
  begin
    
    if ((ID_EX_MemRead 
          || (ID_EX_RegWrite && ((PCWriteCond != 4'h0) || (Jump != 2'b00) || mtc0))) 
          //Branch or Jump Instruction at ID stage needs operands urgently
        && ((ID_EX_Rdst == IF_ID_Rs) || (ID_EX_Rdst == IF_ID_Rt))) //THE EXACT writing-target register
      begin
        // Stall the pipeline
        Stall <= 1;
        PCWrite <= 0;
        IF_IDWrite <= 0;
      end
    else if (EX_MEM_MemRead
             && ((PCWriteCond != 4'h0) || (Jump != 2'b00) || mtc0)
             && ((EX_MEM_Rd == IF_ID_Rs) || (EX_MEM_Rd == IF_ID_Rt)))
      begin
        // Stall the pipeline (again)
        Stall <= 1;
        PCWrite <= 0;
        IF_IDWrite <= 0;
      end
    else
      begin
        Stall <= 0;
        PCWrite <= 1;
        IF_IDWrite <= 1;
      end
      
  end
  
endmodule