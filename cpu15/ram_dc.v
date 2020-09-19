module ram_dc(CLK_DC, 
              RAM_AD_IN, 
              RAM_0,
              RAM_1,
              RAM_2,
              RAM_3,
              RAM_4,
              RAM_5,
              RAM_6,
              RAM_7,
              IO64_IN, 
              RAM_AD_OUT,
              RAM_OUT);
    input           CLK_DC;
    input   [7:0]   RAM_AD_IN;
    input   [15:0]  RAM_0, RAM_1, RAM_2, RAM_3, RAM_4, RAM_5, RAM_6, RAM_7;
    input   [15:0]  IO64_IN;
    output  [7:0]   RAM_AD_OUT;
    output  [15:0]  RAM_OUT;

    reg     [7:0]   RAM_AD_OUT;
    reg     [15:0]  RAM_OUT;

    function [15:0] ram_out;
        input   [7:0]   ram_ad_in;
        input   [15:0]  ram_0, ram_1, ram_2, ram_3, ram_4, ram_5, ram_6, ram_7;
        input   [15:0]  io65_in;

        begin
        case (ram_ad_in)
            8'b00000000: ram_out = ram_0;
            8'b00000001: ram_out = ram_1;
            8'b00000010: ram_out = ram_2;
            8'b00000011: ram_out = ram_3;
            8'b00000100: ram_out = ram_4;
            8'b00000101: ram_out = ram_5;
            8'b00000110: ram_out = ram_6;
            8'b00000111: ram_out = ram_7;
            8'b01000001: ram_out = io65_in;
            default: ram_out = 16'hxxxx;
        endcase
        end    
    endfunction

    always @ (posedge CLK_DC) begin
        RAM_AD_OUT <= RAM_AD_IN;
        RAM_OUT <= ram_out(RAM_AD_IN, RAM_0, RAM_1, RAM_2, RAM_3, RAM_4, RAM_5, RAM_6, RAM_7, IO64_IN);
    end

endmodule