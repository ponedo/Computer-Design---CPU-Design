module EXTload(data_i, op, addr, data_o);
  input [31:0] data_i;
  input [31:26] op;
  input [1:0] addr;
  output reg [31:0] data_o;
  
  /*lb,   lbu,    lh,    lhu,   lw,   sb,     sh,    sw
  6'h20, 6'h24, 6'h21, 6'h25, 6'h23, 6'h28, 6'h29, 6'h2b:*/
  
  
  always @ (*)
  begin
    case (op)
      //lb
      6'h20:
      begin
        case(addr)
          2'b00:
          begin
            if (data_i[7])
              data_o <= { 24'hff_ffff , data_i[7:0] };
            else
              data_o <= { 24'h00_0000 , data_i[7:0] };
          end
          2'b01:
          begin
            if (data_i[15])
              data_o <= { 24'hff_ffff , data_i[15:8] };
            else
              data_o <= { 24'h00_0000 , data_i[15:8] };
          end
          2'b10:
          begin
            if (data_i[23])
              data_o <= { 24'hff_ffff , data_i[23:16] };
            else
              data_o <= { 24'h00_0000 , data_i[23:16] };
          end
          2'b11:
          begin
            if (data_i[31])
              data_o <= { 24'hff_ffff , data_i[31:24] };
            else
              data_o <= { 24'h00_0000 , data_i[31:24] };
          end
        endcase
      end
      //lbu
      6'h24:
      begin
        case(addr)
          2'b00:
            data_o <= { 24'h00_0000 , data_i[7:0] };
          2'b01:
            data_o <= { 24'h00_0000 , data_i[15:8] };
          2'b10:
            data_o <= { 24'h00_0000 , data_i[23:16] };
          2'b11:
            data_o <= { 24'h00_0000 , data_i[31:24] };
        endcase
      end
      //lh
      6'h21:
      begin
        case(addr)
          2'b00,
          2'b01:
          begin
            if (data_i[15])
              data_o <= { 16'hffff , data_i[15:0] };
            else
              data_o <= { 16'h0000 , data_i[15:0] };
          end
          2'b10,
          2'b11:
          begin
            if (data_i[31])
              data_o <= { 16'hffff , data_i[31:16] };
            else
              data_o <= { 16'h0000 , data_i[31:16] };
          end
        endcase
      end
      //lhu
      6'h25:
      begin
        case(addr)
          2'b00,
          2'b01:
            data_o <= { 16'h0000 , data_i[15:0] };
          2'b10,
          2'b11:
            data_o <= { 16'h0000 , data_i[31:16] };
        endcase
      end
      //lw
      6'h23:
        data_o <= data_i;
		default:
		  data_o <= data_i;
    endcase
  end
  
endmodule
