`timescale 1ns / 1ps

`include "defines.vh"

module axi_master(
    input  wire         aclk,
    input  wire         aresetn,    // low active

    // ICache Interface
    output reg          ic_dev_rrdy  ,
    input  wire         ic_cpu_ren   ,
    input  wire [31:0]  ic_cpu_raddr ,
    output reg          ic_dev_rvalid,
    output reg  [`CACHE_BLK_SIZE-1:0] ic_dev_rdata,
    // DCache Write Data Interface
    output reg          dc_dev_wrdy  ,
    input  wire [ 3:0]  dc_cpu_wen   ,
    input  wire [31:0]  dc_cpu_waddr ,
    input  wire [31:0]  dc_cpu_wdata ,
    // DCache Read Data Interface
    output reg          dc_dev_rrdy  ,
    input  wire         dc_cpu_ren   ,
    input  wire [31:0]  dc_cpu_raddr ,
    output reg          dc_dev_rvalid,
    output reg  [`CACHE_BLK_SIZE-1:0] dc_dev_rdata,

    // AXI4 Master Interface
    // write address channel
    output wire [ 3:0]  m_axi_awid   ,
    output reg  [31:0]  m_axi_awaddr ,
    output reg  [ 7:0]  m_axi_awlen  ,
    output reg  [ 2:0]  m_axi_awsize ,
    output reg  [ 1:0]  m_axi_awburst,
    output wire [ 1:0]  m_axi_awlock ,
    output wire [ 3:0]  m_axi_awcache,
    output wire [ 2:0]  m_axi_awprot ,
    output reg          m_axi_awvalid,
    input  wire         m_axi_awready,
    // write data channel
    output wire [ 3:0]  m_axi_wid    ,
    output reg  [31:0]  m_axi_wdata  ,
    output reg  [ 3:0]  m_axi_wstrb  ,
    output wire         m_axi_wlast  ,
    output reg          m_axi_wvalid ,
    input  wire         m_axi_wready ,
    // write response channel
    input  wire [ 3:0]  m_axi_bid    ,
    output wire         m_axi_bready ,
    input  wire [ 1:0]  m_axi_bresp  ,
    input  wire         m_axi_bvalid ,
    // read address channel
    output wire [ 3:0]  m_axi_arid   ,
    output reg  [31:0]  m_axi_araddr ,
    output reg  [ 7:0]  m_axi_arlen  ,
    output reg  [ 2:0]  m_axi_arsize ,
    output reg  [ 1:0]  m_axi_arburst,
    output wire [ 1:0]  m_axi_arlock ,
    output wire [ 3:0]  m_axi_arcache,
    output wire [ 2:0]  m_axi_arprot ,
    output reg          m_axi_arvalid,
    input  wire         m_axi_arready,
    // read data channel
    input  wire [ 3:0]  m_axi_rid   ,
    output wire         m_axi_rready,
    input  wire [31:0]  m_axi_rdata ,
    input  wire [ 1:0]  m_axi_rresp ,
    input  wire         m_axi_rlast ,
    input  wire         m_axi_rvalid
);

    assign m_axi_awid    = 4'h8;
    assign m_axi_awlock  = 2'h0;
    assign m_axi_awcache = 4'h2;
    assign m_axi_awprot  = 3'h0;
    assign m_axi_wid     = 4'h8;
    assign m_axi_arid    = 4'h8;
    assign m_axi_arlock  = 2'h0;
    assign m_axi_arcache = 4'h2;
    assign m_axi_arprot  = 3'h0;

    wire has_dc_wr_req = dc_dev_wrdy & (dc_cpu_wen != 4'h0);
    wire has_dc_rd_req = dc_dev_rrdy & dc_cpu_ren;    // 是否有DCache读请求
    wire has_ic_rd_req = ic_dev_rrdy & ic_cpu_ren;    // 是否有ICache读请求
    wire has_rd_req    = has_dc_rd_req | has_ic_rd_req;    // 是否有读请求

    ///////////////////////////////////////////////////////////////////////////
    // read address channel
    /* TODO: 给AR通道的输出信号赋值 */
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            m_axi_araddr  <= 32'h0;
            m_axi_arvalid <= 1'b0;
        end else begin
            if (m_axi_arready) begin
                m_axi_arvalid  <= 1'b0;
                m_axi_arlen    <= 8'h0;
                m_axi_arsize   <= 3'b0;
                m_axi_arburst  <= 2'b0;
            end else if (has_rd_req) begin
                m_axi_araddr   <= has_dc_rd_req ? dc_cpu_raddr : ic_cpu_raddr; // TODO: ic dc 同时访存需要先存储 ic 相关信号，排队处理
                m_axi_arvalid  <= 1'b1;
                m_axi_arlen    <= 8'h3;         // 4 package
                m_axi_arsize   <= 3'h2;         // 32 bit
                m_axi_arburst  <= 2'h1;
            end
        end
    end


    ///////////////////////////////////////////////////////////////////////////
    // read data channel
    /* TODO1: 给ic_dev_rrdy、dc_dev_rrdy信号赋值（接收到读请求后ready置0，读请求处理完成后置1）*/
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            ic_dev_rrdy <= 1'h1;
            dc_dev_rrdy <= 1'h1;
        end else begin
            // DCache
            if (has_dc_rd_req)
                dc_dev_rrdy <= 1'b0;
            else if (dc_dev_rvalid)
                dc_dev_rrdy <= 1'b1;

            // ICache
            if (has_ic_rd_req && !has_dc_rd_req)
                ic_dev_rrdy <= 1'b0;
            else if (ic_dev_rvalid)
                ic_dev_rrdy <= 1'b1;   
        end
    end


    /* TODO2: 给ic_dev_rvalid、dc_dev_rvalid信号赋值（返回给Cache的数据块就绪后置1）*/
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            ic_dev_rvalid <= 1'h0;
            dc_dev_rvalid <= 1'h0;
        end else begin
            if (m_axi_rvalid && m_axi_rlast && !dc_dev_rrdy) begin
                dc_dev_rvalid <= 1'b1;
            end else if (m_axi_rvalid && m_axi_rlast && !ic_dev_rrdy) begin
                ic_dev_rvalid <= 1'b1;
            end else begin
                dc_dev_rvalid <= 1'b0;
                ic_dev_rvalid <= 1'b0;
            end
        end
    end

    /* TODO3: 从总线上接收读数据，生成DCache重填所需的数据块dc_dev_rdata及ICache重填所需的数据块ic_dev_rdata */
    reg [`CACHE_BLK_SIZE-1:0] read_buffer_reg; // 用于组装128位数据
    reg [1:0] beat_count_reg;                  // 计数四次，一次接受 32 bits，共 128 bits

    always @(*) begin
        ic_dev_rdata = (ic_dev_rvalid) ? read_buffer_reg : {`CACHE_BLK_SIZE{1'b0}};
        dc_dev_rdata = (dc_dev_rvalid) ? read_buffer_reg : {`CACHE_BLK_SIZE{1'b0}};   
    end

    // beat_count_reg 的 always 块
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            beat_count_reg <= 2'b0;
        end else if (m_axi_arvalid && m_axi_arready) begin // AR握手成功，R数据传输即将开始
            beat_count_reg <= 2'b0;
        end else if (m_axi_rvalid && m_axi_rready) begin
            beat_count_reg <= beat_count_reg + 1;          // 接收到数据，计数器加1
        end else 
            beat_count_reg <= 2'b0;
    end

    // read_buffer_reg 的 always 块
    always @(posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            read_buffer_reg <= {`CACHE_BLK_SIZE{1'b0}};  // 复位时清零
        end else if (m_axi_rvalid && m_axi_rready) begin // 正在进行的读事务且AXI数据有效
            case(beat_count_reg)                         // 根据当前是第几包数据，存入缓冲器的对应位置
                2'b00: read_buffer_reg[31:0]    <= m_axi_rdata;
                2'b01: read_buffer_reg[63:32]   <= m_axi_rdata;
                2'b10: read_buffer_reg[95:64]   <= m_axi_rdata;
                2'b11: read_buffer_reg[127:96]  <= m_axi_rdata;
            endcase
        end
    end

    assign m_axi_rready = !aresetn ? 1'b0 : 1'b1;

    /******** 不要修改以下代码 ********/
    ///////////////////////////////////////////////////////////////////////////
    // write address channel
    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            m_axi_awaddr  <= 32'h0;
            m_axi_awvalid <= 1'b0;
        end else begin
            if (m_axi_awvalid & m_axi_awready) begin
                m_axi_awvalid <= 1'b0;
                m_axi_awlen   <= 8'h0;
                m_axi_awsize  <= 3'h0;
                m_axi_awburst <= 2'h0;
            end else if (has_dc_wr_req) begin
                m_axi_awaddr  <= dc_cpu_waddr;
                m_axi_awlen   <= 8'h1 - 1;      // 1 packages each transaction
                m_axi_awsize  <= 3'h2;          // 2^2 bytes per package
                m_axi_awburst <= 2'h1;          // INCR addressing mode
                m_axi_awvalid <= 1'b1;
            end
        end
    end

    ///////////////////////////////////////////////////////////////////////////
    // write data channel
    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            m_axi_wdata  <= 32'h0;
            m_axi_wstrb  <= 4'h0;
            m_axi_wvalid <= 1'b0;
        end else begin
            if (m_axi_wvalid & m_axi_wready) begin
                m_axi_wvalid <= 1'b0;
            end else if (has_dc_wr_req) begin
                m_axi_wdata  <= dc_cpu_wdata;
                m_axi_wstrb  <= dc_cpu_wen;
                m_axi_wvalid <= 1'b1;
            end
        end
    end

    assign m_axi_wlast = m_axi_wvalid;

    ///////////////////////////////////////////////////////////////////////////
    // write response channel
    always @ (posedge aclk or negedge aresetn) begin
        if (!aresetn) begin
            dc_dev_wrdy     <= 1'b1;
        end else begin
            if (m_axi_bvalid) begin
                dc_dev_wrdy <= 1'b1;
            end else if (has_dc_wr_req) begin
                dc_dev_wrdy <= 1'b0;
            end
        end
    end

    assign m_axi_bready = !aresetn ? 1'b0 : 1'b1;

endmodule