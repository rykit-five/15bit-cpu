module ALU_in_selecter_b( in_data1, in_data2, in_data3, in_data4, ALUSrcB, out_data ) ;

input [31:0] in_data1, in_data2, in_data3, in_data4 ;
input [1:0] ALUSrcB ;
output [31:0] out_data ;

assign out_data = ( ALUSrcB == 2'b00 ) ? in_data1 :
                  ( ALUSrcB == 2'b01 ) ? in_data2 :
                  ( ALUSrcB == 2'b10 ) ? in_data3 :
                  ( ALUSrcB == 2'b11 ) ? in_data4 :
                  /*default*/            0 ;


endmodule
