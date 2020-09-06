module reg_dc(CLK_DC, N_REG_IN, 
              REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7, 
              N_REG_OUT, REG_OUT);
              
    input           CLK_DC;
    input   [2:0]   N_REG_IN;
    input   [15:0]  REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7;
    output  [2:0]   N_REG_OUT;
    output  [15:0]  REG_OUT;

    reg     [2:0]   N_REG_OUT;
    reg     [15:0]  REG_OUT;

    function [15:0] reg_out;
        input   [2:0]   n_reg_in;
        input   [15:0]  reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;

        begin
            case (n_reg_in)
                3'b000: reg_out = reg0;
                3'b001: reg_out = reg1;
                3'b010: reg_out = reg2;
                3'b011: reg_out = reg3;
                3'b100: reg_out = reg4;
                3'b101: reg_out = reg5;
                3'b110: reg_out = reg6;
                3'b111: reg_out = reg7;
                default: reg_out = 16'bxxxx;  // 不定値
            endcase
        end
    endfunction

    always @ (posedge CLK_DC) begin
        N_REG_OUT <= N_REG_IN;
        REG_OUT <= reg_out(N_REG_IN, REG0, REG1, REG2, REG3, REG4, REG5, REG6, REG7);
    end

endmodule
