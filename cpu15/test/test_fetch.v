// `define HCYCL 10
// `timescale 1ns / 1ps

module FETCH_TEST();
    // parameter STEP = 10; // 10ナノ秒：100MHz
    // parameter TICKS = 19;

    reg             clk_ft;
    reg     [7:0]   p_count;
    wire    [14:0]  prom_out;

    fetch fetch_inst(
        .CLK_FT(clk_ft),
        .P_COUNT(p_count), 
        .PROM_OUT(prom_out)
    );

    initial begin
        $dumpfile("test_fetch.vcd");
        $dumpvars(0, fetch_inst);
        $monitor("%t: p_count=%h, prom_out=%h", $time, p_count, prom_out);
    end

    // initial begin
    //     clk_ft = 0;
    //     forever #`HCYCL clk_ft = !clk_ft;
    // end

    // initial begin
    //     repeat (TICKS) @(posedge clk_ft);
    //     $finish;
    // end

    // テスト信号の発生
    initial begin
        clk_ft <= 1'b0;
    //   #200
    //     $finish;
    end

    always #5 begin
        clk_ft <= !clk_ft;
    end

    // initial begin
    //     p_count <= 8'h00;
    // end

    // always @(posedge clk_ft) begin
    //     p_count <= 8'b01;
    // end

    initial begin
      #10
        p_count <= 8'h00;
      #10
        p_count <= 8'h01;
      #10
        p_count <= 8'h02;
      #10
        p_count <= 8'h03;
      #10
        p_count <= 8'h04;
      #10
        p_count <= 8'h05;
      #10
        p_count <= 8'h06;
      #10
        p_count <= 8'h07;
      #10
        p_count <= 8'h08;
      #10
        p_count <= 8'h09;
      #10
        p_count <= 8'h0a;
      #10
        p_count <= 8'h0b;
      #10
        p_count <= 8'h0c;
      #10
        p_count <= 8'h0d;
      #10
        p_count <= 8'h0e;
      #10
        p_count <= 8'h0f;
      #10
      $finish;
    end

endmodule
