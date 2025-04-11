`timescale 1ns / 1ps

`include "defines.vh"

module BR_JUMP_TAKEN (
    input wire [ 5:0]  din,             // 指令码高 6 位
    input wire [31:0]  rd1,             // 寄存器1的值
    input wire [31:0]  rd2,             // 寄存器2的值

    output wire        jump_taken       // 跳转信号，表示是否发生了分支或跳转
);

wire inst_is_jump = din[4];
reg  temp_jump_taken;
assign jump_taken = temp_jump_taken & inst_is_jump;

wire rd1_rd2_signed_lt = ($signed(rd1) < $signed(rd2));
wire rd1_rd2_unsigned_lt = (rd1 < rd2);
wire rd1_rd2_eq = (rd1 == rd2);


// 判断是否发生跳转
always @(*) begin
    case (din[4:0])
        `FR5_BEQ:  temp_jump_taken = rd1_rd2_eq;           // beq
        `FR5_BNE:  temp_jump_taken = !rd1_rd2_eq;          // bne
        `FR5_BLT:  temp_jump_taken = rd1_rd2_signed_lt;    // blt
        `FR5_BLTU: temp_jump_taken = rd1_rd2_unsigned_lt;  // bltu
        `FR5_BGE:  temp_jump_taken = !rd1_rd2_signed_lt;   // bge
        `FR5_BGEU: temp_jump_taken = !rd1_rd2_unsigned_lt; // bgeu

        `FR5_JIRL: temp_jump_taken = 1'b1;                             // jirl
        `FR5_B:    temp_jump_taken = 1'b1;                             // b
        `FR5_BL:   temp_jump_taken = 1'b1;                             // bl
        default:   temp_jump_taken = 1'b0;                             // 默认情况下不跳转
    endcase
end

endmodule
