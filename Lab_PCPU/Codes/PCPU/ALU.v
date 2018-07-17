`include "./ALU_defines.v"
module ALU (aluctrl, src0_i, src1_i, aluout_o, zero, sign);
  
  input [4:0] aluctrl;
  input [31:0] src0_i; //rs or shamt
  input [31:0] src1_i; //rd or transformed imm
  output [63:0] aluout_o; //32??????32?,hi??32??lo??32?  
  output zero;
  output sign;
  
  reg [63:32] hi;
  reg [31:0] aluout;
  reg [63:0] mid_mult_result;
  reg [63:0] mid_div_result;
  
  function [63:0] divide;
    input [31:0]dividend_i;
    input[31:0]divisor_i;
    
    reg [63:0]remainder;
    reg [63:0]divisor;
    reg [31:0]quotient;
    
    begin
      remainder = { 32'h0000_0000, dividend_i};
      divisor = { divisor_i, 32'h0000_0000};
      quotient = 32'h0000_0000;
    
      repeat (33)
        begin
          
          if (remainder >= divisor)
            begin
              remainder = remainder - divisor;
              quotient = quotient << 1;
              quotient[0] = 1;
            end
          else
            begin
              quotient = quotient << 1;
              quotient[0] = 0;
            end
        
        divisor = divisor >> 1;
        end
      divide = {remainder[31:0], quotient[31:0]};
    end
  endfunction

assign aluout_o = {hi[63:32], aluout[31:0]};
assign zero = (aluout == 0)?1:0;
assign sign = aluout[31];

always@(*)
begin
  case (aluctrl)
    //logic
    `ALUCtrl_AND:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
        aluout <= src0_i & src1_i;
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
	 `ALUCtrl_OR:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
		  aluout <= src0_i | src1_i;
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
	 `ALUCtrl_XOR:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
        aluout <= src0_i ^ src1_i;
	     mid_mult_result <= 64'h0000_0000_0000_0000;
		end
	 `ALUCtrl_NOR:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
        aluout <= ~(src0_i | src1_i);
		  mid_mult_result <= 64'h0000_0000_0000_0000;
	   end
	 `ALUCtrl_LUI:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
	     aluout <= {src1_i[15:0], 16'd0};
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
	 //shift
	 `ALUCtrl_SLL:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
	     aluout <= src1_i << src0_i[4:0];
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
    `ALUCtrl_SRL:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
        aluout <= src1_i >> src0_i[4:0];
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
    `ALUCtrl_SRA:
      begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
		  mid_mult_result <= 64'h0000_0000_0000_0000;
        if (src1_i[31]==0)
          aluout <= src1_i >> src0_i[4:0];
        else
          aluout <= (src1_i >> src0_i[4:0]) | ( ~( ( 1<<(32-src0_i[4:0]) ) - 1 ) );
      end
		//arith
	 `ALUCtrl_ADD:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
		  aluout <= src0_i + src1_i;
        mid_mult_result <= 64'h0000_0000_0000_0000;
      end		  
  	 `ALUCtrl_ADDU:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
		  aluout <= src0_i + src1_i;
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
    `ALUCtrl_SUB:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
        aluout <= src0_i - src1_i;
		  mid_mult_result <= 64'h0000_0000_0000_0000;
		end
    `ALUCtrl_SUBU:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
        aluout <= src0_i - src1_i;
        mid_mult_result <= 64'h0000_0000_0000_0000;
      end		  
		//mul
    `ALUCtrl_MULT:
      begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
        aluout <= mid_mult_result[31:0];
        hi <= mid_mult_result[63:32];
		    case({src0_i[31], src1_i[31]})
		      2'b00:
		        mid_mult_result <= { 32'h0000_0000, src0_i[31:0]} * { 32'h0000_0000,src1_i[31:0]};
		      2'b01:
		        mid_mult_result <= ~({ 32'h0000_0000, src0_i[31:0]} * ((~{ 32'hffff_ffff, src1_i[31:0]})+1)) + 1;
		      2'b10:
		        mid_mult_result <= ~(((~{ 32'hffff_ffff, src0_i[31:0]})+1) * { 32'h0000_0000, src1_i[31:0]}) + 1;
		      2'b11: 
		        mid_mult_result <= ((~{ 32'hffff_ffff, src0_i[31:0]})+1) * ((~{ 32'hffff_ffff, src1_i[31:0]})+1);
		    endcase
		  end
    `ALUCtrl_MULTU:
      begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
        mid_mult_result <= src0_i * src1_i;
        aluout <= mid_mult_result[31:0];
        hi <= mid_mult_result[63:32];
		end
		  
		//div
		`ALUCtrl_DIV:
		  begin
		    mid_mult_result <= 64'h0000_0000_0000_0000;
		    case({src0_i[31], src1_i[31]})
		      2'b00:
		        begin
		          mid_div_result <= divide(src0_i, src1_i);
		          aluout <= mid_div_result[31:0];
		          hi <= mid_div_result[63:32];
		        end
		      2'b01:
		        begin
		          mid_div_result <= divide(src0_i, ((~src1_i)+1));
		          aluout <= ~(mid_div_result[31:0]) + 1;
		          hi <= mid_div_result[63:32];
		        end
		      2'b10:
		        begin
		          mid_div_result <= divide(((~src0_i)+1), src1_i);
		          aluout <= ~(mid_div_result[31:0]) + 1;
		          hi <= ~(mid_div_result[63:32]) + 1;
		        end
		      2'b11:
		        begin
		          mid_div_result <= divide(((~src0_i)+1), ((~src1_i)+1));
		          aluout <= mid_div_result[31:0];
		          hi <= ~(mid_div_result[63:32]) + 1;
		        end
		    endcase
		  end
      `ALUCtrl_DIVU:
        begin
		    mid_mult_result <= 64'h0000_0000_0000_0000;
		    mid_div_result <= divide(src0_i, src1_i);
		    aluout <= mid_div_result[31:0];
		    hi <= mid_div_result[63:32];
		  end
		
		//slt
		`ALUCtrl_SLT:
		  begin
		    mid_div_result <= 64'h0000_0000_0000_0000;
		    hi[63:32] <= 32'h0000_0000;
		    mid_mult_result <= 64'h0000_0000_0000_0000;
		    case({src0_i[31], src1_i[31]})
		      2'b00:
		        aluout <= (src0_i < src1_i)?1:0;
		      2'b01:
		        aluout <= 0 ;
		      2'b10:
		        aluout <= 1;
		      2'b11:
		        aluout <= (src0_i < src1_i)?1:0;
		    endcase
		  end  
    `ALUCtrl_SLTU:
	   begin
		  mid_div_result <= 64'h0000_0000_0000_0000;
		  hi[63:32] <= 32'h0000_0000;
		  mid_mult_result <= 64'h0000_0000_0000_0000;
        aluout <= (src0_i < src1_i)?1:0;
		end
    
	  default:
	    begin
		   mid_div_result <= 64'h0000_0000_0000_0000;
		   hi[63:32] <= 32'h0000_0000;
		   mid_mult_result <= 64'h0000_0000_0000_0000;
		   aluout <= 32'b0;
		 end
  endcase
  
end

endmodule