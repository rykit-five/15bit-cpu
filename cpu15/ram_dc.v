module ram_dc(CLK_DC, 
              RAM_AD_IN, 
              RAM0,
              RAM1,
              RAM2,
              RAM3,
              RAM4,
              RAM5,
              RAM6,
              RAM7,
              IO65_IN, 
              RAM_AD_OUT,
              RAM_OUT);
    input           CLK_DC;
    input   [7:0]   RAM_AD_IN;
    input   [15:0]  RAM0, RAM1, RAM2, RAM3, RAM4, RAM5, RAM6, RAM7;
    input   [15:0]  IO65_IN;
    output  [7:0]   RAM_AD_OUT;
    output  [15:0]  RAM_OUT;

    reg     [7:0]   RAM_AD_OUT;
    reg     [15:0]  RAM_OUT;

    function [15:0] ram_out;
        input   [7:0]   ram_ad_in;
        input   [15:0]  ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7;
        input   [15:0]  io65_in;

        begin
            case (ram_ad_in)
                8'b00000000: ram_out = ram0;
                8'b00000001: ram_out = ram1;
                8'b00000010: ram_out = ram2;
                8'b00000011: ram_out = ram3;
                8'b00000100: ram_out = ram4;
                8'b00000101: ram_out = ram5;
                8'b00000110: ram_out = ram6;
                8'b00000111: ram_out = ram7;
                8'b01000001: ram_out = io65_in;
                default: ram_out = 16'hxxxx;
            endcase
        end    
    endfunction

    always @ (posedge CLK_DC) begin
        RAM_AD_OUT <= RAM_AD_IN;
        RAM_OUT <= ram_out(RAM_AD_IN, RAM0, RAM1, RAM2, RAM3, RAM4, RAM5, RAM6, RAM7, IO65_IN);
    end

endmodule