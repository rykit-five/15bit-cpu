module fetch(CLK_FT, P_COUNT, PROM_OUT);
    input           CLK_FT;
    input   [7:0]   P_COUNT;
    output  [14:0]  PROM_OUT;
    reg     [14:0]  PROM_OUT;
    // reg     [14:0]  memory[15:0];

    function [14:0] rom;
        input [7:0] addr;
        begin
            case (addr)
                8'h00: rom = 15'b100100000000000;  // -- ldh Reg0, 0
                8'h01: rom = 15'b100000000000000;  // -- ldl Reg0, 0
                8'h02: rom = 15'b100100100000000;  // -- ldh Reg1, 0
                8'h03: rom = 15'b100000100000000;  // -- ldl Reg1, 1
                8'h04: rom = 15'b100101000000000;  // -- ldh Reg2, 0
                8'h05: rom = 15'b100001000000000;  // -- ldl Reg2, 0
                8'h06: rom = 15'b100101100000000;  // -- ldh Reg3, 0
                8'h07: rom = 15'b100001100000000;  // -- ldl Reg3, 10
                8'h08: rom = 15'b000101000100000;  // -- add Reg2, Reg1
                8'h09: rom = 15'b000100001000000;  // -- add Reg0, Reg2
                8'h0a: rom = 15'b111000001000000;  // -- st Reg0, 64(0x40)
                8'h0b: rom = 15'b101001001100000;  // -- cmp Reg2, Reg3
                8'h0c: rom = 15'b101100000001110;  // -- je 14(0x0e)
                8'h0d: rom = 15'b110000000001000;  // -- jmp 8(0x08)
                8'h0e: rom = 15'b111100000000000;  // -- hlt
                8'h0f: rom = 15'b100100000000000;  // -- nop
            endcase

            // assign memory[0]  = 15'b100100000000000;  // -- ldh Reg0, 0
            // assign memory[1]  = 15'b100000000000000;  // -- ldl Reg0, 0
            // assign memory[2]  = 15'b100100100000000;  // -- ldh Reg1, 0
            // assign memory[3]  = 15'b100000100000000;  // -- ldl Reg1, 1
            // assign memory[4]  = 15'b100101000000000;  // -- ldh Reg2, 0
            // assign memory[5]  = 15'b100001000000000;  // -- ldl Reg2, 0
            // assign memory[6]  = 15'b100101100000000;  // -- ldh Reg3, 0
            // assign memory[7]  = 15'b100001100000000;  // -- ldl Reg3, 10
            // assign memory[8]  = 15'b000101000100000;  // -- add Reg2, Reg1
            // assign memory[9]  = 15'b000100001000000;  // -- add Reg0, Reg2
            // assign memory[10] = 15'b111000001000000;  // -- st Reg0, 64(0x40)
            // assign memory[11] = 15'b101001001100000;  // -- cmp Reg2, Reg3
            // assign memory[12] = 15'b101100000001110;  // -- je 14(0x0e)
            // assign memory[13] = 15'b110000000001000;  // -- jmp 8(0x08)
            // assign memory[14] = 15'b111100000000000;  // -- hlt
            // assign memory[15] = 15'b100100000000000;  // -- nop

            // always @ (posedge CLK_FT) begin
            //     PROM_OUT <= memory[P_COUNT[3:0]];
            // end
        end
    endfunction

    always @ (posedge CLK_FT) begin
        PROM_OUT <= rom(P_COUNT);
    end

endmodule