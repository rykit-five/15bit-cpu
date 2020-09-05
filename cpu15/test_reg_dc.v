module REG_DC_TEST();
    reg             clk_dc;
    reg     [2:0]   n_reg_in;
    reg     [15:0]  reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7;
    wire    [2:0]   n_reg_out;
    wire    [15:0]  reg_out;

    reg_dc reg_dc_inst(
        .CLK_DC(clk_dc), 
        .N_REG_IN(n_reg_in), 
        .REG0(reg0),
        .REG1(reg1),
        .REG2(reg2),
        .REG3(reg3),
        .REG4(reg4),
        .REG5(reg5),
        .REG6(reg6),
        .REG7(reg7),
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
        reg0 <= 16'h6535;
        reg1 <= 16'h7628;
        reg2 <= 16'h7e6e;
        reg3 <= 16'habcd;
        reg4 <= 16'h64a6;
        reg5 <= 16'h0000;
        reg6 <= 16'h34b1;
        reg7 <= 16'h808d;
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