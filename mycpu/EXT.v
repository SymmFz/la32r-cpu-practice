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
        `EXT_20: ext = {din[24:5],12'h000};             // 1RI20 型指令的左移12位拓展
        `EXT_12: ext = {{20{din[21]}}, din[21:10]};     // 2RI12 型指令的符号拓展
        `EXT_12Z:ext = {{20{1'b0}},    din[21:10]};     // 2RI12 型指令的零拓展
        `EXT_5:  ext = {{27{1'b0}}, din[14:10]};
        `EXT_2RI16: ext = {{14{din[25]}}, din[25:10], 2'b00};               // 2RI16 型指令的符号拓展(分支、拓展指令的 offset)
        `EXT_I26:   ext = {{4{din[9]}},   din[9:0],   din[25:10], 2'b00};   // I26 型指令的符号拓展(分支、跳转指令的 offset)
        default: ext = {6'h0, din};
    endcase
end

endmodule
