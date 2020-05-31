module ALU( ALUControl, ALUin1, ALUin2, ALUOut , zero_flag , overflow) ;

input [2:0] ALUControl ;
input [31:0] ALUin1, ALUin2 ;
output [31:0] ALUOut ;
output zero_flag ;
output overflow ;

reg co ;

reg [31:0] ALUOut_reg ;

assign zero_flag = ( ALUOut == 0 ) ? 1 : 0 ;

always@ ( ALUControl or ALUin1 or ALUin2 ) 
begin

  case( ALUControl )
  3'b000: ALUOut_reg <= ALUin1 & ALUin2 ;
  3'b001: ALUOut_reg <= ALUin1 | ALUin2 ;
  3'b010: { co, ALUOut_reg } <= { 1'b0, ALUin1 } + { 1'b0, ALUin2 };
  3'b110: ALUOut_reg <= { 1'b0, ALUin1 } - { 1'b0, ALUin2 };
  3'b111: ALUOut_reg <= ( ALUin1 < ALUin2 );
  default: ALUOut_reg <= 0;
  endcase

end

assign ALUOut = ALUOut_reg ;
assign overflow = ( ALUControl == 3'b010 ) ? ( ALUin1[31] == ALUin2[31] ) && ( ALUin1[31] != ALUOut_reg[31] ) :
                  ( ALUControl == 3'b110 ) ? ( ALUin1[31] ^ ALUin2[31] ) && ( ALUin1[31] != ALUOut_reg[31] ) :
                   0 ;
endmodule


