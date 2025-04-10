`timescale 1ns / 1ps

`include "defines.vh"

module BR_JUMP_TAKEN (
    input wire [31:0] inst,             // 指令码
    input wire [31:0]  rd1,             // 寄存器1的值
    input wire [31:0]  rd2,             // 寄存器2的值

    output reg        jump_taken       // 跳转信号，表示是否发生了分支或跳转
);

wire inst_is_b_bl = inst[30:27] == 4'b1010;           // I26 型指令（b or bl）
wire [15:0] offset_2ri16 = inst[25:10];               // 2RI16 型指令的偏移量
wire [25:0] offset_i26   = {inst[9:0], inst[25:10]};  // I26 型指令的偏移量

wire rd1_rd2_signed_lt = ($signed(rd1) < $signed(rd2));
wire rd1_rd2_eq = (rd1 == rd2);

// 判断是否发生跳转
always @(*) begin
    case (inst[30:26])
        5'b10110: jump_taken = rd1_rd2_eq;         // beq
        5'b11000: jump_taken = rd1_rd2_signed_lt;  // blt
        5'b10011: jump_taken = 1'b1;                             // jirl
        5'b10101: jump_taken = 1'b1;                             // bl
        default:  jump_taken = 1'b0;                             // 默认情况下不跳转
    endcase
end

endmodule
