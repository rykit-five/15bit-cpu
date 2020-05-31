module mips( CLK, reset , LSG, SA, LED) ;

input CLK, reset;
wire [31:0] addr ;
wire MemRead, MemWrite, reset;
wire [31:0] ReadData, WriteData ;
wire [31:0] check ;
output [7:0] LSG ;
output [5:0] SA ;
output [3:0] LED ;

reg CLK2_reg ;
reg [21:0] count ;

wire overflow_check ;

always @( posedge CLK )
  if( count[20] == 1 ) begin
    CLK2_reg <= ~CLK2_reg ;
    count <= 0;
  end
  else begin
    CLK2_reg <= CLK2_reg ;
    count <= count + 1 ;
  end

cpucore core1( 
//               .CLK( CLK2_reg ), 
               .CLK( CLK ), 
               .reset( ~reset ),
               .MemWrite( MemWrite ) , .MemRead( MemRead ), 
               .mem_addr( addr ) , .mem_data_in( ReadData ), 
               .check( check ), 
               .overflow_check( overflow_check ) , .mem_data_out( WriteData ) );

memory mem1( .addr( addr ), .read( MemRead ), .write( MemWrite ), 
//            .CLK( CLK2_reg ), 
             .CLK( CLK ),
             .datain( WriteData ), .dataout( ReadData ) );

seven_seg_led ssl( .CLK( CLK ), .out( LSG ), .sa( SA ), .led1( check[23:20] ), 
                   .led2( check[19:16] ), .led3( check[15:12] ), .led4( check[11:8] ), .led5( check[7:4] ),
                   .led6( check[3:0] ), .reset( 1'b0 /*~reset */) ) ;                 

assign LED = ( reset == 0 ) ? 4'b0000 : { ~CLK2_reg, ~overflow_check, 2'b11 } ;

endmodule

