`timescale 1ns / 1ps

`include "defines.vh"

module icache_set_access_unit#(
    parameter CACHE_BLK_SIZE    = `CACHE_BLK_SIZE,  // cache 块大小
    parameter CACHE_TAG_LEN     = 22,               // cache 块标签位宽
    parameter CACHE_GRP_NUM_LEN = 6                 // cache 组号位宽
)(
    input  wire                         cpu_clk,
    input  wire                         cpu_rstn,

    input  wire [CACHE_TAG_LEN-1:0]     mem_address_tag,       // 主存地址的TAG
    input  wire [CACHE_GRP_NUM_LEN-1:0] mem_address_blk_num,   // 主存块号

    input  wire                         cache_we,
    input  wire [`CACHE_BLK_SIZE-1:0]   cache_data_w,          // 写入 cache 的数据

    output wire                         cache_hit,             // cache 命中信号
    output wire [CACHE_BLK_SIZE-1:0]    cache_data_r           // 从 cache 中读出的数据
);

    // read from cache
    wire [1+CACHE_TAG_LEN+`CACHE_BLK_SIZE-1:0] cache_line_r;

    wire valid_bit = cache_line_r[1+CACHE_TAG_LEN+`CACHE_BLK_SIZE-1];
    wire [CACHE_TAG_LEN-1:0] tag_from_cache = cache_line_r[1+CACHE_TAG_LEN+`CACHE_BLK_SIZE-1-1:CACHE_BLK_SIZE];

    assign cache_hit    = valid_bit & (mem_address_tag == tag_from_cache);
    assign cache_data_r = cache_line_r[`CACHE_BLK_SIZE-1:0];

    // write to cache
    wire [1+CACHE_TAG_LEN+`CACHE_BLK_SIZE-1:0] cache_line_w = {
        1'b1, mem_address_tag, cache_data_w
    };

    // ICache存储体：Block MEM IP核
    blk_mem_gen_1 U_isram (
        .clka   (cpu_clk),
        .wea    (cache_we),
        .addra  (mem_address_blk_num),
        .dina   (cache_line_w),
        .douta  (cache_line_r)
    );

endmodule