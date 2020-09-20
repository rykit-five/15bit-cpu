`timescale 1ns / 1ns 


module CPU15_TEST();
    reg             clk;
    reg             reset_n;
    wire    [15:0]  io65_in;
    wire    [15:0]  io64_out;

    parameter       count_lim = 1000;
    integer         i;

    cpu15 cpu15_inst(
        .CLK(clk),
        .RESET_N(reset_n),
        .IO65_IN(io65_in),
        .IO64_OUT(io64_out)
    );

    initial begin
        $dumpfile("test_cpu15.vcd");
        $dumpvars(0, cpu15_inst);
    end

    initial begin
        clk = 0;
        i = 0;
    end

    always #5 begin
        clk = ~clk;
        i = i + 1;
        if (i == count_lim)
            $finish;
    end

    initial begin
        reset_n = 1'b0;
      #15 
        reset_n = 1'b1;
    end

endmodule
