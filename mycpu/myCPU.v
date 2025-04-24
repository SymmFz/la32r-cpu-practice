`timescale 1ns / 1ps

`include "defines.vh"

module myCPU (
    input  wire         cpu_rstn,
    input  wire         cpu_clk,

    // Instruction Fetch Interface
    output wire         ifetch_rreq,    // CPU取指请求信号(取指时为1)
    output wire [31:0]  ifetch_addr,    // 取指地址
    input  wire         ifetch_valid,   // 返回指令机器码的有效信号
    input  wire [31:0]  ifetch_inst,    // 返回的指令机器码
    
    // Data Access Interface
    output wire [ 3:0]  daccess_ren,    // 读使能，发出读请求时置为4'hF
    output wire [31:0]  daccess_addr,   // 读/写地址
    input  wire         daccess_valid,  // 读数据有效信号
    input  wire [31:0]  daccess_rdata,  // 读数据
    output wire [ 3:0]  daccess_wen,    // 写使能
    output wire [31:0]  daccess_wdata,  // 写数据
    input  wire         daccess_wresp,  // 写响应

    // inc_dev
    input  wire         ex_flag,        // 该信号有效表示需要执行指令，有效几个周期执行几条指令
    input  wire [31:0]  ex_inst,        // 待执行指令
    output wire         ex_finish,      // 执行结束后拉高此信号
    input  wire         sync_pc_inc,    // PC同步信号（顺序执行）
    input  wire         sync_pc_we,     // PC同步信号（分支跳转或异常）
    input  wire [31:0]  sync_pc,        // PC同步值  （分支跳转或异常）
    input  wire         sync_wb_we,     // WB阶段的写回同步：写使能
    input  wire [31:0]  sync_wb_pc,     // WB阶段的写回同步：写回阶段的PC值
    input  wire [ 4:0]  sync_wb_wreg,   // WB阶段的写回同步：被写的寄存器号
    input  wire [31:0]  sync_wb_wdata,  // WB阶段的写回同步：待写数据
`ifndef IMPL_TRAP
    input  wire         excp_occur,     // 参考CPU执行指令发生异常
`endif

    // Debug Interface
    output wire         debug_wb_valid, // 写回阶段有效信号
    output wire [31:0]  debug_wb_pc,    // 写回阶段PC值
    output wire [ 3:0]  debug_wb_ena,   // 写回阶段的寄存器堆写使能
    output wire [ 4:0]  debug_wb_reg,   // 写回阶段被写寄存器的寄存器号
    output wire [31:0]  debug_wb_value  // 写回阶段写入寄存器的数据值
);
/****** inc_dev ******/
wire        jump_taken;
assign      ex_finish = wb_valid;
`ifndef IMPL_TRAP
wire        wb_we_no_excp;
assign      wb_we_no_excp = wb_rf_we & !excp_occur;     // 发生异常时屏蔽WB阶段的写使能，使异常指令不写回
`endif

// reg suspend_restore;
// always @(posedge cpu_clk or negedge cpu_rstn) begin
//     suspend_restore <= !cpu_rstn ? 1'b0 : (ldst_suspend | jump_taken | suspend_restore) & ex_flag;
// end

reg suspend_restore;
always @(posedge cpu_clk or negedge cpu_rstn) begin
    suspend_restore <= !cpu_rstn ? 1'b0 : (ldst_suspend | pred_error | suspend_restore) & ex_flag;
end


reg [31:0] ex_inst_r;
always @(posedge cpu_clk or negedge cpu_rstn) begin
    ex_inst_r <= !cpu_rstn ? 32'h0 : ex_inst; 
end

assign      ifetch_rreq = ex_flag;          // 需要执行指令时myCPU发出取指请求
assign      ifetch_addr = if_pc;            // 以当前PC值发出取指请求
wire        inst_valid  = ifetch_valid;
wire [31:0] inst        = ifetch_inst;
/****** inc_dev ******/




// IF stage signals
wire        if_valid;           // IF阶段有效信号（有效表示当前有指令正处于IF阶段）
reg         ldst_suspend;       // 执行访存指令时的流水线暂停信号
reg         ldst_unalign;       // 访存指令的访存地址是否满足对齐条件
wire        load_use;

wire [31:0] if_pc;              // IF阶段的PC值
wire [31:0] if_npc;             // IF阶段的下一条指令PC值
wire [31:0] if_pc4;             // IF阶段PC值+4

wire [31:0] pred_target;
wire        pred_error;


// ID stage signals
wire        id_valid;           // ID阶段有效信号（有效表示当前有指令正处于ID阶段）
wire [31:0] id_pc;              // ID阶段的PC值
wire [31:0] id_pc4;             // ID阶段PC值+4
wire [31:0] id_inst;            // ID阶段的指令码

wire [ 1:0] id_npc_op;          // ID阶段的npc_op，用于控制下一条指令PC值的生成
wire [ 2:0] id_ext_op;          // ID阶段的立即数扩展op，用于控制立即数扩展方式
wire [ 2:0] id_ram_ext_op;      // ID阶段的读主存数据扩展op，用于控制主存读回数据的扩展方式（针对load指令）
wire [ 4:0] id_alu_op;          // ID阶段的alu_op，用于控制ALU运算方式
wire        id_rf_we;           // ID阶段的寄存器写使能（指令需要写回时rf_we为1）
wire [ 3:0] id_ram_we;          // ID阶段的主存写使能信号（针对store指令）
wire        id_r2_sel;          // ID阶段的源寄存器2选择信号（选择rk或rd）
wire        id_wr_sel;          // ID阶段的目的寄存器选择信号（选择rd或r1）
wire [ 1:0] id_wd_sel;          // ID阶段的写回数据选择（选择ALU执行结果写回，或选择访存数据写回，etc.）
wire        id_rR1_re;          // ID阶段的源寄存器1读标志信号（有效时表示指令需要从源寄存器1读取操作数）
wire        id_rR2_re;          // ID阶段的源寄存器2读标志信号（有效时表示指令需要从源寄存器2读取操作数）
wire [ 1:0] id_alua_sel;        // ID阶段的ALU操作数A选择信号（选择源寄存器1的值或PC）
wire        id_alub_sel;        // ID阶段的ALU操作数B选择信号（选择源寄存器2的值或扩展后的立即数）

wire        id_is_br_jump;      // ID阶段是否是分支或跳转指令

wire [31:0] id_rD1;             // ID阶段的源寄存器1的值
wire [31:0] id_rD2;             // ID阶段的源寄存器2的值
wire [31:0] id_ext;             // ID阶段的扩展后的立即数
wire [ 4:0] id_rR1 = id_inst[9:5];                                  // 从指令码中解析出源寄存器1的编号
wire [ 4:0] id_rR2 = id_r2_sel ? id_inst[14:10] : id_inst[4:0];     // 选择源寄存器2
wire [ 4:0] id_wR  = id_wr_sel ? id_inst[ 4: 0] : 5'h1;             // 选择目的寄存器

wire        id_jump_taken;      // ID阶段分支或跳转指令是否进行跳转

wire [31:0] fd_rD1;             // 前递到ID阶段的源操作数1
wire [31:0] fd_rD2;             // 前递到ID阶段的源操作数2
wire        fd_rD1_sel;         // ID阶段的源操作数1选择信号（选择前递数据或源寄存器1的值）
wire        fd_rD2_sel;         // ID阶段的源操作数2选择信号（选择前递数据或源寄存器2的值）
wire [31:0] id_real_rD1 = fd_rD1_sel ? fd_rD1 : id_rD1;     // ID阶段的源寄存器1的实际数据
wire [31:0] id_real_rD2 = fd_rD2_sel ? fd_rD2 : id_rD2;     // ID阶段的源寄存器2的实际数据

// EX stage signals
wire        ex_valid;           // EX阶段有效信号（有效表示当前有指令正处于EX阶段）
wire [ 2:0] ex_ram_ext_op;      // EX阶段的读主存数据扩展op，用于控制主存读回数据的扩展方式（针对load指令）
wire [ 4:0] ex_alu_op;          // EX阶段的alu_op，用于控制ALU运算方式
wire        ex_rf_we;           // EX阶段的寄存器写使能（指令需要写回时rf_we为1）
wire [ 3:0] ex_ram_we;          // EX阶段的主存写使能信号（针对store指令）
wire [ 1:0] ex_wd_sel;          // EX阶段的写回数据选择（选择ALU执行结果写回，或选择访存数据写回，etc.）
wire [ 1:0] ex_alua_sel;        // EX阶段的ALU操作数A选择信号（选择源寄存器1的值或PC）
wire        ex_alub_sel;        // EX阶段的ALU操作数B选择信号（选择源寄存器2的值或扩展后的立即数）

wire [ 4:0] ex_wR;              // EX阶段的目的寄存器
wire [31:0] ex_rD1;             // EX阶段的源寄存器1的值
wire [31:0] ex_rD2;             // EX阶段的源寄存器2的值
wire [31:0] ex_pc;              // EX阶段的PC值
wire [31:0] ex_pc4;             // EX阶段的PC值+4
wire [31:0] ex_ext;             // EX阶段的立即数

// EX阶段的ALU操作数A
reg [31:0] ex_alu_A;
always @(*) begin
    case (ex_alua_sel)
        `ALUA_R1:   ex_alu_A = ex_rD1;
        `ALUA_PC:   ex_alu_A = ex_pc;
        `ALUA_ZERO: ex_alu_A = 32'h00000000;
        default:    ex_alu_A = 32'h12345678;
    endcase
end
// wire [31:0] ex_alu_A = ex_alua_sel ? ex_rD1 : ex_pc;    
wire [31:0] ex_alu_B = ex_alub_sel ? ex_rD2 : ex_ext;   // EX阶段的ALU操作数B
wire [31:0] ex_alu_C;                                   // EX阶段的ALU运算结果

reg  [31:0] ex_wd;                                      // EX阶段的待写回数据
wire        ex_sel_ram = (ex_wd_sel == `WD_RAM);        // EX阶段是否是访存指令 (特指Load指令)

// MEM stage signals
wire        mem_valid;          // MEM阶段有效信号（有效表示当前有指令正处MEM阶段）
wire [ 4:0] mem_wR;             // MEM阶段的目的寄存器
wire [31:0] mem_alu_C;          // MEM阶段的ALU运算结果
wire [31:0] mem_rD2;            // MEM阶段的源寄存器2的值
wire [31:0] mem_pc4;            // MEM阶段的PC值+4
wire [31:0] mem_ext;            // MEM阶段的立即数

wire [ 2:0] mem_ram_ext_op;     // MEM阶段的读主存数据扩展op，用于控制主存读回数据的扩展方式（针对load指令）
wire [ 1:0] mem_wd_sel;         // MEM阶段的写回数据选择（选择ALU执行结果写回，或选择访存数据写回，etc.）
wire        mem_rf_we;          // MEM阶段的寄存器写使能（指令需要写回时rf_we为1）
wire [ 3:0] mem_ram_we;         // MEM阶段的主存写使能信号（针对store指令）
wire [31:0] mem_ram_ext;        // MEM阶段经过扩展的读主存数据
reg  [31:0] mem_wd;             // MEM阶段的待写回数据

// WB stage signals
wire        wb_valid;           // WB阶段有效信号（有效表示当前有指令正处于WB阶段）
wire [ 4:0] wb_wR;              // WB阶段的目的寄存器
wire [31:0] wb_pc4;             // WB阶段的PC值+4
wire [31:0] wb_alu_C;           // WB阶段的ALU运算结果
wire [31:0] wb_ram_ext;         // WB阶段的经过扩展的读主存数据
wire        wb_rf_we;           // WB阶段的寄存器写使能
wire [ 1:0] wb_wd_sel;          // WB阶段的写回数据选择（选择ALU执行结果写回，或选择访存数据写回，etc.）
reg  [31:0] wb_wd;              // WB阶段的写回数据

// IF
PC u_PC(
    .cpu_clk        (cpu_clk),
    .cpu_rstn       (cpu_rstn),    // 分支指令跳转发生后（即静态预测错误），需要重置 PC
    .suspend        (load_use | ldst_suspend),      // 流水线暂停信号
    // .din            (if_npc),           // 下一条指令地址
    .din            (pred_error ? if_npc : pred_target), // 下一条指令地址
    .pc             (if_pc),            // 当前PC值
    .valid          (if_valid),         // IF阶段有效信号

    // inc_dev
    .ex_flag        (inst_valid),
    .sync_inc       (sync_pc_inc),
    .sync_we        (sync_pc_we),
    .sync_pc        (sync_pc),
    .jump_taken     (jump_taken),
    .suspend_restore(suspend_restore),
    .pred_error     (pred_error)
);

NPC u_NPC(
    .npc_op             (id_valid ? id_npc_op : `NPC_PC4),  // 若EX阶段无效，则IF阶段默认顺序执行
    // .if_pc              (if_pc),
    .id_pc              (id_pc),
    .rj_data            (id_real_rD1),                     // 寄存器1的值（用于 jirl 指令的跳转）
    .id_jump_taken      (id_valid ? id_jump_taken : 1'b0), // ID阶段是否是分支或跳转指令
    .id_jump_offset_ext (id_ext),                          // ID阶段计算完成的分支、跳转指令的偏移量（扩展后的值）
    .pc4                (if_pc4),
    .npc                (if_npc),

    // inc_dev
    .jump_taken (jump_taken)
);

// IF/ID
IF_ID u_IF_ID(
    .cpu_clk    (cpu_clk),
    .cpu_rstn   (cpu_rstn),
    .suspend    (load_use | ldst_suspend),      // 执行访存指令时暂停流水线
    .valid_in   (if_valid & !pred_error),

    .pc_in      (if_pc),
    .pc4_in     (if_pc + 32'h4),
    .inst_in    (inst),

    .valid_out  (id_valid),
    .pc_out     (id_pc),
    .pc4_out    (id_pc4),
    .inst_out   (id_inst)
);

// ID
CU u_CU(
    .din            (id_inst[31:15]),
    .npc_op         (id_npc_op),
    .ext_op         (id_ext_op),
    .ram_ext_op     (id_ram_ext_op),
    .alu_op         (id_alu_op),
    .rf_we          (id_rf_we),
    .ram_we         (id_ram_we),
    .r2_sel         (id_r2_sel),
    .wr_sel         (id_wr_sel),
    .wd_sel         (id_wd_sel),
    .rR1_re         (id_rR1_re),
    .rR2_re         (id_rR2_re),
    .alua_sel       (id_alua_sel),
    .alub_sel       (id_alub_sel),
    
    .id_is_br_jump  (id_is_br_jump)
);

RF u_RF(
    .cpu_clk    (cpu_clk),
    .rR1        (id_rR1),
    .rR2        (id_rR2),
    .wR         (wb_wR),
`ifndef IMPL_TRAP
    .we         (wb_we_no_excp),        // 发生异常时屏蔽写回
`else
    .we         (wb_rf_we),
`endif
    .wD         (wb_wd),
    .rD1        (id_rD1),
    .rD2        (id_rD2),
    
    // inc_dev
    .sync_we    (sync_wb_we),
    .sync_dst   (sync_wb_wreg),
    .sync_val   (sync_wb_wdata)
);

EXT u_EXT(
    .din    (id_inst[25:0]),            // 指令码中的立即数字段
    .ext_op (id_ext_op),                // 扩展方式
    .ext    (id_ext)                    // 扩展后的立即数
);

BR_JUMP_TAKEN u_BR_JUMP_TAKEN(
    .din        (id_inst[31:26]),     // 指令码高 6 位
    .rd1        (id_rD1),             // 源寄存器1的值 
    .rd2        (id_rD2),             // 源寄存器2的值

    .jump_taken (id_jump_taken)       // ID阶段分支或跳转指令是否进行跳转
);

BPU u_BPU (
    .cpu_clk        (cpu_clk),
    .cpu_rstn       (cpu_rstn),
    .if_pc          (if_pc),
    // predict branch direction and target
    .pred_target    (pred_target),
    .pred_error     (pred_error),
    // signals to correct BHT
    .id_valid       (id_valid),
    .id_is_bj       (id_is_br_jump),
    .id_pc          (id_pc),
    .real_taken     (id_is_br_jump ? id_jump_taken : 1'b1), // ID阶段得到的真实跳转方向
    .real_target    (if_npc)
);

// ID/EX
ID_EX u_ID_EX(
    .cpu_clk        (cpu_clk),
    .cpu_rstn       (cpu_rstn),
    .suspend        (ldst_suspend),
    .valid_in       (id_valid & !load_use),     // ID和EX阶段发生Load-Use冒险时，下一拍清空EX阶段指令

    .wR_in          (id_wR),
    .pc_in          (id_pc),
    .pc4_in         (id_pc4),
    .rD1_in         (id_real_rD1),
    .rD2_in         (id_real_rD2),
    .ext_in         (id_ext),

    .npc_op_in      (id_npc_op),
    .rf_we_in       (id_rf_we & id_valid & !load_use),  // 若ID阶段被置为无效，清除寄存器写使能
    .wd_sel_in      (id_wd_sel),
    .alu_op_in      (id_alu_op),
    .alua_sel_in    (id_alua_sel),
    .alub_sel_in    (id_alub_sel),
    .ram_we_in      (id_ram_we),
    .ram_ext_op_in  (id_ram_ext_op),

    .valid_out      (ex_valid),
    .wR_out         (ex_wR),
    .pc_out         (ex_pc),
    .pc4_out        (ex_pc4),
    .rD1_out        (ex_rD1),
    .rD2_out        (ex_rD2),
    .ext_out        (ex_ext),

    .rf_we_out      (ex_rf_we),
    .wd_sel_out     (ex_wd_sel),
    .alu_op_out     (ex_alu_op),
    .alua_sel_out   (ex_alua_sel),
    .alub_sel_out   (ex_alub_sel),
    .ram_we_out     (ex_ram_we),
    .ram_ext_op_out (ex_ram_ext_op)
);

// EX
ALU u_ALU(
    .A          (ex_alu_A),
    .B          (ex_alu_B),
    .C          (ex_alu_C),
    .alu_op     (ex_alu_op)
);
always @(*) begin
    // 根据选择信号，在EX阶段选择相应的数据用于前递
    case (ex_wd_sel)
        `WD_RAM: ex_wd = 32'h0;
        `WD_ALU: ex_wd = ex_alu_C;
        `WD_PC4: ex_wd = ex_pc4;
        default: ex_wd = 32'h12345678;
    endcase

    // 判断访存地址是否对齐，地址不对齐时不访存
    case (ex_ram_we)
        `RAM_WE_B:      // st.b
            ldst_unalign = 1'b0;
        `RAM_WE_H:      // st.h
            ldst_unalign = (ex_alu_C[1:0] != 2'h0) & (ex_alu_C[1:0] != 2'h2);
        `RAM_WE_W:      // st.w
            ldst_unalign = (ex_alu_C[1:0] != 2'b00);
        default:        // load 类指令
            case (ex_ram_ext_op)
                `RAM_EXT_H : ldst_unalign = (ex_alu_C[1:0] != 2'h0) & (ex_alu_C[1:0] != 2'h2);
                `RAM_EXT_HU: ldst_unalign = (ex_alu_C[1:0] != 2'h0) & (ex_alu_C[1:0] != 2'h2);
                `RAM_EXT_W : ldst_unalign = (ex_alu_C[1:0] != 2'b00);
                default    : ldst_unalign = 1'b0;   // ld.b 也属于此类
            endcase
    endcase
end
always @(posedge cpu_clk or negedge cpu_rstn) begin
    if (!cpu_rstn | daccess_valid | daccess_wresp)
        ldst_suspend <= 1'b0;       // 访存结束后复位流水线暂停信号
    else if (ex_valid & (ex_wd_sel == `WD_RAM) & !ldst_unalign)
        ldst_suspend <= 1'b1;       // 执行访存指令时，拉高流水线暂停信号
end

// EX/MEM
EX_MEM u_EX_MEM(
    .cpu_clk        (cpu_clk),
    .cpu_rstn       (cpu_rstn),
    .suspend        (ldst_suspend),
    .valid_in       (ex_valid),

    .wR_in          (ex_wR),
    .pc4_in         (ex_pc4),
    .alu_C_in       (ex_alu_C),
    .rD2_in         (ex_rD2),
    .ext_in         (ex_ext),

    .rf_we_in       (ex_rf_we & !ldst_unalign),     // 若地址不对齐，不写回
    .wd_sel_in      (ex_wd_sel),
    .ram_we_in      (ex_ram_we),
    .ram_ext_op_in  (ex_ram_ext_op),

    .valid_out      (mem_valid),
    .wR_out         (mem_wR),
    .pc4_out        (mem_pc4),
    .alu_C_out      (mem_alu_C),
    .rD2_out        (mem_rD2),
    .ext_out        (mem_ext),

    .rf_we_out      (mem_rf_we),
    .wd_sel_out     (mem_wd_sel),
    .ram_we_out     (mem_ram_we),
    .ram_ext_op_out (mem_ram_ext_op)
);

// MEM
RAM_EXT u_RAM_EXT(
    .din            (daccess_rdata),    // 从主存读回的数据
    .byte_offset    (mem_alu_C[1:0]),   // 访存地址低2位
    .ram_ext_op     (mem_ram_ext_op),   // 扩展方式
    .ext_out        (mem_ram_ext)       // 扩展后的数据
);
// 根据选择信号，在MEM阶段选择相应的数据用于前递
always @(*) begin
    case (mem_wd_sel)
        `WD_RAM: mem_wd = mem_ram_ext;
        `WD_ALU: mem_wd = mem_alu_C;
        `WD_PC4: mem_wd = mem_pc4;
        default: mem_wd = 32'h87654321;
    endcase
end

// Generate load/store requests
MEM_REQ u_MEM_REQ (
    .clk            (cpu_clk       ),
    .rstn           (cpu_rstn      ),
    .ex_valid       (ex_valid      ),       // EX阶段有效信号
    .mem_wd_sel     (mem_wd_sel    ),       // 区分当前是否是访存指令
    .mem_ram_addr   (mem_alu_C     ),       // 由ALU计算得到的访存地址

    .mem_ram_ext_op (mem_ram_ext_op),       // 区分当前是哪一条load指令
    .da_ren         (daccess_ren   ),
    .da_addr        (daccess_addr  ),

    .mem_ram_we     (mem_ram_we    ),       // 区分当前是load指令还是store指令，以及是哪一条store指令
    .mem_ram_wdata  (mem_rD2       ),
    .da_wen         (daccess_wen   ),
    .da_wdata       (daccess_wdata )
);

// MEM/WB
MEM_WB u_MEM_WB(
    .cpu_clk        (cpu_clk),
    .cpu_rstn       (cpu_rstn),
    .suspend        (ldst_suspend),
    .valid_in       (mem_valid),

    .wR_in          (mem_wR),
    .pc4_in         (mem_pc4),
    .alu_C_in       (mem_alu_C),
    .ram_ext_in     (mem_ram_ext),
    .ext_in         (mem_ext),

    .rf_we_in       (mem_rf_we),
    .wd_sel_in      (mem_wd_sel),

    .valid_out      (wb_valid),
    .wR_out         (wb_wR),
    .pc4_out        (wb_pc4),
    .alu_C_out      (wb_alu_C),
    .ram_ext_out    (wb_ram_ext),

    .rf_we_out      (wb_rf_we),
    .wd_sel_out     (wb_wd_sel)
);

// WB
// 根据选择信号，在WB阶段选择相应的数据用于前递
always @(*) begin
    case (wb_wd_sel)
        `WD_RAM: wb_wd = wb_ram_ext;
        `WD_ALU: wb_wd = wb_alu_C;
        `WD_PC4: wb_wd = wb_pc4;
        default: wb_wd = 32'haabbccdd;
    endcase
end

// Data Hazard Detection & Data Forward
data_forward u_DF(
    .id_rR1         (id_rR1),
    .id_rR2         (id_rR2),
    .id_rR1_re      (id_rR1_re),
    .id_rR2_re      (id_rR2_re),

    .ex_wd          (ex_wd),
    .ex_wr          (ex_wR),
    .ex_we          (ex_rf_we & ex_valid),

    .mem_wd         (mem_wd),
    .mem_wr         (mem_wR),
    .mem_we         (mem_rf_we),

    .wb_wd          (wb_wd),
    .wb_wr          (wb_wR),
    .wb_we          (wb_rf_we),

    .ex_sel_ram     (ex_sel_ram),
    .suspend_finish (!ldst_suspend),
    .load_use       (load_use),

    .fd_rD1         (fd_rD1),
    .fd_rD1_sel     (fd_rD1_sel),
    .fd_rD2         (fd_rD2),
    .fd_rD2_sel     (fd_rD2_sel)
);



// Debug Interface
assign debug_wb_valid = wb_valid;
assign debug_wb_pc    = sync_wb_we ? sync_wb_pc      : wb_pc4 - 4;
`ifndef IMPL_TRAP
assign debug_wb_ena   = sync_wb_we ? {4{sync_wb_we}} : {4{wb_we_no_excp}};
`else
assign debug_wb_ena   = sync_wb_we ? {4{sync_wb_we}} : {4{wb_rf_we}};
`endif
assign debug_wb_reg   = sync_wb_we ? sync_wb_wreg    : wb_wR;
assign debug_wb_value = sync_wb_we ? sync_wb_wdata   : wb_wd;

endmodule
