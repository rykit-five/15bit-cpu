module reg_file( CLK, rs, rt, rd, in_data, RegWrite , out_data1, out_data2, check ) ;
input CLK ;
input [4:0] rs, rt , rd;
input RegWrite ;
input [31:0] in_data ;
output [31:0] out_data1 ,out_data2, check ;

parameter REG_NUM = 3 ;
reg [31:0] regfile [REG_NUM + 1:1] ; 

always @( posedge CLK )
begin

  if( RegWrite == 1 ) 
    regfile[rd] <= in_data ;

end

assign out_data1 = ( rs == 0 ) ? 32'h00000000 : regfile[rs] ;
assign out_data2 = ( rt == 0 ) ? 32'h00000000 : regfile[rt] ;
assign check = regfile[1] ;

endmodule

