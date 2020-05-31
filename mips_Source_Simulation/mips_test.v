`timescale 1ns/10ns 
module mips_test( ) ;

reg CLK, reset ;
reg [7:0] count ;

parameter count_lim = 1000 ;
integer i;

initial
begin
  CLK = 0;
  i = 0;
end

always #5  
    begin
      CLK = ~CLK ;
      i = i + 1;
      if( i == count_lim )
        $finish;
    end



initial 
begin
  reset = 0;
  #15 reset = 1;
end

mips mips1( .CLK( CLK ), .reset( reset ) );

endmodule
