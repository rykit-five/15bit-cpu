module PROM_TEST;
reg             clk_ft;
reg     [7:0]   p_count;
wire    [14:0]  prom_out;

parameter STEP = 10;

prom prom_inst(
    .CLK_FT(clk_ft),
    .P_COUNT(p_count), 
    .PROM_OUT(prom_out)
);

initial begin
    $dumpfile("prom_test.vcd");
    $dumpvars(0, prom_inst);
    $monitor($stime, " p_count=%h prom_out=%h", p_count, prom_out);
end

always begin
    clk_ft = 0; #(STEP / 2);
    clk_ft = 1; #(STEP / 2);
end

initial begin
                  p_count = 8'h00;
    #STEP         p_count = 8'h01;
    #(STEP * 10)
    #(STEP / 2)   p_count = 8'h02;
    #(STEP * 3)   p_count = 8'h10;
    #STEP
    $finish;
end

endmodule