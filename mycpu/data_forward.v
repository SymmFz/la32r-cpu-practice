`timescale 1ns / 1ps

`include "defines.vh"

module data_forward (
    input  wire [ 4:0] id_rR1,          // ID阶段的源寄存器rR1
    input  wire [ 4:0] id_rR2,          // ID阶段的源寄存器rR2
    input  wire        id_rR1_re,       // ID阶段的指令是否需要从rR1读取数据
    input  wire        id_rR2_re,       // ID阶段的指令是否需要从rR2读取数据
 
    input  wire [31:0] ex_wd,           // EX阶段产生的执行结果
    input  wire [ 4:0] ex_wr,           // EX阶段的目标寄存器wR
    input  wire        ex_we,           // EX阶段的写使能信号
 
    input  wire [31:0] mem_wd,          // MEM阶段产生的执行结果
    input  wire [ 4:0] mem_wr,          // MEM阶段的目标寄存器wR
    input  wire        mem_we,          // MEM阶段的写使能信号
 
    input  wire [31:0] wb_wd,           // WB阶段产生的执行结果
    input  wire [ 4:0] wb_wr,           // WB阶段的目标寄存器wR
    input  wire        wb_we,           // WB阶段的写使能信号
 
    input  wire        ex_sel_ram,      // EX阶段是否是访存指令 (特指Load指令)
    input  wire        suspend_finish,  // 该信号有效表示因访存指令造成的流水线暂停已结束

    output reg  [31:0] fd_rD1,          // 前递到ID阶段的源操作数1
    output reg         fd_rD1_sel,      // 辅助前递的数据选择信号
    output reg  [31:0] fd_rD2,          // 前递到ID阶段的源操作数2
    output reg         fd_rD2_sel       // 辅助前递的数据选择信号
);

// ID阶段源操作数1的数据前递逻辑
always @(*) begin
    if (id_rR1 == 5'h0) begin                                       // 0号寄存器只读，排除之
        fd_rD1     = 32'h0;
        fd_rD1_sel = 1'b0;      // 0表示不前递
    end else if (id_rR1 == ex_wr && id_rR1_re && ex_we) begin       // ID与EX存在数据冒险
        if (ex_sel_ram) begin                               // 若EX阶段是Load指令，表明ID与EX存在Load-Use型数据冒险
            fd_rD1     = suspend_finish ? mem_wd : 32'h0;   // 需等待访存数据取回后(即访存指令的流水线暂停结束)，
            fd_rD1_sel = suspend_finish ? 1'b1 : 1'b0;      // 再把MEM阶段的数据前递到ID阶段
        end else begin
            fd_rD1     = ex_wd;
            fd_rD1_sel = 1'b1;
        end
    end else if (id_rR1 == mem_wr && id_rR1_re && mem_we) begin     // ID与MEM存在数据冒险
        fd_rD1     = mem_wd;
        fd_rD1_sel = 1'b1;
    end else if (id_rR1 == wb_wr && id_rR1_re && wb_we) begin       // ID与WB存在数据冒险
        fd_rD1     = wb_wd;
        fd_rD1_sel = 1'b1;
    end else begin
        fd_rD1     = 32'h0;
        fd_rD1_sel = 1'b0;
    end
end

// ID阶段源操作数2的数据前递逻辑
always @(*) begin
    if (id_rR2 == 5'h0) begin
        fd_rD2     = 32'h0;
        fd_rD2_sel = 1'b0;
    end else if (id_rR2 == ex_wr && id_rR2_re && ex_we) begin
        if (ex_sel_ram) begin
            fd_rD2     = suspend_finish ? mem_wd : 32'h0;
            fd_rD2_sel = suspend_finish ? 1'b1 : 1'b0;
        end else begin
            fd_rD2     = ex_wd;
            fd_rD2_sel = 1'b1;
        end
    end else if (id_rR2 == mem_wr && id_rR2_re && mem_we) begin
        fd_rD2     = mem_wd;
        fd_rD2_sel = 1'b1;
    end else if (id_rR2 == wb_wr && id_rR2_re && wb_we) begin
        fd_rD2     = wb_wd;
        fd_rD2_sel = 1'b1;
    end else begin
        fd_rD2     = 32'h0;
        fd_rD2_sel = 1'b0;
    end
end

endmodule