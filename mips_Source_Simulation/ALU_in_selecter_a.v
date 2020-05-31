module ALU_in_selecter_a( PC, in_data, ALUSrcA, out_data ) ;

input [31:0] PC;
input [31:0] in_data ;
input ALUSrcA ;

output [31:0] out_data ;

assign out_data = ( ALUSrcA == 1 ) ? in_data : PC ;

endmodule
