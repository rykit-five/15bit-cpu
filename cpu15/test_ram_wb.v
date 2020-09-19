module RAM_WB_TEST();
    reg             clk_wb;
    reg     [7:0]   ram_addr;
    reg     [15:0]  ram_in;
    reg             ram_wen;
    wire    [15:0]  ram_0;
    wire    [15:0]  ram_1;
    wire    [15:0]  ram_2;
    wire    [15:0]  ram_3;
    wire    [15:0]  ram_4;
    wire    [15:0]  ram_5;
    wire    [15:0]  ram_6;
    wire    [15:0]  ram_7;
    wire    [15:0]  io64_out;

    ram_wb ram_wb_inst(
        .CLK_WB(clk_wb),
        .RAM_ADDR(ram_addr),
        .RAM_IN(ram_in),
        .RAM_WEN(ram_wen),
        .RAM_0(ram_0),
        .RAM_1(ram_1),
        .RAM_2(ram_2),
        .RAM_3(ram_3),
        .RAM_4(ram_4),
        .RAM_5(ram_5),
        .RAM_6(ram_6),
        .RAM_7(ram_7),
        .IO64_OUT(io64_out)
    );

    initial begin
        $dumpfile("test_ram_wb.vcd");
        $dumpvars(0, ram_wb_inst);
        $monitor("%t: ram_addr=%h, ram_in=%h, ram_wen=%b => ram_0=%h, ram_1=%h, ram_2=%h, ram_3=%h, ram_4=%h, ram_5=%h, ram_6=%h, ram_7=%h, io64_out=%h", $time, ram_addr, ram_in, ram_wen, ram_0, ram_1, ram_2, ram_3, ram_4, ram_5, ram_6, ram_7, io64_out);
    end

    // テスト信号の発生
    initial begin
        clk_wb <= 1'b0;
    end

    always #5 begin
        clk_wb <= !clk_wb;
    end

    initial begin
      #10
        ram_addr <= 8'b00000000;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b0;
      #10
        ram_addr <= 8'b00000001;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b1;
      #10
        ram_addr <= 8'b00000010;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b0;
      #10
        ram_addr <= 8'b00000011;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b1;
      #10
        ram_addr <= 8'b00000100;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b0;
      #10
        ram_addr <= 8'b00000101;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b1;
      #10
        ram_addr <= 8'b00000110;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b0;
      #10
        ram_addr <= 8'b00000111;
        ram_in <= 16'hbeaf;
        ram_wen <= 1'b1;
      #10
        ram_addr <= 8'b01000000;
        ram_in <= 16'hcafe;
      #10
      $finish;
    end

endmodule
