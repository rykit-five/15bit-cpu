module cpucore( CLK, reset, MemWrite, MemRead,
               mem_addr, mem_data_in, mem_data_out, check, overflow_check );

input CLK, reset ;
output MemWrite, MemRead;
output [31:0] mem_addr ;
input [31:0] mem_data_in ;
output [31:0] mem_data_out ;
output overflow_check ;

output [31:0] check ;
wire [31:0] check_node ;
wire [31:0] ALUOut ;
reg [31:0] ALUOut_reg ;
wire [2:0] ALUControl ;
wire [31:0] ALUin1, ALUin2 ;
wire ALU_zeroflag ; 
wire [31:0] regfile_in;
wire [4:0] rd ;
wire [31:0] PC_node ;
wire [31:0] extended ;
wire overflow ;

reg [31:0] PC ; // program counter
reg [31:0] MDR ; //memory data register

// for exception 
//reg [31:0] EPC ;
//reg intCause ;

reg [31:0] regA, regB ;


wire PCWriteCond, PCWrite, IorD, MemtoReg, IRWrite, 
     ALUSrcA, RegWrite, RegDst ,
     EPCWrite, ReverseZflag, FuncType;

wire [1:0] PCSource, ALUSrcB, ALUOp ;

wire [5:0] inst_31_26 ;
wire [4:0] inst_25_21 ;
wire [4:0] inst_20_16 ;
wire [15:0] inst_15_0 ;


wire [31:0] A, B;

assign check[23:0] = { PC[7:0], check_node[15:0] } ;
assign overflow_check = overflow ;

assign mem_addr = ( IorD == 1 ) ? ALUOut_reg : PC ;
assign mem_data_out = regB ;

assign regfile_in = MemtoReg ? MDR : ALUOut_reg ;
assign rd = RegDst ? inst_15_0[15:11] : inst_20_16 ;
// 16bit -> 32bit
assign extended = { ( ( inst_15_0[15] == 0 ) ? 16'h0000 : 16'hFFFF ), inst_15_0[15:0] } ;


IR IR1( .CLK( CLK ), .IRWrite( IRWrite ), .inst( mem_data_in ), .inst_31_26( inst_31_26 ), .inst_25_21( inst_25_21 ),
        .inst_20_16( inst_20_16 ), .inst_15_0( inst_15_0 ) );


reg_file rf1( .CLK( CLK ), .rs( inst_25_21 ), .rt( inst_20_16 ), .rd( rd ), 
              .in_data( regfile_in ), .RegWrite( RegWrite ), 
              .out_data1( A ), .out_data2( B ), .check( check_node ) );

	      
ALU ALU1( .ALUControl( ALUControl ), .ALUin1( ALUin1 ), .ALUin2( ALUin2 ), .ALUOut( ALUOut ),
          .zero_flag( ALU_zeroflag ), .overflow( overflow ) );

ALU_Controler ALUC1( .func( ( FuncType == 1 ) ? {3'b100,inst_31_26[2:0]} : inst_15_0[5:0] ), 
                     .ALUControl( ALUControl ), .ALUOp( ALUOp ) );

ALU_in_selecter_a ina( .PC( PC ), .in_data( regA ), .ALUSrcA( ALUSrcA ), .out_data( ALUin1 ) ) ;

ALU_in_selecter_b inb( .in_data1( regB ), .in_data2( 32'h00000004 ), 
                       .in_data3( extended ), .in_data4( extended << 2 ), .ALUSrcB( ALUSrcB ), 
                       .out_data( ALUin2 ) ) ;

PC_selecter PCslct ( .in_data1( ALUOut ), .in_data2( ALUOut_reg ), 
                     .in_data3( { PC[31:28], ( { 2'b00,inst_25_21,inst_20_16,inst_15_0 } << 2 ) } ), 
                     /*.in_data4( 32'hC0000000 ),*/ .PCSource( PCSource ), .out_data( PC_node ) );

ControlUnit CU ( .CLK( CLK ), .PCWriteCond( PCWriteCond ), .PCWrite( PCWrite ), .IorD( IorD ), 
                 .MemRead( MemRead ), .MemWrite( MemWrite ), .MemtoReg( MemtoReg ), 
                 .IRWrite( IRWrite ), .PCSource( PCSource ), .ALUOp( ALUOp ), .ALUSrcB( ALUSrcB ),
                 .ALUSrcA( ALUSrcA ), .RegWrite( RegWrite ), .RegDst( RegDst ), 
                 .Op( inst_31_26 ), .overflow( overflow ),
                 .EPCWrite( EPCWrite ), .ReverseZflag( ReverseZflag ), .FuncType( FuncType ),                    
                 .reset( reset ) );

//--- Program Counter -------------------------------------
always @( posedge CLK ) 
begin
  if( reset == 1 )
    PC <= 0;
  else if( PCWrite || ( PCWriteCond && ( ReverseZflag == 1 ? ~ALU_zeroflag : ALU_zeroflag ) ) )
    PC <= PC_node ;                     // if ( opcode == bne )  
  else
    PC <= PC ;
end 
//----------------------------------------------------------
//---- EPC ------------------------------------------------
/*
always @( posedge CLK ) 
begin
  
  if( EPCWrite == 1'b1 )
    EPC <= ALUOut;

end*/
//----------------------------------------------------------
//--- updata regs ------------------------------------------
always @( posedge CLK )
begin
  regA <= A ;
  regB <= B ;
  ALUOut_reg <= ALUOut ;
  MDR <= mem_data_in ;
end
//-----------------------------------------------------------

endmodule
