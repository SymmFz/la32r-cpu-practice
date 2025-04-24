`timescale 1ns / 1ps

`include "defines.vh"

module inst_cache(
    input  wire         cpu_clk,
    input  wire         cpu_rstn,       // low active
    // Interface to CPU
    input  wire         inst_rreq,      // 来自CPU的取指请求
    input  wire [31:0]  inst_addr,      // 来自CPU的取指地址
    output reg          inst_valid,     // 输出给CPU的指令有效信号（读指令命中）
    output reg  [31:0]  inst_out,       // 输出给CPU的指令
    // Interface to Read Bus
    input  wire         dev_rrdy,       // 主存就绪信号（高电平表示主存可接收ICache的读请求）
    output reg  [ 3:0]  cpu_ren,        // 输出给主存的读使能信号
    output reg  [31:0]  cpu_raddr,      // 输出给主存的读地址
    input  wire         dev_rvalid,     // 来自主存的数据有效信号
    input  wire [`CACHE_BLK_SIZE-1:0] dev_rdata   // 来自主存的读数据
);

`ifdef ENABLE_ICACHE    /******** 不要修改此行代码 ********/

    // 主存地址分解
    wire [?:0] tag_from_cpu   = /* TODO */;     // 主存地址的TAG
    wire [?:0] cache_index    = /* TODO */;     // 主存地址的Cache索引 / ICache存储体的地址
    wire [?:0] offset         = /* TODO */;     // 32位字偏移量

    wire [?:0] cache_line_r0;                   // 从ICache存储体0读出的Cache块
    wire [?:0] cache_line_r1;                   // 从ICache存储体1读出的Cache块
    wire       valid_bit0     = /* TODO */;     // Cache组内第0块的有效位
    wire       valid_bit1     = /* TODO */;     // Cache组内第1块的有效位
    wire [?:0] tag_from_set0  = /* TODO */;     // Cache组内第0块的TAG
    wire [?:0] tag_from_set1  = /* TODO */;     // Cache组内第1块的TAG

    // TODO: 定义ICache状态机的状态变量


    // 需保证命中时，hit信号仅有效1个时钟周期
    wire hit0 = /* TODO */;     // Cache组内第0块的命中信号
    wire hit1 = /* TODO */;     // Cache组内第1块的命中信号
    wire hit  = hit0 | hit1;

    wire [`CACHE_BLK_SIZE-1:0] hit_data_blk = {`CACHE_BLK_SIZE{hit0}} & cache_line_r0[`CACHE_BLK_SIZE-1:0] |
                                              {`CACHE_BLK_SIZE{hit1}} & cache_line_r1[`CACHE_BLK_SIZE-1:0];

    always @(*) begin
        inst_valid = hit;
        inst_out   = /* TODO: 根据字偏移，选择组内命中的Cache行中的某个32位字作为输出 */;
    end
    
    // 记录第i个Cache组内的Cache块的被访问情况（比如块0被访问，则置use_bit[i]为01，块1被访问则置use_bit[i]为10），用于实现Cache块替换
    reg  [1:0] use_bit [?:0];

    wire       cache_we0    = /* TODO */;       // ICache存储体0的写使能信号
    wire       cache_we1    = /* TODO */;       // ICache存储体1的写使能信号
    wire [?:0] cache_line_w = /* TODO */;       // 待写入ICache的Cache行

    // ICache存储体：Block MEM IP核
    blk_mem_gen_1 U_isram0 (        // ICache存储体0，存储所有Cache组的第0块
        .clka   (cpu_clk),
        .wea    (cache_we0),
        .addra  (cache_index),
        .dina   (cache_line_w),
        .douta  (cache_line_r0)
    );

    blk_mem_gen_1 U_isram1 (        // ICache存储体1，存储所有Cache组的第1块
        .clka   (cpu_clk),
        .wea    (cache_we1),
        .addra  (cache_index),
        .dina   (cache_line_w),
        .douta  (cache_line_r1)
    );

    // TODO: 编写状态机现态的更新逻辑
    
    
    // TODO: 编写状态机的状态转移逻辑
    

    // TODO: 生成状态机的输出信号：use_bit的更新，以及访存请求（即cpu_raddr和cpu_ren）的生成


    /******** 不要修改以下代码 ********/
`else

    localparam IDLE  = 2'b00;
    localparam STAT0 = 2'b01;
    localparam STAT1 = 2'b11;
    reg [1:0] state, nstat;

    always @(posedge cpu_clk or negedge cpu_rstn) begin
        state <= !cpu_rstn ? IDLE : nstat;
    end

    always @(*) begin
        case (state)
            IDLE:    nstat = inst_rreq ? (dev_rrdy ? STAT1 : STAT0) : IDLE;
            STAT0:   nstat = dev_rrdy ? STAT1 : STAT0;
            STAT1:   nstat = dev_rvalid ? IDLE : STAT1;
            default: nstat = IDLE;
        endcase
    end

    always @(posedge cpu_clk or negedge cpu_rstn) begin
        if (!cpu_rstn) begin
            inst_valid <= 1'b0;
            cpu_ren    <= 4'h0;
        end else begin
            case (state)
                IDLE: begin
                    inst_valid <= 1'b0;
                    cpu_ren    <= (inst_rreq & dev_rrdy) ? 4'hF : 4'h0;
                    cpu_raddr  <= inst_rreq ? inst_addr : 32'h0;
                end
                STAT0: begin
                    cpu_ren    <= dev_rrdy ? 4'hF : 4'h0;
                end
                STAT1: begin
                    cpu_ren    <= 4'h0;
                    inst_valid <= dev_rvalid ? 1'b1 : 1'b0;
                    inst_out   <= dev_rvalid ? dev_rdata[31:0] : 32'h0;
                end
                default: begin
                    inst_valid <= 1'b0;
                    cpu_ren    <= 4'h0;
                end
            endcase
        end
    end

`endif

endmodule
