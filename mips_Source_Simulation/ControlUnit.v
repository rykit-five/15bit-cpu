module ControlUnit( CLK, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                    MemtoReg, IRWrite, PCSource, ALUOp, ALUSrcB, ALUSrcA,
                    RegWrite, RegDst, Op, EPCWrite, overflow, 
                    ReverseZflag, FuncType, reset);

   input CLK, reset, overflow ;
   input [5:0] Op;
   
  
   output      PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, 
                  ALUSrcA, RegWrite, RegDst, EPCWrite, ReverseZflag, 
                  FuncType ;
   output [1:0] PCSource, ALUSrcB, ALUOp ;
   
   
   reg 	RegDst_reg, RegWrite_reg, ALUSrcA_reg, MemRead_reg, 
	MemWrite_reg, MemtoReg_reg, IorD_reg, IRWrite_reg, 
	PCWrite_reg, PCWriteCond_reg , IntCause_reg, 
	EPCWrite_reg, CauseWrite_reg, ReverseZflag_reg, FuncType_reg ;
   reg [1:0] 	ALUOp_reg, ALUSrcB_reg, PCSource_reg ;
   
   
   reg [2:0] 	state_reg ; 
   reg [2:0] 	next_state ; 
 //  reg [2:0] 	inst_type_reg ; 


//`define RESET  3'b000 
`define FETCH  3'b001
`define DECODE  3'b010
`define EXEC  3'b011 
`define MEM_ACCESS  3'b100 
`define WRITEBACK  3'b101 
//`define EXCEPTION_OF  3'b110 
//`define EXCEPTION_UDOP  3'b111 

`define OP_R  6'b000000 
`define OP_BRANCH  6'b00010x 
`define OP_JUMP  6'b000010 
`define OP_LW  6'b100011 
`define OP_SW  6'b100011 
`define OP_IMMEDIATE  6'b001xxx 


assign PCWriteCond = PCWriteCond_reg ;
assign PCWrite = PCWrite_reg ;
assign IorD = IorD_reg ;
assign MemRead = MemRead_reg ;
assign MemWrite = MemWrite_reg ;
assign MemtoReg = MemtoReg_reg  ;
assign IRWrite = IRWrite_reg ;
assign ALUSrcA = ALUSrcA_reg ;
assign RegWrite = RegWrite_reg ;
assign RegDst = RegDst_reg ;
assign PCSource = PCSource_reg ;
assign ALUSrcB = ALUSrcB_reg ;
assign ALUOp = ALUOp_reg ;
assign EPCWrite = EPCWrite_reg ;
assign ReverseZflag = ReverseZflag_reg ;
assign FuncType = FuncType_reg ;

   
/******************************************************
 * 以下の3つのalways文で状態機械を記述している
 * ****************************************************/
   
always @( posedge CLK or posedge reset )
begin
  if( reset == 1 )
    state_reg <= `FETCH ;
  else
    state_reg <= next_state;
end

always @( state_reg or Op  )
begin
  
  case ( state_reg )
//    `RESET:
//      next_state <= `FETCH ;
    
    `FETCH:
      next_state <= `DECODE ;
    
    `DECODE: 
       casex ( Op )
        `OP_R, `OP_JUMP, `OP_BRANCH, `OP_LW, `OP_SW, `OP_IMMEDIATE: begin 
          next_state <= `EXEC ;
        end
        default: begin 
          next_state <= `FETCH ; 
        end
      endcase
    
    `EXEC:
      casex( Op )
	
        `OP_LW, `OP_SW: // LW命令またはSW命令
          next_state <= `MEM_ACCESS ; 
      
        `OP_R: // R形式
          next_state <= `MEM_ACCESS ;
               
        `OP_BRANCH: 
            next_state <= `FETCH ;  
	   
        `OP_JUMP:  
          next_state <= `FETCH ; 
      
        `OP_IMMEDIATE:	
          next_state <= `MEM_ACCESS ;

        default:
          begin
              next_state <= `FETCH; //
          end
      endcase
    
    `MEM_ACCESS:
      casex ( Op )
        `OP_LW, `OP_SW: // INST_LW or INST_SW 
          next_state <= `WRITEBACK ; 
        
        `OP_R:
          begin
//            if( overflow == 1 )
//              next_state <= EXCEPTION_OF ;
//            else 
              next_state <= `FETCH ;  // go to next instruction
	 
          end
        `OP_IMMEDIATE:
          next_state <= `FETCH ;  // go to next instruction

          default:
            next_state <= `FETCH;
      endcase  // end of MEM_ACCESS
    
    `WRITEBACK:
      next_state <= `FETCH ;
/*    
    EXCEPTION_UDOP:
      next_state <= `FETCH ;
    EXCEPTION_OF:
      next_state <= `FETCH;
*/    
    default: next_state <= `FETCH ;
    
  endcase
end 

always @( state_reg or Op )
begin
  
      IRWrite_reg <= 0;
      ReverseZflag_reg <= 0;
      ALUSrcA_reg <= 1'b0;
      ALUSrcB_reg <= 2'b00;
      ALUOp_reg <= 2'b00;
      FuncType_reg <= 1'b0 ;
      MemRead_reg <= 0;
      MemtoReg_reg <= 0;
      MemWrite_reg <= 0;
      IorD_reg <= 0;
      PCWrite_reg <= 0;
      PCWriteCond_reg <= 1'b0;
      ReverseZflag_reg <= 1'b0;
      RegWrite_reg <= 1'b0;
      PCSource_reg <= 2'b00 ;
      RegDst_reg <= 0; 
      RegWrite_reg <= 0; 
  
  
  case ( state_reg )
/*    `RESET:
      begin
      end  // end of RESET
*/
    `FETCH:
      begin
      MemRead_reg <= 1;
      IRWrite_reg <= 1;
      IorD_reg <= 0;

      ALUSrcA_reg <= 0;
      ALUSrcB_reg <= 2'b01 ;
      ALUOp_reg <= 2'b00 ;
      PCWrite_reg <= 1;
      PCSource_reg <= 2'b00 ;

    end // FETCHステージの終了

    `DECODE:
    begin
      ALUSrcA_reg <= 0;
      ALUSrcB_reg <= 2'b11;
      ALUOp_reg <= 2'b00 ;

    end  // end of DECODE
    
    
    `EXEC:
    begin
      
            casex( Op )
      
              `OP_LW, `OP_SW: // LW命令またはSW命令
              begin
                ALUSrcA_reg <= 1;
                ALUSrcB_reg <= 2'b10;
                ALUOp_reg <= 2'b00;
              end 
      
              `OP_R: // R形式
              begin
                ALUSrcA_reg <= 1;
                ALUSrcB_reg <= 2'b00;
                ALUOp_reg <= 2'b10;
                FuncType_reg <= 0 ;
              end
      
              `OP_BRANCH: 
              begin
                ALUSrcA_reg <= 1;
                ALUSrcB_reg <= 2'b00;
                ALUOp_reg <= 2'b01;	

                PCWriteCond_reg <= 1;
                PCSource_reg <= 1;

                if( Op[1:0] == 2'b01 )  
                  ReverseZflag_reg <= 1;
                else
                  ReverseZflag_reg <= 0; 
 	 
              end 
	  
              `OP_JUMP:  
              begin
                PCSource_reg <= 2'b10 ;
                PCWrite_reg <= 1;
              end

              `OP_IMMEDIATE:	
              begin
                ALUSrcA_reg <= 1;
                ALUSrcB_reg <= 2'b10 ;
                ALUOp_reg <= 2'b10 ;
                FuncType_reg <= 1;
              end

            endcase
      
    
    end // end of EXEC
    
    
    `MEM_ACCESS: 
    begin

            casex ( Op )
              `OP_LW, `OP_SW: // INST_LW or INST_SW 
              begin
                IorD_reg <= 1; 
      
                if( Op[3] == 0 ) // INST_LW
                  begin
                    MemWrite_reg <= 0;
                    MemRead_reg <= 1;
                  end
                else  // INST_SW
                  begin
                    MemWrite_reg <= 1;
		    MemRead_reg <= 0;
                end
        
              end
      
              `OP_R:
              begin
                 RegDst_reg <= 1; 
                 RegWrite_reg <= 1;
                 MemtoReg_reg <= 0;
     
              end

              `OP_IMMEDIATE:
              begin
                 RegDst_reg <= 0;
                 RegWrite_reg <= 1;
                 MemtoReg_reg <= 0;
     
              end

            endcase
      
    end // end of MEM_ACCESS
    
    `WRITEBACK:
    begin
      MemtoReg_reg <= 1;
      RegWrite_reg <= 1;
      RegDst_reg <= 0;

    end // end of WRITEBACK

/*
    EXCEPTION_OF:
    begin
      IntCause_reg <= 1;
      EPCWrite_reg <= 1;
      CauseWrite_reg <= 1;
      ALUSrcA_reg <= 0 ;
      ALUSrcB_reg <= 2'b01 ;
      ALUOp_reg <= 2'b01 ;
      PCWrite_reg <= 1;
      PCSource_reg <= 2'b11 ;

    end

    EXCEPTION_UDOP:
    begin
      IntCause_reg <= 0;
      EPCWrite_reg <= 1;
      CauseWrite_reg <= 1;
      ALUSrcA_reg <= 0 ;
      ALUSrcB_reg <= 2'b01 ;
      ALUOp_reg <= 2'b01 ;
      PCWrite_reg <= 1;
      PCSource_reg <= 2'b11 ;

    end
*/
    default:
      begin
      end
  endcase
  
end

endmodule
