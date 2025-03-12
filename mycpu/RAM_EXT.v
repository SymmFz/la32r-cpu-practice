`timescale 1ns / 1ps

`include "defines.vh"

module RAM_EXT (
    input  wire [31:0]  din        ,    // 从内存中读取的原始数据
    input  wire [ 1:0]  byte_offset,    // 访存地址最低2位
    input  wire [ 2:0]  ram_ext_op ,    // 控制扩展方式
    output reg  [31:0]  ext_out         // 扩展后的数据
);

// 根据字节偏移量，选出实际要访问的字节或半字
reg [31:0] real_din;
always @(*) begin
    case (byte_offset)
        2'b01  : real_din = { 8'h0, din[31: 8]};
        2'b10  : real_din = {16'h0, din[31:16]};
        2'b11  : real_din = {24'h0, din[31:24]};
        default: real_din = din;
    endcase
end

// 根据ram_ext_op对读取的数据作不同的扩展操作（主要针对lb、lbu、lh、lhu指令）
always @(*) begin
    case (ram_ext_op)
        `RAM_EXT_H: ext_out = {{16{real_din[15]}}, real_din[15:0]};
        default   : ext_out = real_din;
    endcase
end

endmodule
