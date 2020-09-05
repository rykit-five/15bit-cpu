module DECODE_TEST();
    reg             clk_dc;
    reg     [14:0]  prom_out;
    wire    [3:0]   op_code;
    wire    [7:0]   op_data;

    decode decode_inst(
        .CLK_DC(clk_dc),
        .PROM_OUT(prom_out),
        .OP_CODE(op_code),
        .OP_DATA(op_data)
    );

    initial begin
        $dumpfile("test_decode.vcd");
        $dumpvars(0, decode_inst);
        $monitor("%t: prom_out=%h => op_code=%h, op_data=%h", $time, prom_out, op_code, op_data);
    end    

    // テスト信号の発生
    initial begin
        clk_dc <= 1'b0;
    end

    always #5 begin
        clk_dc <= !clk_dc;
    end

    initial begin
      #10
        prom_out <= 15'b100100000000000;  // -- ldh Reg0, 0
      #10
        prom_out <= 15'b100000000000000;  // -- ldl Reg0, 0
      #10
        prom_out <= 15'b100100100000000;  // -- ldh Reg1, 0
      #10
        prom_out <= 15'b100000100000000;  // -- ldl Reg1, 1
      #10
        prom_out <= 15'b100101000000000;  // -- ldh Reg2, 0
      #10
        prom_out <= 15'b100001000000000;  // -- ldl Reg2, 0
      #10
        prom_out <= 15'b100101100000000;  // -- ldh Reg3, 0
      #10
        prom_out <= 15'b100001100000000;  // -- ldl Reg3, 10
      #10
        prom_out <= 15'b000101000100000;  // -- add Reg2, Reg1
      #10
        prom_out <= 15'b000100001000000;  // -- add Reg0, Reg2
      #10
        prom_out <= 15'b111000001000000;  // -- st Reg0, 64(0x
      #10
        prom_out <= 15'b101001001100000;  // -- cmp Reg2, R
      #10
        prom_out <= 15'b101100000001110;  // -- je 14(0x0e)
      #10
        prom_out <= 15'b110000000001000;  // -- jmp
      #10
        prom_out <= 15'b111100000000000;  // -- hlt
      #10
        prom_out <= 15'b100100000000000;  // -- nop
      #10
      $finish;
    end

endmodule