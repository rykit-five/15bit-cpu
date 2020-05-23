module ANDTEST;

reg a, b;
wire c;

AND and_instance(a, b, c);

initial begin
    $dumpfile("and_test.vcd");
    $dumpvars(1, ANDTEST);

    a = 0; b = 0;
    #20 a = 1;
    #20 a = 0; b = 1;
    #20 a = 1;
    #20 a = 0; b = 0;
    #20 $finish;
end

endmodule