`define MOV     4'h0
`define ADD     4'h1
`define SUB     4'h2
`define AND     4'h3
`define OR      4'h4
`define SL      4'h5
`define SR      4'h6
`define SRA     4'h7
`define LDL     4'h8
`define LDH     4'h9
`define CMP     4'ha
`define JE      4'hb
`define JMP     4'hc
`define LD      4'hd
`define ST      4'he
`define HLT     4'hf


module EXEC_TEST();
    reg             clk_ex;
    reg             reset_n;
    reg     [3:0]   op_code;
    reg     [15:0]  reg_a;
    reg     [15:0]  reg_b;
    reg     [7:0]   op_data;
    reg     [15:0]  ram_out;
    wire    [7:0]   p_count;
    wire    [15:0]  reg_in;
    wire    [15:0]  ram_in;
    wire            reg_wen;
    wire            ram_wen;

    exec exec_inst(
        .CLK_EX(clk_ex),
        .RESET_N(reset_n),
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

    initial begin
        $dumpfile("test_exec.vcd");
        $dumpvars(0, exec_inst);
        $monitor("%t: clk_ex=%b, op_code=%b, reg_a=%h, reg_b=%h, op_data=%h, ram_out=%h => p_count=%h, reg_in=%h, ram_in=%h, reg_wen=%b, ram_wen=%b", 
                 $time, clk_ex, op_code, reg_a, reg_b, op_data, ram_out,
                 p_count, reg_in, ram_in, reg_wen, ram_wen);
    end

    // テスト信号の発生
    initial begin
        clk_ex <= 1'b0;
        reg_a <= 16'h63a8;
        reg_b <= 16'h0001;
        op_data <= 8'h00;
        ram_out <= 16'h8000;
    end

    always #5 begin
        clk_ex <= !clk_ex;
    end

    initial begin
      #10
        op_code <= `LDH;
        op_data <= 8'h23;
      #10
        op_code <= `LDL;
        op_data <= 8'h7;
      #10
        op_code <= `ADD;
      #10
        op_code <= `OR;
      #10
        op_code <= `CMP;
      #10
        reset_n <= 1'b1;
      #10
        op_code <= `ST;
      #10
      $finish;
    end

endmodule
