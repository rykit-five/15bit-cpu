`define FT_STAGE 2'b00
`define DC_STAGE 2'b01
`define EX_STAGE 2'b10
`define WB_STAGE 2'b11


module clk_gen(CLK, CLK_FT, CLK_DC, CLK_EX, CLK_WB);
    input           CLK;
    output          CLK_FT, CLK_DC, CLK_EX, CLK_WB;

    reg             CLK_FT, CLK_DC, CLK_EX, CLK_WB;
    reg     [1:0]   cnt = 2'b00;

    function sub_clk;
        input   [1:0]   cnt;
        input   [1:0]   sel;
        
        begin
        case (cnt)
            2'b00: sub_clk = (sel == `FT_STAGE) ? 1'b1 :
                             (sel == `DC_STAGE) ? 1'b0 :
                             (sel == `EX_STAGE) ? 1'b0 :
                             (sel == `WB_STAGE) ? 1'b0 : 1'bx;

            2'b01: sub_clk = (sel == `FT_STAGE) ? 1'b0 :
                             (sel == `DC_STAGE) ? 1'b1 :
                             (sel == `EX_STAGE) ? 1'b0 :
                             (sel == `WB_STAGE) ? 1'b0 : 1'bx;

            2'b10: sub_clk = (sel == `FT_STAGE) ? 1'b0 :
                             (sel == `DC_STAGE) ? 1'b0 :
                             (sel == `EX_STAGE) ? 1'b1 :
                             (sel == `WB_STAGE) ? 1'b0 : 1'bx;

            2'b11: sub_clk = (sel == `FT_STAGE) ? 1'b0 :
                             (sel == `DC_STAGE) ? 1'b0 :
                             (sel == `EX_STAGE) ? 1'b0 :
                             (sel == `WB_STAGE) ? 1'b1 : 1'bx;

            default: sub_clk = 1'bx;
        endcase
        end        
    endfunction
    
    always @ (posedge CLK)
    begin
        cnt <= cnt + 2'b01;
        CLK_FT <= sub_clk(cnt, `FT_STAGE);
        CLK_DC <= sub_clk(cnt, `DC_STAGE);
        CLK_EX <= sub_clk(cnt, `EX_STAGE);
        CLK_WB <= sub_clk(cnt, `WB_STAGE);
    end

endmodule