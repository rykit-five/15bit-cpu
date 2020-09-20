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


module exec(CLK_EX,
            RESET_N,
            OP_CODE,
            REG_A,
            REG_B,
            OP_DATA,
            RAM_OUT,
            P_COUNT,
            REG_IN,
            RAM_IN,
            REG_WEN,
            RAM_WEN);
    input           CLK_EX;
    input           RESET_N;
    input   [3:0]   OP_CODE;
    input   [15:0]  REG_A;
    input   [15:0]  REG_B;
    input   [7:0]   OP_DATA;
    input   [15:0]  RAM_OUT;
    output  [7:0]   P_COUNT;
    output  [15:0]  REG_IN;
    output  [15:0]  RAM_IN;
    output          REG_WEN;
    output          RAM_WEN;

    wire    [7:0]   P_COUNT;
    reg     [15:0]  REG_IN;
    reg     [15:0]  RAM_IN;
    reg             REG_WEN;
    reg             RAM_WEN;

    reg     [7:0]   pc = 8'h00;
    reg             cmp_flag = 1'b0;

    always @ (posedge CLK_EX) begin
        if (RESET_N == 1'b0) begin
            pc <= 8'h00;
            cmp_flag <= 1'b0;
        end 
        else begin
            case (OP_CODE)
                `MOV: begin
                    REG_IN <= REG_B;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 8'h1;
                end
                `ADD: begin
                    REG_IN <= REG_A + REG_B;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `SUB: begin
                    REG_IN <= REG_A - REG_B;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `AND: begin
                    REG_IN <= REG_A & REG_B;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `OR: begin
                    REG_IN <= REG_A | REG_B;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `SL: begin
                    REG_IN <= REG_A << 1'b1;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `SR: begin
                    REG_IN <= REG_A >> 1'b1;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `SRA: begin
                    REG_IN <= {REG_A[15], REG_A[15:1]};
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `LDL: begin
                    REG_IN <= {REG_A[15:8], OP_DATA};
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `LDH: begin
                    REG_IN <= {OP_DATA, REG_A[7:0]};
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `CMP: begin
                    if (REG_A == REG_B)
                        cmp_flag <= 1'b1;
                    else
                        cmp_flag <= 1'b0;
                    REG_WEN <= 1'b0;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `JE: begin
                    if (cmp_flag == 1'b1)
                        pc <= OP_DATA;
                    else
                        pc <= pc + 1'b1;
                    REG_WEN <= 1'b0;
                    RAM_WEN <= 1'b0;
                end
                `JMP: begin
                    REG_WEN <= 1'b0;
                    RAM_WEN <= 1'b0;
                    pc <= OP_DATA;
                end
                `LD: begin
                    REG_IN <= RAM_OUT;
                    REG_WEN <= 1'b1;
                    RAM_WEN <= 1'b0;
                    pc <= pc + 1'b1;
                end
                `ST: begin
                    RAM_IN <= REG_A;
                    REG_WEN <= 1'b0;
                    RAM_WEN <= 1'b1;
                    pc <= pc + 1'b1;
                end
                `HLT: begin
                    REG_WEN <= 1'b0;
                    RAM_WEN <= 1'b0;
                end
                // default: 
                    // REG_IN <= 16'hxxxx;
                    // RAM_IN <= 16'hxxxx;
                    // REG_WEN <= 1'bx;
                    // RAM_WEN <= 1'bx;
                    // pc <= 8'bxx;
                // end
            endcase
        end
    end

    assign P_COUNT = pc;
    // always @(posedge CLK_EX) begin
    //     P_COUNT <= pc;
    // end

endmodule
