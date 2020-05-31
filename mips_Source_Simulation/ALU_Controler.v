// AL���䃆�j�b�g
// 2�̓���func��ALUOp�Ƃ��Ď󂯁C
// ALU�̓�������肷��ALUControl���o�͂���
module ALU_Controler( 
			func, // Op�R�[�h�̉�6�� 
			ALUControl,  // ALU�̐�����CALU�֏o�͂����D
				     // ���̒l��ALU�̓��삪���肳���D
			ALUOp ) ;    // ALUOp

input [5:0] func ;
output [2:0] ALUControl ;
input [1:0] ALUOp ;

reg [2:0] ALUControl_reg ;

assign ALUControl = ALUControl_reg ;

always @( ALUOp or func )
begin
	case( ALUOp )
		2'b00: ALUControl_reg <= 3'b010 ;
		2'b01: ALUControl_reg <= 3'b110 ;
		2'b10: case( func )
				6'b100000: ALUControl_reg <= 3'b010;
				6'b100010: ALUControl_reg <= 3'b110;
				6'b100100: ALUControl_reg <= 3'b000;
				6'b100101: ALUControl_reg <= 3'b001;
				6'b110010: ALUControl_reg <= 3'b111;
				default: ALUControl_reg <= 3'b000;
			endcase
		default: ALUControl_reg <= 3'b000;
	endcase
end
endmodule
