module CLK_GEN_TEST();
    reg     clk;
    wire    clk_ft, clk_dc, clk_ex, clk_wb;

    clk_gen clk_gen_inst(
        .CLK(clk), 
        .CLK_FT(clk_ft), 
        .CLK_DC(clk_dc), 
        .CLK_EX(clk_ex), 
        .CLK_WB(clk_wb)
    );

    initial begin
        $dumpfile("test_clk_gen.vcd");
        $dumpvars(0, clk_gen_inst);
        $monitor("%t: clk=%b => clk_ft=%b, cl_dc=%b, clk_ex=%b, clk_wb=%b", $time, clk, clk_ft, clk_dc, clk_ex, clk_wb);
    end

    always #5 begin
        clk <= !clk;
    end

    // テスト信号の発生
    initial begin
        clk <= 1'b0;
      #200
      $finish;
    end

endmodule