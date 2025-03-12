`timescale 1ns / 1ps

`include "defines.vh"

module IF_ID (
    input  wire         cpu_clk,
    input  wire         cpu_rstn,
    input  wire         suspend,
    input  wire         valid_in,

    input  wire[31:0]   pc_in,
    input  wire[31:0]   pc4_in,
    input  wire[31:0]   inst_in,
    
    output reg          valid_out,
    output reg [31:0]   pc_out,
    output reg [31:0]   pc4_out,
    output reg [31:0]   inst_out
);

always @(posedge cpu_clk) begin
    valid_out <= !cpu_rstn ?  1'h0 : suspend ? valid_out : valid_in;
    pc_out    <= !cpu_rstn ? 32'h0 : suspend ? pc_out    : pc_in;
    pc4_out   <= !cpu_rstn ? 32'h0 : suspend ? pc4_out   : pc4_in;
    inst_out  <= !cpu_rstn ? 32'h0 : suspend ? inst_out  : inst_in;
end

endmodule
