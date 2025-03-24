`timescale 1ns / 1ps

`include "defines.vh"

module MEM_REQ (
    input  wire         clk,
    input  wire         rstn,
    input  wire         ex_valid,
    input  wire [ 1:0]  mem_wd_sel,
    input  wire [31:0]  mem_ram_addr,

    input  wire [ 2:0]  mem_ram_ext_op,
    output reg  [ 3:0]  da_ren,
    output reg  [31:0]  da_addr,

    input  wire [ 3:0]  mem_ram_we,
    input  wire [31:0]  mem_ram_wdata,
    output reg  [ 3:0]  da_wen,
    output reg  [31:0]  da_wdata
);

// send_ldst_req用于确保读写请求只有效一个clk
reg        send_ldst_req;       // only valid in the first clk of mem stage
wire [1:0] offset = mem_ram_addr[1:0];

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        send_ldst_req <= 1'b0;
        da_ren        <= 4'h0;
        da_wen        <= 4'h0;
    end else begin
        send_ldst_req <= ex_valid;
        if (da_ren != 4'h0) da_ren  <= 4'h0;
        if (da_wen != 4'h0) da_wen  <= 4'h0;

        // 通过mem_wd_sel的值判断当前是否是访存指令
        if (send_ldst_req & (mem_wd_sel == `WD_RAM)) begin
            
            da_addr <= {mem_ram_addr[31:2], 2'h0};          // 访存地址按字对齐
            da_wdata<= mem_ram_wdata;                       // ? 有待核查
            
            // 通过mem_ram_we判断指令是store还是load，如果是store，具体是哪一条store
            case (mem_ram_we)
                `RAM_WE_B: begin
                    case (offset)
                        2'b00:  da_wen <= 4'b0001;
                        2'b01:  da_wen <= 4'b0010;
                        2'b10:  da_wen <= 4'b0100;
                        2'b11:  da_wen <= 4'b1000;
                        default:da_wen <= 4'b0000;
                    endcase
                end
                `RAM_WE_H: begin
                    case (offset)
                        2'b00:  da_wen <= 4'b0011;
                        2'b10:  da_wen <= 4'b1100;
                        default:da_wen <= 4'b0000;
                    endcase
                end
                `RAM_WE_W: begin
                    case (offset)
                        2'b00:  da_wen <= 4'b1111;
                        default:da_wen <= 4'b0000;
                end
                default: begin              // load 类指令
                    // 通过mem_ram_ext_op判断load指令具体是哪一条load
                    case (mem_ram_ext_op)
                        `RAM_EXT_B : da_ren <= 4'hF;
                        `RAM_EXT_BU: da_ren <= 4'hF;
                        `RAM_EXT_H :                        // ld.h
                            if (offset == 2'h0 || offset == 2'h2)
                                da_ren <= 4'hF;
                        `RAM_EXT_HU:                        // ld.h
                            if (offset == 2'h0 || offset == 2'h2)
                                da_ren <= 4'hF;
                        default:                            // ld.w
                            if (offset == 2'h0)
                                da_ren <= 4'hF;
                    endcase
                end
            endcase
        end
    end
end

endmodule
