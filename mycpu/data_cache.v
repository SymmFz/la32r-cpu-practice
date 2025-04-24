`timescale 1ns / 1ps

`include "defines.vh"

module data_cache(
    input  wire         cpu_clk,
    input  wire         cpu_rstn,       // low active
    // Interface to CPU
    input  wire [ 3:0]  data_ren,       // 来自CPU的读使能信号
    input  wire [31:0]  data_addr,      // 来自CPU的地址（读、写共用）
    output reg          data_valid,     // 输出给CPU的数据有效信号
    output reg  [31:0]  data_rdata,     // 输出给CPU的读数据
    input  wire [ 3:0]  data_wen,       // 来自CPU的写使能信号
    input  wire [31:0]  data_wdata,     // 来自CPU的写数据
    output reg          data_wresp,     // 输出给CPU的写响应（高电平表示DCache已完成写操作）
    // Interface to Write Bus
    input  wire         dev_wrdy,       // 主存/外设的写就绪信号（高电平表示主存/外设可接收DCache的写请求）
    output reg  [ 3:0]  cpu_wen,        // 输出给主存/外设的写使能信号
    output reg  [31:0]  cpu_waddr,      // 输出给主存/外设的写地址
    output reg  [31:0]  cpu_wdata,      // 输出给主存/外设的写数据
    // Interface to Read Bus
    input  wire         dev_rrdy,       // 主存/外设的读就绪信号（高电平表示主存/外设可接收DCache的读请求）
    output reg  [ 3:0]  cpu_ren,        // 输出给主存/外设的读使能信号
    output reg  [31:0]  cpu_raddr,      // 输出给主存/外设的读地址
    input  wire         dev_rvalid,     // 来自主存/外设的数据有效信号
    input  wire [`CACHE_BLK_SIZE-1:0] dev_rdata       // 来自主存/外设的读数据
);

`ifdef ENABLE_DCACHE    /******** 不要修改此行代码 ********/

    // TODO: 定义DCache存储体
    reg [?:0] valid;          // 有效位
    reg [?:0] tag  [?:0];     // 块标签
    reg [?:0] data [?:0];     // 数据块

    // TODO: 定义DCache读状态机的状态及状态变量


    // TODO: 主存地址分解


    wire hit_r = /* TODO */;        // 读命中
    wire hit_w = /* TODO */;        // 写命中
    
    always @(*) begin
        data_valid = hit_r;
        data_rdata = /* TODO: 根据字偏移，选择Cache行中的某个32位字输出数据 */; 
    end

    // TODO: 编写DCache读状态机现态的更新逻辑
    
    
    // TODO: 编写DCache读状态机的状态转移逻辑

    
    // TODO: 生成DCache读状态机的输出信号


    // TODO: 编写更新Cache有效位、块标签、数据块的逻辑


    ///////////////////////////////////////////////////////////
    // TODO: 定义DCache写状态机的状态变量
    
    
    // TODO: 编写DCache写状态机的现态更新逻辑


    // TODO: 编写DCache写状态机的状态转移逻辑


    // TODO: 生成DCache写状态机的输出信号
    

    // TODO: 写命中时，只需修改Cache行中的其中一个字。请在此实现之。
    
    
    /******** 不要修改以下代码 ********/
`else

    localparam R_IDLE  = 2'b00;
    localparam R_STAT0 = 2'b01;
    localparam R_STAT1 = 2'b11;
    reg [1:0] r_state, r_nstat;
    reg [3:0] ren_r;

    always @(posedge cpu_clk or negedge cpu_rstn) begin
        r_state <= !cpu_rstn ? R_IDLE : r_nstat;
    end

    always @(*) begin
        case (r_state)
            R_IDLE:  r_nstat = (|data_ren) ? (dev_rrdy ? R_STAT1 : R_STAT0) : R_IDLE;
            R_STAT0: r_nstat = dev_rrdy ? R_STAT1 : R_STAT0;
            R_STAT1: r_nstat = dev_rvalid ? R_IDLE : R_STAT1;
            default: r_nstat = R_IDLE;
        endcase
    end

    always @(posedge cpu_clk or negedge cpu_rstn) begin
        if (!cpu_rstn) begin
            data_valid <= 1'b0;
            cpu_ren    <= 4'h0;
        end else begin
            case (r_state)
                R_IDLE: begin
                    data_valid <= 1'b0;

                    if (|data_ren) begin
                        if (dev_rrdy)
                            cpu_ren <= data_ren;
                        else
                            ren_r   <= data_ren;

                        cpu_raddr <= data_addr;
                    end else
                        cpu_ren   <= 4'h0;
                end
                R_STAT0: begin
                    cpu_ren    <= dev_rrdy ? ren_r : 4'h0;
                end   
                R_STAT1: begin
                    cpu_ren    <= 4'h0;
                    data_valid <= dev_rvalid ? 1'b1 : 1'b0;
                    data_rdata <= dev_rvalid ? dev_rdata : 32'h0;
                end
                default: begin
                    data_valid <= 1'b0;
                    cpu_ren    <= 4'h0;
                end 
            endcase
        end
    end

    localparam W_IDLE  = 2'b00;
    localparam W_STAT0 = 2'b01;
    localparam W_STAT1 = 2'b11;
    reg  [1:0] w_state, w_nstat;
    reg  [3:0] wen_r;
    wire       wr_resp = dev_wrdy & (cpu_wen == 4'h0) ? 1'b1 : 1'b0;

    always @(posedge cpu_clk or negedge cpu_rstn) begin
        w_state <= !cpu_rstn ? W_IDLE : w_nstat;
    end

    always @(*) begin
        case (w_state)
            W_IDLE:  w_nstat = (|data_wen) ? (dev_wrdy ? W_STAT1 : W_STAT0) : W_IDLE;
            W_STAT0: w_nstat = dev_wrdy ? W_STAT1 : W_STAT0;
            W_STAT1: w_nstat = wr_resp ? W_IDLE : W_STAT1;
            default: w_nstat = W_IDLE;
        endcase
    end

    always @(posedge cpu_clk or negedge cpu_rstn) begin
        if (!cpu_rstn) begin
            data_wresp <= 1'b0;
            cpu_wen    <= 4'h0;
        end else begin
            case (w_state)
                W_IDLE: begin
                    data_wresp <= 1'b0;

                    if (|data_wen) begin
                        if (dev_wrdy)
                            cpu_wen <= data_wen;
                        else
                            wen_r   <= data_wen;
                        
                        cpu_waddr  <= data_addr;
                        cpu_wdata  <= data_wdata;
                    end else
                        cpu_wen    <= 4'h0;
                end
                W_STAT0: begin
                    cpu_wen    <= dev_wrdy ? wen_r : 4'h0;
                end
                W_STAT1: begin
                    cpu_wen    <= 4'h0;
                    data_wresp <= wr_resp ? 1'b1 : 1'b0;
                end
                default: begin
                    data_wresp <= 1'b0;
                    cpu_wen    <= 4'h0;
                end
            endcase
        end
    end

`endif

endmodule
