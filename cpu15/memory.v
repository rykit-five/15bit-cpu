module fetch(CLK_FT, P_COUNT, PROM_OUT);
input CLK_FT;
input [7:0] P_COUNT;
output reg [14:0] PROM_OUT;

always @ (posedge CLK_FT)
begin
    case (P_COUNT)
        8'h00: PROM_OUT = 15'b100100000000000;  // -- ldh Reg0, 0
        8'h01: PROM_OUT = 15'b100000000000000;  // -- ldl Reg0, 0
        8'h02: PROM_OUT = 15'b100100100000000;  // -- ldh Reg1, 0
        8'h03: PROM_OUT = 15'b100000100000000;  // -- ldl Reg1, 1
        8'h04: PROM_OUT = 15'b100101000000000;  // -- ldh Reg2, 0
        8'h05: PROM_OUT = 15'b100001000000000;  // -- ldl Reg2, 0
        8'h06: PROM_OUT = 15'b100101100000000;  // -- ldh Reg3, 0
        8'h07: PROM_OUT = 15'b100001100000000;  // -- ldl Reg3, 10
        8'h08: PROM_OUT = 15'b000101000100000;  // -- add Reg2, Reg1
        8'h09: PROM_OUT = 15'b000100001000000;  // -- add Reg0, Reg2
        8'h10: PROM_OUT = 15'b111000001000000;  // -- st Reg0, 64(0x40)
        8'h11: PROM_OUT = 15'b101001001100000;  // -- cmp Reg2, Reg3
        8'h12: PROM_OUT = 15'b101100000001110;  // -- je 14(0x0e)
        8'h13: PROM_OUT = 15'b110000000001000;  // -- jmp 8(0x08)
        8'h14: PROM_OUT = 15'b111100000000000;  // -- hlt
        8'h15: PROM_OUT = 15'b100100000000000;  // -- nop
        default: PROM_OUT = 15'b000000000000000;
    endcase
end

endmodule
