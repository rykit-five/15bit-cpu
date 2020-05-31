/*
    --example--
    
    led1 = 0; led2 =0 ; led3 = 0; led4 = 0; led5 = 0; led6 = 2;

     _ _   _ _   _ _   _ _   _ _   _ _ 
    |   | |   | |   | |   | |   |  _ _|
    |_ _| |_ _| |_ _| |_ _| |_ _| |_ _




*/
module seven_seg_led( CLK, out, sa, led1, led2, led3, led4, led5, led6, reset );
  output [7:0] out;
  output [5:0] sa;
  input CLK, reset;
  input [3:0] led1,led2,led3,led4,led5,led6;
  wire [6:0] num1, num2, num3, num4, num5, num6;

  reg [10:0] count ;

  encorder enc1(.in(led1),.out(num1)); 
  encorder enc2(.in(led2),.out(num2));
  encorder enc3(.in(led3),.out(num3));
  encorder enc4(.in(led4),.out(num4));
  encorder enc5(.in(led5),.out(num5));
  encorder enc6(.in(led6),.out(num6));

  always@( posedge CLK )
  begin 
    if( reset == 1 )
      count <= 0;
    else if( count[10:8] == 3'b110 )
      count[10:8] <= 3'b000;
    else                 
      count <= count + 1;
      
  end

  assign sa[5:0] = (count[10:8] == 3'b000 ) ? 6'b111110 : 
                   (count[10:8] == 3'b001 ) ? 6'b111101 :
                   (count[10:8] == 3'b010 ) ? 6'b111011 :
                   (count[10:8] == 3'b011 ) ? 6'b110111 :
                   (count[10:8] == 3'b100 ) ? 6'b101111 :
                   (count[10:8] == 3'b101 ) ? 6'b011111 : 6'b111111;
  assign out[7:0] = (count[10:8] == 3'b000 ) ? {1'b0,num1} :
                    (count[10:8] == 3'b001 ) ? {1'b1,num2} :
                    (count[10:8] == 3'b010 ) ? {1'b0,num3} :
                    (count[10:8] == 3'b011 ) ? {1'b1,num4} :
                    (count[10:8] == 3'b100 ) ? {1'b0,num5} :
                    (count[10:8] == 3'b101 ) ? {1'b0,num6} : 8'b00000000;
endmodule

