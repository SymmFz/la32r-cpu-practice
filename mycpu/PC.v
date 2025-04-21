`timescale 1ns / 1ps

`include "defines.vh"

module PC (
    input  wire         cpu_rstn,
    input  wire         cpu_clk,
    input  wire         suspend,        // 流水线暂停信号

    input  wire [31:0]  din  ,          // 下一条指令地址
    output reg  [31:0]  pc   ,          // 当前程序计数器（PC）的值
    output wire         valid,          // IF阶段有效信号

    // inc_dev
    input  wire         ex_flag ,
    input  wire         sync_inc,       // update sequence PC when an inst is unimplemented
    input  wire         sync_we ,       // update branch PC when an inst is unimplemented
    input  wire [31:0]  sync_pc ,
    input  wire         jump_taken,     // update PC when branch or jump is implemented
    input  wire         suspend_restore,
    input  wire         pred_error
);

always @(posedge cpu_clk or negedge cpu_rstn) begin
    if (!cpu_rstn)
        pc <= `PC_INIT_VAL;
    /****** inc_dev ******/
    else if (sync_we)
        pc <= sync_pc;
    /****** inc_dev ******/
    else if(suspend)
        pc <= pc;

    // *** 修复奇怪错误：遇到未实现指令时，如果 pred_target 预测错误，恢复 PC 为 pc+4 ***
    else if (sync_inc)
        pc <= pc + 32'h4; // inc_dev
        
    // ? 如果是未实现的指令并且 bpu 预测错误，可能导致 pc 跑偏：
    // ? din = pred_error ? if_npc : predit_target;
    // ? 因为如果是未实现的指令，id_valid = 1'b0，即使预测错误 pred_error 也不会拉高
    // ? 从而 mycpu 的 pc 无法被修正成 if_npc，而是保持错误的 predit_target
    else /* inc_dev */ if (sync_inc | ex_flag | suspend_restore | pred_error)
        pc <= din;

    // else /* inc_dev */ if (sync_inc | ex_flag | suspend_restore | jump_taken)
    //     pc <= din;
end

// assign valid = !cpu_rstn ? 1'b0 : ex_flag;
assign valid = !cpu_rstn ? 1'b0 : ex_flag | suspend_restore;    // inc_dev

endmodule
