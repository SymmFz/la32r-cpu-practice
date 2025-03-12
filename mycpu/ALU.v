`timescale 1ns / 1ps

`include "defines.vh"

module ALU (
    input  wire [31:0]  A,
    input  wire [31:0]  B,
    input  wire [ 4:0]  alu_op,
    output reg  [31:0]  C
);

// 根据alu_op完成不同的运算操作
always @(*) begin
    case (alu_op)
        `ALU_ADD: C = A + B;
        default : C = A + B;
    endcase
end

endmodule
