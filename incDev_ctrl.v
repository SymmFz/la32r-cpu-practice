`include "mycpu_inst.vh"

// `define EX_ONE_BY_ONE

module incdev_control(
    input  wire         clk           ,
    input  wire         rstn          ,
    // Interface to reference CPU
    output reg          ref_pause     ,
    input  wire         ref_ex_finish ,
    input  wire         ref_excp      ,
    input  wire [31:0]  ref_excp_entry,
    input  wire         ref_spinst    ,
    input  wire [31:0]  ref_spinst_pc ,
    input  wire         ref_br_taken  ,
    input  wire [31:0]  ref_br_target ,
    input  wire [31:0]  ref_wb_pc     ,
    input  wire [31:0]  ref_wb_inst   ,
    input  wire [ 3:0]  ref_wb_we     ,
    input  wire [ 4:0]  ref_wb_rfnum  ,
    input  wire [31:0]  ref_wb_wdata  ,
    // Interface to user CPU
    output wire         usr_ex_flag   ,
    output wire [31:0]  usr_ex_inst   ,
    input  wire         usr_ex_finish ,
    output reg          usr_pc_inc    ,     // update sequence PC when an instruction is unimplemented
    output reg          usr_pc_we     ,     // update branch PC when an instruction is not implemented
    output reg  [31:0]  usr_pc        ,
    output reg          usr_wb_we     ,
    output reg  [31:0]  usr_wb_pc     ,
    output reg  [ 4:0]  usr_wb_wreg   ,
    output reg  [31:0]  usr_wb_wdata  
`ifndef IMPL_TRAP
    ,// to debug interface
    input  wire [31:0]  debug_usr_wb_pc,
    output wire         debug_excp_occur
`endif
);

wire inst_implemented = (`IMPL_LU12I_W    & (ref_wb_inst[31:25] == 7'h0A)    ) |
                        (`IMPL_ADD_W      & (ref_wb_inst[31:15] == 17'h00020)) |
                        (`IMPL_ADDI_W     & (ref_wb_inst[31:22] == 10'h00A)  ) |
                        (`IMPL_SUB_W      & (ref_wb_inst[31:15] == 17'h00022)) |
                        (`IMPL_SLT        & (ref_wb_inst[31:15] == 17'h00024)) |
                        (`IMPL_SLTU       & (ref_wb_inst[31:15] == 17'h00025)) |
                        (`IMPL_AND        & (ref_wb_inst[31:15] == 17'h00029)) |
                        (`IMPL_OR         & (ref_wb_inst[31:15] == 17'h0002A)) |
                        (`IMPL_XOR        & (ref_wb_inst[31:15] == 17'h0002B)) |
                        (`IMPL_NOR        & (ref_wb_inst[31:15] == 17'h00028)) |
                        (`IMPL_SLLI_W     & (ref_wb_inst[31:15] == 17'h00081)) |
                        (`IMPL_SRLI_W     & (ref_wb_inst[31:15] == 17'h00089)) |
                        (`IMPL_SRAI_W     & (ref_wb_inst[31:15] == 17'h00091)) |
                        (`IMPL_LD_W       & (ref_wb_inst[31:22] == 10'h0A2)  ) |
                        (`IMPL_ST_W       & (ref_wb_inst[31:22] == 10'h0A6)  ) |
                        (`IMPL_BEQ        & (ref_wb_inst[31:26] == 6'h16)    ) |
                        (`IMPL_BNE        & (ref_wb_inst[31:26] == 6'h17)    ) |
                        (`IMPL_BL         & (ref_wb_inst[31:26] == 6'h15)    ) |
                        (`IMPL_JIRL       & (ref_wb_inst[31:26] == 6'h13)    ) |
                        (`IMPL_B          & (ref_wb_inst[31:26] == 6'h14)    ) |
                        (`IMPL_PCADDU12I  & (ref_wb_inst[31:25] == 7'h0E)    ) |
                        (`IMPL_SLTI       & (ref_wb_inst[31:22] == 10'h008)  ) |
                        (`IMPL_SLTUI      & (ref_wb_inst[31:22] == 10'h009)  ) |
                        (`IMPL_ANDI       & (ref_wb_inst[31:22] == 10'h00D)  ) |
                        (`IMPL_ORI        & (ref_wb_inst[31:22] == 10'h00E)  ) |
                        (`IMPL_XORI       & (ref_wb_inst[31:22] == 10'h00F)  ) |
                        (`IMPL_SLL_W      & (ref_wb_inst[31:15] == 17'h0002E)) |
                        (`IMPL_SRA_W      & (ref_wb_inst[31:15] == 17'h00030)) |
                        (`IMPL_SRL_W      & (ref_wb_inst[31:15] == 17'h0002F)) |
                        (`IMPL_DIV_W      & (ref_wb_inst[31:15] == 17'h00040)) |
                        (`IMPL_DIV_WU     & (ref_wb_inst[31:15] == 17'h00042)) |
                        (`IMPL_MUL_W      & (ref_wb_inst[31:15] == 17'h00038)) |
                        (`IMPL_MULH_W     & (ref_wb_inst[31:15] == 17'h00039)) |
                        (`IMPL_MULH_WU    & (ref_wb_inst[31:15] == 17'h0003A)) |
                        (`IMPL_MOD_W      & (ref_wb_inst[31:15] == 17'h00041)) |
                        (`IMPL_MOD_WU     & (ref_wb_inst[31:15] == 17'h00043)) |
                        (`IMPL_BLT        & (ref_wb_inst[31:26] == 6'h18)    ) |
                        (`IMPL_BGE        & (ref_wb_inst[31:26] == 6'h19)    ) |
                        (`IMPL_BLTU       & (ref_wb_inst[31:26] == 6'h1A)    ) |
                        (`IMPL_BGEU       & (ref_wb_inst[31:26] == 6'h1B)    ) |
                        (`IMPL_LD_B       & (ref_wb_inst[31:22] == 10'h0A0)  ) |
                        (`IMPL_LD_H       & (ref_wb_inst[31:22] == 10'h0A1)  ) |
                        (`IMPL_LD_BU      & (ref_wb_inst[31:22] == 10'h0A8)  ) |
                        (`IMPL_LD_HU      & (ref_wb_inst[31:22] == 10'h0A9)  ) |
                        (`IMPL_ST_B       & (ref_wb_inst[31:22] == 10'h0A4)  ) |
                        (`IMPL_ST_H       & (ref_wb_inst[31:22] == 10'h0A5)  ) |
                        (`IMPL_EX_SYSCALL & (ref_wb_inst[31:15] == 17'h00056)) |
                        (`IMPL_EX_BREAK   & (ref_wb_inst[31:15] == 17'h00054));

reg [7:0] usr_ex_cnt;
`ifdef EX_ONE_BY_ONE
wire      usr_ex_cnt_inc_f = ex_flag;
`else
wire      usr_ex_cnt_inc_f = usr_ex_flag;
`endif
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        usr_ex_cnt <= 8'h0;
        ref_pause  <= 1'b0;
    end else begin
        if (usr_ex_cnt_inc_f ^ usr_ex_finish) begin
            if (usr_ex_cnt_inc_f) usr_ex_cnt <= usr_ex_cnt + 8'h1;
            if (usr_ex_finish)    usr_ex_cnt <= usr_ex_cnt - 8'h1;
        end
        if (usr_ex_finish & (usr_ex_cnt == 8'h1)) begin
            ref_pause <= 1'b0;
        end else if (ref_ex_finish & inst_implemented) begin
            ref_pause <= 1'b1;
        end
    end
end

reg        usr_wb_we_buf;
reg [31:0] usr_wb_pc_buf;
reg [ 4:0] usr_wb_wreg_buf;
reg [31:0] usr_wb_wdata_buf;
reg        ex_flag;
reg [31:0] ex_inst;
reg        usr_ex_flag_r;
wire       ex_flag_f = ex_flag & usr_ex_flag_r;
always @(posedge clk) usr_ex_flag_r <= ex_flag;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        ex_flag       <= 1'b0;
        usr_wb_we     <= 1'b0;
        usr_wb_we_buf <= 1'b0;
    end else begin
        if (ex_flag)   ex_flag   <= 1'b0;
        if (usr_wb_we) usr_wb_we <= 1'b0;

        // if (ref_ex_finish) begin
        //     if (inst_implemented) begin
        //         usr_ex_flag      <= 1'b1;
        //         usr_ex_inst      <= ref_wb_inst;
        //     end else begin
        //         if (!ref_pause) begin
        //             usr_wb_we        <= |ref_wb_we;
        //             usr_wb_pc        <= ref_wb_pc;
        //             usr_wb_wreg      <= ref_wb_rfnum;
        //             usr_wb_wdata     <= ref_wb_wdata;
        //         end else begin
        //             usr_wb_we_buf    <= |ref_wb_we;
        //             usr_wb_pc_buf    <= ref_wb_pc;
        //             usr_wb_wreg_buf  <= ref_wb_rfnum;
        //             usr_wb_wdata_buf <= ref_wb_wdata;
        //         end
        //     end
        // end

        if (ref_ex_finish & inst_implemented) begin
            ex_flag <= 1'b1;
            ex_inst <= ref_wb_inst;
        end

        // Buffer usr's ArchStat update operation when usr's CPU is executing some inst
        if (ref_pause & (ref_ex_finish & !inst_implemented)) begin
            usr_wb_we_buf    <= |ref_wb_we;
            usr_wb_pc_buf    <= ref_wb_pc;
            usr_wb_wreg_buf  <= ref_wb_rfnum;
            usr_wb_wdata_buf <= ref_wb_wdata;
        end

        if (!ref_pause & (ref_ex_finish & !inst_implemented | usr_wb_we_buf)) begin
            usr_wb_we        <= usr_wb_we_buf ? usr_wb_we_buf    : |ref_wb_we;
            usr_wb_pc        <= usr_wb_we_buf ? usr_wb_pc_buf    : ref_wb_pc;
            usr_wb_wreg      <= usr_wb_we_buf ? usr_wb_wreg_buf  : ref_wb_rfnum;
            usr_wb_wdata     <= usr_wb_we_buf ? usr_wb_wdata_buf : ref_wb_wdata;
            usr_wb_we_buf    <= 1'b0;
        end
    end
end

`ifdef EX_ONE_BY_ONE

wire fifo_full;
wire fifo_empty;
reg  fifo_empty_r;
reg  first_req_sent;
wire negedge_fifo_empty = fifo_empty_r & !fifo_empty;
always @(posedge clk or negedge rstn) begin 
    fifo_empty_r <= fifo_empty;
    if (negedge_fifo_empty)    first_req_sent <= 1'b1;
    if (!rstn | usr_ex_finish) first_req_sent <= 1'b0;
end
assign usr_ex_flag = !fifo_empty & (!first_req_sent & negedge_fifo_empty | usr_ex_finish);
fifo_generator_0 U_usr_ex_fifo (
    .srst (!rstn      ),
    .clk  (clk        ),
    .wr_en(ex_flag    ),
    .din  (ex_inst    ),
    .full (fifo_full  ),
    .rd_en(usr_ex_flag),
    .dout (usr_ex_inst),
    .empty(fifo_empty )
);

`else
assign usr_ex_flag = ex_flag;
assign usr_ex_inst = ex_inst;
`endif

wire usr_pc_inc_flag = ref_ex_finish & !inst_implemented & !ref_br_taken;
reg  usr_pc_inc_buf;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        usr_pc_inc     <= 1'b0;
        usr_pc_inc_buf <= 1'b0;
    end else begin
        if (usr_pc_inc) usr_pc_inc <= 1'b0;

        // Buffer usr's pc increasing operation when usr's CPU is executing some inst
        if (ref_pause & usr_pc_inc_flag)
            usr_pc_inc_buf <= 1'b1;

        if (!ref_pause & (usr_pc_inc_flag | usr_pc_inc_buf)) begin
            usr_pc_inc     <= 1'b1;
            usr_pc_inc_buf <= 1'b0;
        end
    end
end

reg usr_pc_we_buf;
reg excp_while_br;
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        usr_pc_we     <= 1'b0;
        usr_pc_we_buf <= 1'b0;
        excp_while_br <= 1'b0;
    end else begin
        // Hold usr_pc_we when exception occurs during execution of branch or jmp inst
        if (ref_ex_finish & usr_pc_we | !ref_excp & !ref_spinst & !ref_br_taken) usr_pc_we <= 1'b0;
        if (ref_ex_finish & excp_while_br) excp_while_br <= 1'b0;

        if (usr_ex_finish & usr_pc_we_buf) begin
            usr_pc_we     <= 1'b1;
            usr_pc_we_buf <= 1'b0;
        end

        if (ref_ex_finish & ref_excp) begin
            if (inst_implemented)       // If an implemented inst is executing while exception occurs in ref CPU,
                usr_pc_we_buf <= 1'b1;  // delay PC-writing operation until the execution finishes.
            else
                usr_pc_we     <= 1'b1;

            usr_pc    <= ref_excp_entry;
        end

        if (/*ref_ex_finish &*/ !inst_implemented) begin
            if (ref_spinst) begin
                usr_pc_we <= 1'b1;
                usr_pc    <= ref_spinst_pc;
            end else if (ref_br_taken) begin
                // hold usr_pc_we util usr's CPU finishes the current execution
                usr_pc_we <= !ex_flag & (usr_ex_cnt == 'h0) ? 1'b1 : 1'b0;
                usr_pc    <= (ref_excp | excp_while_br) ? ref_excp_entry : ref_br_target;
                
                if (ref_excp) excp_while_br <= 1'b1;
            end
        end
    end
end

`ifndef IMPL_TRAP

localparam USR_PL_STAGE = 8'd5;
localparam CNT_MAX      = USR_PL_STAGE - 8'd2;
reg        cnt_inc_flag;
reg [ 7:0] excp_cnt;
reg        debug_excp_flag;
reg [31:0] debug_excp_pc;
wire       debug_excp_pc_match = (debug_usr_wb_pc == debug_excp_pc);
wire       debug_excp_detected = debug_excp_flag & debug_excp_pc_match;
assign     debug_excp_occur    = debug_excp_detected | cnt_inc_flag;

always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        debug_excp_flag <= 1'b0;
        debug_excp_pc   <= 32'h0;
        cnt_inc_flag    <= 1'b0;
        excp_cnt        <= 8'h7F;
    end else begin
        if (usr_ex_finish & debug_excp_pc_match) begin
            debug_excp_flag <= 1'b0;
            debug_excp_pc   <= debug_excp_pc;
        end else if (inst_implemented & ref_ex_finish & ref_excp) begin
            debug_excp_flag <= 1'b1;
            debug_excp_pc   <= ref_wb_pc;
        end

        if (debug_excp_detected) begin
            cnt_inc_flag <= 1'b1;
            excp_cnt     <= 8'h0;
        end
        if (cnt_inc_flag)
            if (excp_cnt >= CNT_MAX) begin
                cnt_inc_flag <= 1'b0;
                excp_cnt     <= 8'h7F;
            end else
                excp_cnt     <= excp_cnt + 8'h1;
    end
end

`endif

endmodule