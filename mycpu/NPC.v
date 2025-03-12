`timescale 1ns / 1ps

`include "defines.vh"

module NPC (
    input  wire [31:0]  if_pc,      // 当前指令的PC值
    input  wire [ 1:0]  npc_op,     // NPC操作控制信号，用于选择下一个PC的值

    output wire [31:0]  pc4,        // 当前PC+4 的值（顺序执行的下一条指令地址）
    output reg  [31:0]  npc,        // 下一个PC的值

    // inc_dev
    output reg          jump_taken  // 跳转信号，表示是否发生了分支或跳转
);

assign pc4 = if_pc + 32'h4;
always @(*) begin
    case (npc_op)
        `NPC_PC4:   // 如果npc_op为NPC_PC4，选择顺序执行的下一条指令地址
            npc = pc4;
        default :   // 默认情况下，也选择顺序执行的下一条指令地址
            npc = pc4;
    endcase
end

// inc_dev
// when branch or jump, set jump_taken to 1
always @(*) begin
    case (npc_op)
        default  : jump_taken = 1'b0;
    endcase
end

endmodule
