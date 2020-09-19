module RAM_DC_TEST();
    reg             clk_dc;
    reg     [7:0]   ram_ad_in;
    reg     [15:0]  ram_0, ram_1, ram_2, ram_3, ram_4, ram_5, ram_6, ram_7;
    reg     [15:0]  io64_in;
    wire    [7:0]   ram_ad_out;
    wire    [15:0]  ram_out;

    ram_dc ram_dc_inst(
        .CLK_DC(clk_dc), 
        .RAM_AD_IN(ram_ad_in), 
        .RAM_0(ram_0),
        .RAM_1(ram_1),
        .RAM_2(ram_2),
        .RAM_3(ram_3),
        .RAM_4(ram_4),
        .RAM_5(ram_5),
        .RAM_6(ram_6),
        .RAM_7(ram_7),
        .IO64_IN(io64_in),
        .RAM_AD_OUT(ram_ad_out), 
        .RAM_OUT(ram_out)
    );

    initial begin
        $dumpfile("test_ram_dc.vcd");
        $dumpvars(0, ram_dc_inst);
        $monitor("%t: ram_ad_in=%b => ram_ad_out=%b, ram_out=%h", $time, ram_ad_in, ram_ad_out, ram_out);
    end    

    // テスト信号の発生
    initial begin
        clk_dc <= 1'b0;
        ram_0 <= 16'h6535;
        ram_1 <= 16'h7628;
        ram_2 <= 16'h7e6e;
        ram_3 <= 16'habcd;
        ram_4 <= 16'h64a6;
        ram_5 <= 16'h0000;
        ram_6 <= 16'h34b1;
        ram_7 <= 16'h808d;
        io64_in <= 16'h324f;
    end

    always #5 begin
        clk_dc <= !clk_dc;
    end

    initial begin
      #10
        ram_ad_in <= 8'b00000000;
      #10
        ram_ad_in <= 8'b00000001;
      #10
        ram_ad_in <= 8'b00000010;
      #10
        ram_ad_in <= 8'b00000011;
      #10
        ram_ad_in <= 8'b00000100;
      #10
        ram_ad_in <= 8'b00000101;
      #10
        ram_ad_in <= 8'b00000110;
      #10
        ram_ad_in <= 8'b00000111;
      #10
        ram_ad_in <= 8'b01000001;
      #10
      $finish;
    end

endmodule