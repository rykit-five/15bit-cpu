module ram_dc_wb(CLK_DC,
                 CLK_WB,
                 RAM_ADDR,
                 RAM_IN,
                 IO65_IN,
                 RAM_WEN,
                 RAM_OUT,
                 IO64_OUT
);
    input           CLK_DC;
    input           CLK_WB;
    input   [15:0]  RAM_ADDR;
    input   [15:0]  RAM_IN;
    input   [15:0]  IO65_IN;
    input           RAM_WEN;
    output  [15:0]  RAM_OUT;
    output  [15:0]  IO64_OUT;

    reg     [15:0]  RAM_OUT;
    reg     [15:0]  IO64_OUT;

    reg     [15:0]  RAM_ARRAY[63:0];
    integer         ADDR_INT;


    // 配列RAM_ARRAYの読み出し処理
    always @(posedge CLK_DC) begin
        ADDR_INT = RAM_ADDR;
        if (ADDR_INT < 64)
            RAM_OUT <= RAM_ARRAY[RAM_ADDR];
        else if (ADDR_INT == 64)
            RAM_OUT <= IO65_IN;
    end

    // 配列RAM_ARRAYの書き込み処理
    always @(posedge CLK_WB) begin
        if (ADDR_INT < 64)
            RAM_ARRAY[ADDR_INT] <= RAM_IN;
        else if (ADDR_INT == 64)
            IO64_OUT <= RAM_IN;
    end

endmodule