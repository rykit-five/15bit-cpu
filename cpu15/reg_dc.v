module reg_dc(CLK_DC, 
              N_REG_IN, 
              REG_0, 
              REG_1, 
              REG_2, 
              REG_3, 
              REG_4, 
              REG_5, 
              REG_6, 
              REG_7, 
              N_REG_OUT, 
              REG_OUT);
              
    input           CLK_DC;
    input   [2:0]   N_REG_IN;
    input   [15:0]  REG_0, REG_1, REG_2, REG_3, REG_4, REG_5, REG_6, REG_7;
    output  [2:0]   N_REG_OUT;
    output  [15:0]  REG_OUT;

    reg     [2:0]   N_REG_OUT;
    reg     [15:0]  REG_OUT;

    function [15:0] reg_out;
        input   [2:0]   n_reg_in;
        input   [15:0]  reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, reg_6, reg_7;

        begin
        case (n_reg_in)
            3'b000: reg_out = reg_0;
            3'b001: reg_out = reg_1;
            3'b010: reg_out = reg_2;
            3'b011: reg_out = reg_3;
            3'b100: reg_out = reg_4;
            3'b101: reg_out = reg_5;
            3'b110: reg_out = reg_6;
            3'b111: reg_out = reg_7;
            default: reg_out = 16'bxxxx;  // 不定値
            endcase
        end
    endfunction

    always @ (posedge CLK_DC) begin
        N_REG_OUT <= N_REG_IN;
        REG_OUT <= reg_out(N_REG_IN, REG_0, REG_1, REG_2, REG_3, REG_4, REG_5, REG_6, REG_7);
    end

endmodule
