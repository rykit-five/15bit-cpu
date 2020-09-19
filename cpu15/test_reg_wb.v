module REG_WB_TEST();
    reg             clk_wb;
    reg             reset_n;
    reg     [2:0]   n_reg;
    reg     [15:0]  reg_in;
    reg             reg_wen;
    wire    [15:0]  reg_0;
    wire    [15:0]  reg_1;
    wire    [15:0]  reg_2;
    wire    [15:0]  reg_3;
    wire    [15:0]  reg_4;
    wire    [15:0]  reg_5;
    wire    [15:0]  reg_6;
    wire    [15:0]  reg_7;

    reg_wb reg_wb_inst(
        .CLK_WB(clk_wb),
        .RESET_N(reset_n),
        .N_REG(n_reg),
        .REG_IN(reg_in),
        .REG_WEN(reg_wen),
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7)
    );

    initial begin
        $dumpfile("test_reg_wb.vcd");
        $dumpvars(0, reg_wb_inst);
        $monitor("%t: reset_n=%b, n_reg=%b, reg_in=%h, reg_wen=%b => reg_0=%h, reg_1=%h, reg_2=%h, reg_3=%h, reg_4=%h, reg_5=%h, reg_6=%h, reg_7=%h", $time, reset_n, n_reg, reg_in, reg_wen, reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, reg_6, reg_7);
    end

    // テスト信号の発生
    initial begin
        clk_wb <= 1'b0;
        // reset_n <= 1'b0;
        // reg_wen <= 1'b0;
        // reg_0 <= 16'h6535;
        // reg_1 <= 16'h7628;
        // reg_2 <= 16'h7e6e;
        // reg_3 <= 16'habcd;
        // reg_4 <= 16'h64a6;
        // reg_5 <= 16'h0000;
        // reg_6 <= 16'h34b1;
        // reg_7 <= 16'h808d;
    end

    always #5 begin
        clk_wb <= !clk_wb;
    end

    initial begin
      #10
        reset_n <= 1'b1;
        n_reg <= 3'b000;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b0;
      #10
        n_reg <= 3'b001;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b1;
      #10
        n_reg <= 3'b010;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b0;
      #10
        n_reg <= 3'b011;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b1;
      #10
        reset_n <= 1'b0;
      #10
        n_reg <= 3'b100;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b0;
      #10
        n_reg <= 3'b101;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b1;
      #10
        reset_n <= 1'b1;
        n_reg <= 3'b110;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b0;
      #10
        n_reg <= 3'b111;
        reg_in <= 16'hbeaf;
        reg_wen <= 1'b1;
      #10
      $finish;
    end

endmodule
