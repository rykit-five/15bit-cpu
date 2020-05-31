module IR( CLK, IRWrite, inst, inst_31_26, inst_25_21, inst_20_16, inst_15_0 ) ;

input IRWrite, CLK ;
input [31:0] inst;
output [5:0] inst_31_26 ;
output [4:0] inst_25_21 ;
output [4:0] inst_20_16 ;
output [15:0] inst_15_0 ;

reg [31:0] IR;

assign inst_31_26 = IR[31:26] ;
assign inst_25_21 = IR[25:21] ;
assign inst_20_16 = IR[20:16] ;
assign inst_15_0 = IR[15:0] ;

always@ ( posedge CLK ) 
begin
  if( IRWrite == 1 )
    IR = inst ;
  else 
    IR = IR ;
end

endmodule
