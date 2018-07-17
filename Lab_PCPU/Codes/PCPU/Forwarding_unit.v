
module Forwarding_unit(ID_EX_Rs, ID_EX_Rt,
                       IF_ID_Rs, IF_ID_Rt, 
                       EX_MEM_Rd, MEM_WB_Rd, 
                       PCWriteCond, Jump, EX_MEM_RegWrite, MEM_WB_RegWrite, 
                       ForwardA, ForwardB, 
                       CmpA, CmpB);
  input [4:0] ID_EX_Rs;
  input [4:0] ID_EX_Rt;
  input [4:0] IF_ID_Rs;
  input [4:0] IF_ID_Rt;
  input [4:0] EX_MEM_Rd;
  input [4:0] MEM_WB_Rd;
  input [3:0] PCWriteCond;
  input [1:0] Jump;
  input EX_MEM_RegWrite;
  input MEM_WB_RegWrite;
  output reg [1:0] ForwardA;
  output reg [1:0] ForwardB;
  output reg [1:0] CmpA;
  output reg [1:0] CmpB;
  
  always @ (*)
  begin
    
    /*Ordinary Forwarding*/
    
    if (EX_MEM_RegWrite
        && (EX_MEM_Rd != 0)
        && (EX_MEM_Rd == ID_EX_Rs))
        ForwardA <= 2'b10;
    else if (MEM_WB_RegWrite
        && (MEM_WB_Rd !=0)
        && ~(EX_MEM_RegWrite
             && (EX_MEM_Rd != 0)
             && (EX_MEM_Rd == ID_EX_Rs))
        && (MEM_WB_Rd == ID_EX_Rs))
        ForwardA <= 2'b01;
    else
        ForwardA <= 2'b00;
        
    if (EX_MEM_RegWrite
        && (EX_MEM_Rd != 0)
        && (EX_MEM_Rd == ID_EX_Rt))
        ForwardB <= 2'b10;
          
    else if (MEM_WB_RegWrite
        && (MEM_WB_Rd !=0)
        && ~(EX_MEM_RegWrite
             && (EX_MEM_Rd != 0)
             && (EX_MEM_Rd == ID_EX_Rt))
        && (MEM_WB_Rd == ID_EX_Rt))
        ForwardB <= 2'b01;
        
    else
        ForwardB <= 2'b00;
            
    /*Forwarding for branches and jumps*/
    
    if (EX_MEM_RegWrite
        && ((PCWriteCond != 4'h0 || Jump != 2'b00))
        && (EX_MEM_Rd != 0)
        && (EX_MEM_Rd == IF_ID_Rs))
        CmpA <= 2'b10;
        
    else if (MEM_WB_RegWrite
        && ((PCWriteCond != 4'h0 || Jump != 2'b00))
        && (MEM_WB_Rd !=0)
        && ~(EX_MEM_RegWrite
             && (EX_MEM_Rd != 0)
             && (EX_MEM_Rd == IF_ID_Rs))
        && (MEM_WB_Rd == IF_ID_Rs))
        CmpA <= 2'b01;
        
    else
        CmpA <= 2'b00;
        
    if (EX_MEM_RegWrite
        && (PCWriteCond != 4'h0)
        && (EX_MEM_Rd != 0)
        && (EX_MEM_Rd == IF_ID_Rt))
        CmpB <= 2'b10;
    
    else if (MEM_WB_RegWrite
        && (PCWriteCond != 4'h0)
        && (MEM_WB_Rd !=0)
        && ~(EX_MEM_RegWrite
             && (EX_MEM_Rd != 0)
             && (EX_MEM_Rd == IF_ID_Rt))
        && (MEM_WB_Rd == IF_ID_Rt))
        CmpB <= 2'b01;
        
    else
        CmpB <= 2'b00;
        
  end
  
endmodule