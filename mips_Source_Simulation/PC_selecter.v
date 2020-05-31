module PC_selecter( in_data1, // ALUOut
                    in_data2, // jump dest 1
                    in_data3, // jump dest 2
//                    in_data4, // C0000000
                    PCSource, out_data ) ;

input [31:0] in_data1, in_data2, in_data3/*, in_data4*/ ;
input [1:0] PCSource ;
output [31:0] out_data ;

assign out_data = ( PCSource == 2'b00 ) ? in_data1 :
                  ( PCSource == 2'b01 ) ? in_data2 :
                  ( PCSource == 2'b10 ) ? in_data3 : 0;
//                  ( PCSource == 2'b11 ) ? in_data4 : 0 ;

endmodule
