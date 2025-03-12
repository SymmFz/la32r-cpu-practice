`timescale 1ns / 1ps

`include "defines.vh"

module RF (
    input  wire         cpu_clk,
    input  wire [ 4:0]  rR1,
    input  wire [ 4:0]  rR2,
    input  wire [ 4:0]  wR,
    input  wire         we,
    input  wire [31:0]  wD,
    output reg  [31:0]  rD1,
    output reg  [31:0]  rD2,

    // inc_dev
    input  wire         sync_we,
    input  wire [ 4:0]  sync_dst,
    input  wire [31:0]  sync_val
);

reg [31:0] r [31:1];

always @(posedge cpu_clk) begin
    /***** inc_dev ******/
    if (sync_we) begin
        r[sync_dst] <= sync_val;
    /***** inc_dev ******/
    end else if (we & (wR != 5'h0)) begin   // 0号寄存器永远为0且只读不可写
        r[wR] <= wD;
    end
end

always @(*) begin
    rD1 = (rR1 == 5'h0) ? 32'h0 : r[rR1];
    rD2 = (rR2 == 5'h0) ? 32'h0 : r[rR2];
end

endmodule
