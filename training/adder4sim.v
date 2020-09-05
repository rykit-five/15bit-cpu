module adder4sim();
    reg     [3:0]   in1, in2;
    wire    [3:0]   rslt;
    wire            cy;

    // 設計対象のインスタンス化
    adder4 adder4(
        .in_data1(in1),
        .in_data2(in2),
        .out_data(rslt),
        .cy(cy)
    );

    // 観測信号の指定
    initial begin
        $dumpfile("adder4sim.vcd");
        $dumpvars(0, adder4sim);
        $monitor("%t: %b + %b => %b, %b", $time, in1, in2, cy, rslt);
    end

    // テスト信号の発生
    initial begin
        #10
            in1 <= 4'b0000;  // テスト入力信号設定
            in2 <= 4'b0000;
        #10                  // 時刻経過設定
            in1 <= 4'b0110;
            in2 <= 4'b0011;
        #10
            in1 <= 4'b0111;
            in2 <= 4'b1100;
        #10
            in1 <= 4'b1111;
            in2 <= 4'b1111;
        #10
        $finish;              // シミュレーション終了
    end

endmodule