module REG_DC_TEST();
    reg             clk_dc;
    reg     [2:0]   n_reg_in;
    reg     [15:0]  reg_0, reg_1, reg_2, reg_3, reg_4, reg_5, reg_6, reg_7;
    wire    [2:0]   n_reg_out;
    wire    [15:0]  reg_out;

    reg_dc reg_dc_inst(
        .CLK_DC(clk_dc), 
        .N_REG_IN(n_reg_in), 
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7),
        .N_REG_OUT(n_reg_out), 
        .REG_OUT(reg_out)
    );

    initial begin
        $dumpfile("test_reg_dc.vcd");
        $dumpvars(0, reg_dc_inst);
        $monitor("%t: n_reg_in=%b => n_reg_out=%b, reg_out=%h", $time, n_reg_in, n_reg_out, reg_out);
    end    

    // テスト信号の発生
    initial begin
        clk_dc <= 1'b0;
        reg_0 <= 16'h6535;
        reg_1 <= 16'h7628;
        reg_2 <= 16'h7e6e;
        reg_3 <= 16'habcd;
        reg_4 <= 16'h64a6;
        reg_5 <= 16'h0000;
        reg_6 <= 16'h34b1;
        reg_7 <= 16'h808d;
    end

    always #5 begin
        clk_dc <= !clk_dc;
    end

    initial begin
      #10
        n_reg_in <= 3'b000;
      #10
        n_reg_in <= 3'b001;
      #10
        n_reg_in <= 3'b010;
      #10
        n_reg_in <= 3'b011;
      #10
        n_reg_in <= 3'b100;
      #10
        n_reg_in <= 3'b101;
      #10
        n_reg_in <= 3'b110;
      #10
        n_reg_in <= 3'b111;
      #10
      $finish;
    end

endmodule