`timescale 1ns / 1ps

`include "defines.vh"

module CU (
    input  wire [16:0]  din,            // 指令码的高17位
    output wire [ 1:0]  npc_op,         // 控制下一条指令的PC值
    output reg  [ 2:0]  ext_op,         // 控制立即数扩展方式
    output reg  [ 2:0]  ram_ext_op,     // 控制读主存数据的扩展方式（针对load指令）
    output reg  [ 4:0]  alu_op,         // 控制运算类型
    output reg          rf_we,          // 控制是否写回寄存器堆
    output reg  [ 3:0]  ram_we,         // 写主存的写使能信号（针对store指令）
    output wire         r2_sel,         // 控制源寄存器2的选择
    output wire         wr_sel,         // 控制目的寄存器的选择
    output reg  [ 1:0]  wd_sel,         // 控制写回数据源
    output reg          rR1_re,         // 指令是否读取rR1，用于检测数据冒险
    output reg          rR2_re,         // 指令是否读取rR2，用于检测数据冒险
    output wire         alua_sel,       // 选择ALU操作数A的来源
    output reg          alub_sel        // 选择ALU操作数B的来源
);

assign npc_op = `NPC_PC4;

always @(*) begin
    case (din[15:13])
        3'b001 : ext_op=`EXT_20;
        default: ext_op=`EXT_NONE;
    endcase
end

always @(*) begin
    case (din[15:13])
        3'b010: begin
            case (din[10:7])
                4'b0001: ram_ext_op = `RAM_EXT_H;
                default: ram_ext_op = `RAM_EXT_N;
            endcase
        end
        default: ram_ext_op = `RAM_EXT_N;
    endcase
end

always @(*) begin
    case (din[15:13])
        3'b000: begin
            if (!din[10]) begin
                if (!din[7]) begin
                    // * 所有的 3R 类型指令
                    case (din[4:0])
                        `FR5_ADD: alu_op = `ALU_ADD;
                        `FR5_SUB: alu_op = `ALU_SUB;
                        default : alu_op = `ALU_ADD;
                    endcase
                end else
                    alu_op = `ALU_ADD;
            end else
                alu_op = `ALU_ADD;
        end
        default: alu_op=`ALU_ADD;
    endcase
end

always @(*) begin
    case (din[15:13])
        3'b010 : begin
            if (!din[9]) rf_we = 1'b1;  // load 指令：ld.b ld.bu ld.h ld.hu ld.w            
            else         rf_we = 1'b0;  // store 指令：st.b st.h st.w
        end
        default: rf_we = 1'b1;
    endcase
end

always @(*) begin
    case (din[15:13])
        default: ram_we = `RAM_WE_N;
    endcase
end

// assign r2_sel = XXX ? `R2_RK : `R2_RD;
// assign wr_sel = XXX ? `WR_Rr1: `WR_RD;
assign r2_sel = `R2_RK;     // 选择rk为源寄存器2
assign wr_sel = `WR_RD;     // 选择rd为目的寄存器

always @(*) begin
    case (din[15:13])
        3'b000 : wd_sel = `WD_ALU;
        3'b010 : wd_sel = `WD_RAM;
        3'b001 : wd_sel = `WD_ALU;
        default: wd_sel = `WD_ALU;
    endcase
end

always @(*) begin
    if (din[15:13] == 3'b001)
        rR1_re = 1'b0;
    else
        rR1_re = 1'b1;
end

always @(*) begin
    case (din[15:12])
        4'b0000: rR2_re=1'b1;
        default: rR2_re=1'b0;
    endcase
end

assign alua_sel = din[15:11] == 5'b00111 ? `ALUA_PC : `ALUA_R1;

always @(*) begin
    case (din[15:13])
        3'b000 : alub_sel = `ALUB_R2;
        3'b001 : alub_sel = `ALUB_EXT;
        3'b010 : alub_sel = `ALUB_EXT;
        default: alub_sel = `ALUB_R2;
    endcase
end

endmodule
