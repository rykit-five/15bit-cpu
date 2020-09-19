module reg_wb(CLK_WB,
              RESET_N,
              N_REG,
              REG_IN,
              REG_WEN,
              REG_0,
              REG_1,
              REG_2,
              REG_3,
              REG_4,
              REG_5,
              REG_6,
              REG_7);
    input           CLK_WB;
    input           RESET_N;
    input   [2:0]   N_REG;
    input   [15:0]  REG_IN;
    input           REG_WEN;
    output  [15:0]  REG_0, REG_1, REG_2, REG_3, REG_4, REG_5, REG_6, REG_7;

    reg     [15:0]  REG_0, REG_1, REG_2, REG_3, REG_4, REG_5, REG_6, REG_7;

    always @ (posedge CLK_WB) begin
        if (RESET_N == 1'b0) begin
            REG_0 <= 16'h0000;
            REG_1 <= 16'h0000;
            REG_2 <= 16'h0000;
            REG_3 <= 16'h0000;
            REG_4 <= 16'h0000;
            REG_5 <= 16'h0000;
            REG_6 <= 16'h0000;
            REG_7 <= 16'h0000;
        end
        else if (REG_WEN == 1'b1) begin
            case (N_REG)
                3'b000: REG_0 <= REG_IN;
                3'b001: REG_1 <= REG_IN;
                3'b010: REG_2 <= REG_IN;
                3'b011: REG_3 <= REG_IN;
                3'b100: REG_4 <= REG_IN;
                3'b101: REG_5 <= REG_IN;
                3'b110: REG_6 <= REG_IN;
                3'b111: REG_7 <= REG_IN;
            endcase
        end
    end

endmodule
