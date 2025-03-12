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
    input  wire         suspend_restore
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
    else /* inc_dev */ if (sync_inc | ex_flag | suspend_restore | jump_taken)
        pc <= din;
end

// assign valid = !cpu_rstn ? 1'b0 : ex_flag;
assign valid = !cpu_rstn ? 1'b0 : ex_flag | suspend_restore;    // inc_dev

endmodule
