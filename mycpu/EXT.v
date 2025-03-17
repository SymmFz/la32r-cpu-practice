`timescale 1ns / 1ps

`include "defines.vh"

module EXT (
    input  wire [25:0] din,
    input  wire [ 2:0] ext_op,
    output reg  [31:0] ext
);

// 根据ext_op完成不同的立即数扩展操作
always @(*) begin
    case (ext_op)
        `EXT_20: ext = {din[24:5],12'h000};
        `EXT_12: ext = {{20{din[21]}}, din[21:10]};     // 某种符号拓展
        `EXT_5:  ext = {{27{1'b0}}, din[14:10]};
        default: ext = {6'h0, din};
    endcase
end

endmodule
