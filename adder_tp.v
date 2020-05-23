module adder_tp;
    reg     [3:0]   a, b;
    wire    [3:0]   q;

    adder A1(a, b, q);

    initial begin
        $dumpfile("adder_tp.vcd");
        $dumpvars(0, adder_tp);
                a = 4'h0;   b = 4'h0;
        #1000   a = 4'h5;   b = 4'ha;
        #1000   a = 4'h7;   b = 4'ha;
        #1000   a = 4'h1;   b = 4'hf;
        #1000   a = 4'hf;   b = 4'hf;
        #1000   $finish;
    end

    initial $monitor($stime, " a=%h b=%h q=%h", a, b, q);
endmodule
