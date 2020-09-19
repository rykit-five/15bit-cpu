`include "clk_gen.v"
`include "fetch.v"
`include "decode.v"
`include "reg_dc.v"
`include "ram_dc.v"
`include "exec.v"
`include "reg_wb.v"
`include "ram_wb.v"


module cpu15(CLK, 
             RESET_N, 
             IO64_IN, 
             IO64_OUT);
    input           CLK;
    input           RESET_N;
    input   [15:0]  IO64_IN;
    output  [15:0]  IO64_OUT;

    /* Internal Signal */
    // clock
    wire            clk_ft;
    wire            clk_dc;
    wire            clk_ex;
    wire            clk_wb;             

    // instruction
    wire    [7:0]   p_count;
    wire    [14:0]  prom_out;
    wire    [3:0]   op_code;
    wire    [7:0]   op_data;

    // register
    wire    [2:0]   n_reg_a;
    wire    [2:0]   n_reg_b;
    wire    [15:0]  reg_in;
    wire    [15:0]  reg_a;
    wire    [15:0]  reg_b;
    wire            reg_wen;
    wire    [15:0]  reg_0;
    wire    [15:0]  reg_1;
    wire    [15:0]  reg_2;
    wire    [15:0]  reg_3;
    wire    [15:0]  reg_4;
    wire    [15:0]  reg_5;
    wire    [15:0]  reg_6;
    wire    [15:0]  reg_7;
    wire    [2:0]   n_reg_out;

    // ram
    wire    [7:0]   ram_addr;
    wire    [15:0]  ram_in;
    wire    [15:0]  ram_out;
    wire            ram_wen;
    wire    [15:0]  ram_0;
    wire    [15:0]  ram_1;
    wire    [15:0]  ram_2;
    wire    [15:0]  ram_3;
    wire    [15:0]  ram_4;
    wire    [15:0]  ram_5;
    wire    [15:0]  ram_6;
    wire    [15:0]  ram_7;

    /* Create Instances */
    clk_gen CMP1_CLK_GEN(
        .CLK(CLK), 
        .CLK_FT(clk_ft), 
        .CLK_DC(clk_dc), 
        .CLK_EX(clk_ex), 
        .CLK_WB(clk_wb)
    );

    fetch CMP2_FETCH(
        .CLK_FT(clk_ft),
        .P_COUNT(p_count), 
        .PROM_OUT(prom_out)
    );

    decode CMP3_DECODE(
        .CLK_DC(clk_dc),
        .PROM_OUT(prom_out),
        .OP_CODE(op_code),
        .OP_DATA(op_data)
    );
    
    reg_dc CMP4_REG_DC(
        .CLK_DC(clk_dc), 
        .N_REG_IN(prom_out[10:8]), 
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7),
        .N_REG_OUT(n_reg_a), 
        .REG_OUT(reg_a)
    );
    
    reg_dc CMP5_REG_DC(
        .CLK_DC(clk_dc), 
        .N_REG_IN(prom_out[7:5]), 
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7),
        .N_REG_OUT(n_reg_b), 
        .REG_OUT(reg_b)
    );

    ram_dc CMP6_RAM_DC(
        .CLK_DC(clk_dc), 
        .RAM_AD_IN(prom_out[7:0]), 
        .RAM_0(ram_0),
        .RAM_1(ram_1),
        .RAM_2(ram_2),
        .RAM_3(ram_3),
        .RAM_4(ram_4),
        .RAM_5(ram_5),
        .RAM_6(ram_6),
        .RAM_7(ram_7),
        .IO64_IN(IO64_IN),
        .RAM_AD_OUT(ram_addr), 
        .RAM_OUT(ram_out)
    );
    
    exec CMP7_EXEC(
        .CLK_EX(clk_ex),
        .RESET_N(RESET_N),
        .OP_CODE(op_code),
        .REG_A(reg_a),
        .REG_B(reg_b),
        .OP_DATA(op_data),
        .RAM_OUT(ram_out),
        .P_COUNT(p_count),
        .REG_IN(reg_in),
        .RAM_IN(ram_in),
        .REG_WEN(reg_wen),
        .RAM_WEN(ram_wen)
    );

    reg_wb CMP8_REG_WB(
        .CLK_WB(clk_wb),
        .RESET_N(RESET_N),
        .N_REG(n_reg_a),
        .REG_IN(reg_in),
        .REG_WEN(reg_wen),
        .REG_0(reg_0),
        .REG_1(reg_1),
        .REG_2(reg_2),
        .REG_3(reg_3),
        .REG_4(reg_4),
        .REG_5(reg_5),
        .REG_6(reg_6),
        .REG_7(reg_7)
    );

    ram_wb CMP9_RAM_WB(
        .CLK_WB(clk_wb),
        .RAM_ADDR(ram_addr),
        .RAM_IN(ram_in),
        .RAM_WEN(ram_wen),
        .RAM_0(ram_0),
        .RAM_1(ram_1),
        .RAM_2(ram_2),
        .RAM_3(ram_3),
        .RAM_4(ram_4),
        .RAM_5(ram_5),
        .RAM_6(ram_6),
        .RAM_7(ram_7),
        .IO64_OUT(IO64_OUT)
    );

endmodule