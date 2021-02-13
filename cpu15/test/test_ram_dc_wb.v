// `include "../ram_dc_wb.v"

module RAM_DC_WB_TEST();
    reg             clk_dc;
    reg             clk_wb;
    reg     [15:0]  ram_addr;
    reg     [15:0]  ram_in;
    reg     [15:0]  io65_in;
    reg             ram_wen;
    wire    [15:0]  ram_out;
    wire    [15:0]  io64_out;

    ram_dc_wb ram_dc_wb_inst(
        .CLK_DC(clk_dc),
        .CLK_WB(clk_wb),
        .RAM_ADDR(ram_addr),
        .RAM_IN(ram_in),
        .IO65_IN(io65_in),
        .RAM_WEN(ram_wen),
        .RAM_OUT(ram_out),
        .IO64_OUT(io64_out)
    );

    initial begin
        $dumpfile("./test/test_ram_dc_wb.vcd");
        $dumpvars(0, ram_dc_wb_inst);
        $monitor("%t: ram_addr=%h, ram_in=%h, io65_in=%h => ram_wen=%b, ram_out=%h, io64_out=%h", $time, ram_addr, ram_in, io65_in, ram_wen, ram_out, io64_out);
    end

    always #5 begin
        clk_dc <= !clk_dc;
        clk_wb <= !clk_wb;
    end

    // 入力信号clk_dcの波形
    initial begin
        clk_dc <= 1'b0;
      #10
        clk_dc <= 1'b1;
      #10
        clk_dc <= 1'b0;
    end

    // 入力信号clk_wbの波形
    initial begin
        clk_wb <= 1'b0;
      #30
        clk_dc <= 1'b1;
      
    end

    // 入力信号ram_addrの波形
    integer   i, j;
    initial begin
        // integer   i, j;
        for (i = 0; i < 1; i = i + 1) begin
            ram_addr <= 16'b0000000000000000;
            for (j = 0; j < 16; j = j + 1) begin
              #40
                ram_addr <= ram_addr + 16'b0000000000000001;
            end
        end
    end

    // 入力信号ram_inの波形
    initial begin
        ram_in <= 16'b0000000000000010;
      #40
        ram_in <= 16'b0000000000000100;
      #40
        ram_in <= 16'b0000000000000110;
      #40
        ram_in <= 16'b0000000000001000;
      #40
        ram_in <= 16'b0000000000000111;
      #40
        ram_in <= 16'b0000000000000101;
      #40
        ram_in <= 16'b0000000000000011;
    end

    // 入力信号ram_wenの波形
    initial begin
        ram_wen <= 1'b1;
      #640
        ram_wen <= 1'b0;
      #640
      $finish;
    end

endmodule