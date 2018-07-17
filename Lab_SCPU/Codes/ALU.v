`include "./ALU_defines.v"
module ALU(
  input   [4:0] aluctrl_i,
  input   [31:0] src0_i,//rs or shamt
  input   [31:0] src1_i,//rd or transformed imm
  output  reg[63:0] aluout_o,//32??????32?,hi??32??lo??32?
  
  output  zero_o
  );
  
  
  reg [31:0] dividend_i;
  reg [31:0] divisor_i;
  reg [63:0] remainder;
  reg [63:0] divisor;
  reg [31:0] quotient;
  reg [63:0] mid_div_result;
  
  always @ (*)
    begin
	   if (aluctrl_i==`ALUCtrl_DIV)
		  begin
		  case({src0_i[31], src1_i[31]})
	       2'b00:
		      begin
		        dividend_i <= src0_i;
              divisor_i <= src1_i;
            end
	       2'b01:
		      begin
		        dividend_i <= src0_i;
              divisor_i <= ((~src1_i)+1);
	    	  end
	       2'b10:
		      begin
	           dividend_i <= (~src0_i)+1;
              divisor_i <= src1_i;
	    	  end
	       2'b11:
		      begin
	           dividend_i <= (~src0_i)+1;
              divisor_i <= (~src1_i)+1;
		      end
	  	  endcase
		  end
		else if (aluctrl_i==`ALUCtrl_DIVU)
		  begin
          dividend_i <= src0_i;
          divisor_i <= src1_i;
        end
		else
		  begin
          dividend_i <= 32'h0000_0000;
          divisor_i <= 32'h0000_0000;
		  end
	 end

  always @ (*)
    begin
      /*remainder = { 32'h0000_0000, dividend_i};
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
		  
      mid_div_result = {remainder[31:0], quotient[31:0]};
		*/
		mid_div_result = 64'h0000_0000_0000_0000;
    end


always@(*)
begin
  case (aluctrl_i)
    //logic
    `ALUCtrl_AND:
      aluout_o <= src0_i & src1_i;
	  `ALUCtrl_OR:
		  aluout_o <= src0_i | src1_i;
	  `ALUCtrl_NOR:
      aluout_o <= ~(src0_i | src1_i);
	  `ALUCtrl_LUI:	
	    aluout_o <= {src1_i[15:0], 16'd0};
		//shift
		`ALUCtrl_SLL:
	    aluout_o <= src1_i << src0_i;
    `ALUCtrl_SRL:
      aluout_o <= src1_i >> src0_i;
    `ALUCtrl_SRA:
      begin
        if (src0_i>=32)
          aluout_o <= {32{src1_i[31]}};
        else
          begin
            if (src1_i[31]==0)
              aluout_o <= src1_i >> src0_i;
            else
              aluout_o <= (src1_i >> src0_i) | ( ~( ( 1<<(32-src0_i) ) - 1 ) );
          end
      end
		//arith
		`ALUCtrl_ADD:
		  aluout_o <= src0_i + src1_i;
    `ALUCtrl_SUB:
      aluout_o <= src0_i - src1_i;
		//mul
    `ALUCtrl_MULT:
      begin
		    case({src0_i[31], src1_i[31]})
		      2'b00:
		        aluout_o[63:0] <= { 32'h0000_0000, src0_i[31:0]} * { 32'h0000_0000,src1_i[31:0]};
		      2'b01:
		        aluout_o[63:0] <= ~({ 32'h0000_0000, src0_i[31:0]} * ((~{ 32'hffff_ffff, src1_i[31:0]})+1)) + 1;
		      2'b10:
		        aluout_o[63:0] <= ~(((~{ 32'hffff_ffff, src0_i[31:0]})+1) * { 32'h0000_0000, src1_i[31:0]}) + 1;
		      2'b11: 
		        aluout_o[63:0] <= ((~{ 32'hffff_ffff, src0_i[31:0]})+1) * ((~{ 32'hffff_ffff, src1_i[31:0]})+1);
		    endcase
		  end
    `ALUCtrl_MULTU:
      aluout_o <= src0_i * src1_i;
		
		//div
		`ALUCtrl_DIV:
		  begin
		    case({src0_i[31], src1_i[31]})
		      2'b00:
				  begin
					 aluout_o[31:0] <= mid_div_result[31:0];
		          aluout_o[63:32] <= mid_div_result[63:32];
				  end
		      2'b01:
		        begin
		          aluout_o[31:0] <= ~(mid_div_result[31:0]) + 1;
		          aluout_o[63:32] <= mid_div_result[63:32];
		        end
		      2'b10:
		        begin
		          aluout_o[31:0] <= ~(mid_div_result[31:0]) + 1;
		          aluout_o[63:32] <= ~(mid_div_result[63:32]) + 1;
		        end
		      2'b11:
		        begin
		          aluout_o[31:0] <= mid_div_result[31:0];
		          aluout_o[63:32] <= ~(mid_div_result[63:32]) + 1;
		        end
		    endcase
		  end
    `ALUCtrl_DIVU:
      begin
		  aluout_o[31:0] <= mid_div_result[31:0];
		  aluout_o[63:32] <= ~(mid_div_result[63:32]) + 1;
  	   end
		
		//slt
		`ALUCtrl_SLT:
		  begin
		    case({src0_i[31], src1_i[31]})
		      2'b00:
		        aluout_o <= (src0_i < src1_i)?1:0;
		      2'b01:
		        aluout_o <= 0;
		      2'b10:
		        aluout_o <= 1;
		      2'b11:
		        aluout_o <= (src0_i < src1_i)?1:0;
		    endcase
		  end  
    `ALUCtrl_SLTU:
      aluout_o <= (src0_i < src1_i)?1:0;
    
	  default:
	    begin
		   aluout_o <= 64'h0000_0000;
		 end
		  
  endcase
  
end

  assign zero_o = (aluout_o == 0)?1'b1:1'b0;

endmodule

