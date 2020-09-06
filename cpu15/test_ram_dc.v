module RAM_DC_TEST();
    reg             clk_dc;
    reg     [7:0]   ram_ad_in;
    reg     [15:0]  ram0, ram1, ram2, ram3, ram4, ram5, ram6, ram7;
    reg     [15:0]  io65_in;
    wire    [7:0]   ram_ad_out;
    wire    [15:0]  ram_out;

    ram_dc ram_dc_inst(
        .CLK_DC(clk_dc), 
        .RAM_AD_IN(ram_ad_in), 
        .RAM0(ram0),
        .RAM1(ram1),
        .RAM2(ram2),
        .RAM3(ram3),
        .RAM4(ram4),
        .RAM5(ram5),
        .RAM6(ram6),
        .RAM7(ram7),
        .IO65_IN(io65_in),
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
        ram0 <= 16'h6535;
        ram1 <= 16'h7628;
        ram2 <= 16'h7e6e;
        ram3 <= 16'habcd;
        ram4 <= 16'h64a6;
        ram5 <= 16'h0000;
        ram6 <= 16'h34b1;
        ram7 <= 16'h808d;
        io65_in <= 16'h324f;
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