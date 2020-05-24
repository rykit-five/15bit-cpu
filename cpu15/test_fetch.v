`define HCYCL 10
`timescale 1ns / 1ps

module FETCH_TEST;
parameter STEP = 10; // 10ナノ秒：100MHz
parameter TICKS = 19;

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
    $monitor($stime, " p_count=%h prom_out=%h", p_count, prom_out);
end

initial begin
    clk_ft = 0;
    forever #`HCYCL clk_ft = !clk_ft;
end

initial begin
    
end

initial
begin
    repeat (TICKS) @(posedge clk_ft);
    $finish;
end

endmodule