module memory ( addr, read, write, CLK, datain, dataout );

input [31:0] addr;
input read, write;
input CLK;
input [31:0] datain;
output [31:0] dataout;

//reg [7:0] mem [63:48] ;
reg [31:0] data_reg ;

wire [31:0] check ;

wire [31:0] addr ;

always@ ( posedge CLK )
begin
//	if ( write == 1'b1  ) 
//          { mem[ addr ], mem[ addr + 1 ], mem[ addr + 2 ], mem[ addr + 3 ] } <= datain ;
        
end


assign dataout =  ( read == 1'b0 ) ? dataout :
                  ( addr == 32'h00000000 ) ? 32'h00000820 : // add $1, $0, $0 
                  ( addr == 32'h00000004 ) ? 32'h2003000A : // addi $3, $0, A
                  ( addr == 32'h00000008 ) ? 32'h00001020 : // add $2, $0, $0
                  ( addr == 32'h0000000C ) ? 32'h20420001 : // addi $2, $2, 1
                  ( addr == 32'h00000010 ) ? 32'h00220820 : // add $1, $1, $2
                  ( addr == 32'h00000014 ) ? 32'h1443FFFD : // bne $2, $3, -3
                  ( addr == 32'h00000018 ) ? 32'h1000FFFF : // beq $0, $0, -1
//                  { mem[ addr ], mem[ addr + 1 ], mem[ addr + 2 ], mem[ addr +3 ] } ;
		  0;
//assign  dataout = data_reg;
//assign check = {mem[12], mem[13], mem[14], mem[15] } ;

endmodule
