`timescale 1ns / 1ps

`include "defines.vh"

// cache
`define CACHE_INDEX_LEN           11 // cache 地址位宽 
`define CACHE_OFFSET_LEN           4 // cache 块内地址位宽，决定数据块大小
`define CACHE_BLKN_IN_GRP_LEN      1 // cache 组内块号位宽
`define CACHE_GRP_NUM_LEN   (`CACHE_INDEX_LEN - `CACHE_OFFSET_LEN - `CACHE_BLKN_IN_GRP_LEN) // cache 组号位宽

// mem
`define MEM_INDEX_LEN  32                                  // 主存地址位宽
`define MEM_OFFSET_LEN (`CACHE_OFFSET_LEN)                 // 主存块内地址位宽，由 cache 块大小决定
`define MEM_BLKN_IN_SECTION_LEN (`CACHE_GRP_NUM_LEN)       // 主存区内块号位宽  
`define MEM_TAG_LEN_LEN (`MEM_INDEX_LEN - `MEM_OFFSET_LEN - `MEM_BLKN_IN_SECTION_LEN) // 主存区号位宽,也是主存 tag 位宽

// important parameters
`define CACHE_LINE_LEN (1 + `MEM_TAG_LEN_LEN + `CACHE_BLK_SIZE)     // cache 块表长度
`define CACHE_GRP_INDEX_MAX ((1 << `CACHE_GRP_NUM_LEN) - 1)         // cache 最大 index，或最大组数减一 

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

    // 参数：实现 2路组相联 映射的L1ICache，数据块大小为128位，Cache容量为2KB；
    // 主存地址位宽：       32
    // cache 地址位宽：    11
    // cache 块内地址位宽： 4

    // 主存：  32 位
    // 31-tag-10, 9-块地址-4, 3-块内地址-0
    // cache: 10-组号-5, 4-组内块号-4, 3-块内地址-0

    // 主存地址分解
    wire [`MEM_TAG_LEN_LEN-1  :0] tag_from_cpu = inst_addr[31:32-`MEM_TAG_LEN_LEN];     // 主存地址的TAG
    // 主存地址的Cache索引 / ICache存储体的地址（块号/组号）
    wire [`CACHE_GRP_NUM_LEN-1:0] cache_index  = inst_addr[`CACHE_OFFSET_LEN+`CACHE_GRP_NUM_LEN-1:`CACHE_OFFSET_LEN];
    wire [`CACHE_OFFSET_LEN-1 :0] offset       = inst_addr[`CACHE_OFFSET_LEN-1:0];     // 32位字偏移量

    // 定义ICache状态机的状态变量
    reg  [1:0] state, next_state;
    localparam IDLE      = 2'b00;
    localparam TAG_CHECK = 2'b01;
    localparam REFILL    = 2'b10;

    // read hit: 需保证命中时，hit信号仅有效1个时钟周期
    wire hit0;
    wire hit1;
    wire hit  = hit0 | hit1;
    
    // read data
    wire [`CACHE_BLK_SIZE-1:0] cache_data_r0;
    wire [`CACHE_BLK_SIZE-1:0] cache_data_r1;
    wire [`CACHE_BLK_SIZE-1:0] hit_data_blk = {`CACHE_BLK_SIZE{hit0}} & cache_data_r0 |
                                              {`CACHE_BLK_SIZE{hit1}} & cache_data_r1;

    wire [31:0] word0 = hit_data_blk[31: 0];
    wire [31:0] word1 = hit_data_blk[63:32];
    wire [31:0] word2 = hit_data_blk[95:64];
    wire [31:0] word3 = hit_data_blk[127:96];
    wire [31:0] selected_word = (offset[`CACHE_OFFSET_LEN-1:2] == 2'h0) ? word0 :
                                (offset[`CACHE_OFFSET_LEN-1:2] == 2'h1) ? word1 :
                                (offset[`CACHE_OFFSET_LEN-1:2] == 2'h2) ? word2 :
                                (offset[`CACHE_OFFSET_LEN-1:2] == 2'h3) ? word3 : 32'b0;    // 访存请求的地址

    // read data: 根据字偏移，选择组内命中的Cache行中的某个32位字作为输出
    always @(*) begin
        inst_valid = (state == TAG_CHECK) ? hit           : 1'b0;
        inst_out   = (state == TAG_CHECK) ? selected_word : 32'b0;
    end
    
    // 记录第i个Cache组内的Cache块的被访问情况（比如块0被访问，则置use_bit[i]为10，块1被访问则置use_bit[i]为01），用于实现Cache块替换
    reg  [1:0] use_bit [`CACHE_GRP_INDEX_MAX:0];

    // write data
    wire replace_way = use_bit[cache_index][1];
    wire cache_we0   = !hit & dev_rvalid & (replace_way == 0);       // ICache存储体0的写使能信号
    wire cache_we1   = !hit & dev_rvalid & (replace_way == 1);       // ICache存储体1的写使能信号

    icache_set_access_unit #(
        .CACHE_BLK_SIZE    	(`CACHE_BLK_SIZE   ),
        .CACHE_TAG_LEN     	(`MEM_TAG_LEN_LEN  ),
        .CACHE_GRP_NUM_LEN 	(`CACHE_GRP_NUM_LEN)
    ) u_icache_set_access_unit0 (
        .cpu_clk             	(cpu_clk              ),
        .cpu_rstn            	(cpu_rstn             ),
        .mem_address_tag     	(tag_from_cpu         ),
        .mem_address_blk_num 	(cache_index          ),
        .cache_we            	(cache_we0            ),
        .cache_data_w        	(dev_rdata            ),
        .cache_hit           	(hit0                 ),
        .cache_data_r        	(cache_data_r0        )
    );
    
    icache_set_access_unit #(
        .CACHE_BLK_SIZE    	(`CACHE_BLK_SIZE   ),
        .CACHE_TAG_LEN     	(`MEM_TAG_LEN_LEN  ),
        .CACHE_GRP_NUM_LEN 	(`CACHE_GRP_NUM_LEN)
    ) u_icache_set_access_unit1 (
        .cpu_clk             	(cpu_clk              ),
        .cpu_rstn            	(cpu_rstn             ),
        .mem_address_tag     	(tag_from_cpu         ),
        .mem_address_blk_num 	(cache_index          ),
        .cache_we            	(cache_we1            ),
        .cache_data_w        	(dev_rdata            ),
        .cache_hit           	(hit1                 ),
        .cache_data_r        	(cache_data_r1        )
    );

    // 状态机现态的更新逻辑
    always @(posedge cpu_clk or negedge cpu_rstn) begin
        if (!cpu_rstn) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    
    // 状态机的状态转移逻辑
    always @(*) begin
        case (state)
            IDLE:       next_state = inst_rreq ? TAG_CHECK : IDLE;
            TAG_CHECK:  next_state = hit ? IDLE : REFILL;
            REFILL:     next_state = dev_rvalid ? TAG_CHECK : REFILL;
        endcase
    end

    // 生成状态机的输出信号：use_bit的更新，以及访存请求（即cpu_raddr和cpu_ren）的生成
    wire [31:0] block_aligned_addr = {inst_addr[31:`CACHE_OFFSET_LEN], {`CACHE_OFFSET_LEN{1'b0}}};
    reg request_sent;
    integer i;
    always @(posedge cpu_clk or negedge cpu_rstn) begin
        if (!cpu_rstn) begin
            for (i = 0; i < `CACHE_GRP_INDEX_MAX + 1; i = i + 1) begin
                use_bit[i] <= 2'b00;
            end
            cpu_ren      <= 4'b0000;
            cpu_raddr    <= 32'b0;
            request_sent <= 1'b0;
        end
        else begin
            case (state)
                IDLE: begin
                    cpu_ren      <= 4'b0000;
                    cpu_raddr    <= 32'b0;
                    request_sent <= 1'b0;
                end
                TAG_CHECK: begin
                    if (hit) begin
                        cpu_ren   <= 4'b0000;
                        cpu_raddr <= 32'b0;
                        use_bit[cache_index] <= {hit0, hit1};
                    end else if (dev_rrdy & !request_sent) begin
                        cpu_ren       <= 4'b1111;
                        cpu_raddr     <= block_aligned_addr;
                        request_sent  <= 1'b1;
                    end
                end
                REFILL: begin
                    if (dev_rrdy & !request_sent) begin
                        cpu_ren       <= 4'b1111;
                        cpu_raddr     <= block_aligned_addr;
                        // ? 是否需要 tag_from_sram <= tag_from_cpu;
                        request_sent  <= 1'b1;
                    end else begin
                        cpu_ren   <= 4'b0000;
                        cpu_raddr <= 32'b0;
                    end
                end
            endcase
        end
    end


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
