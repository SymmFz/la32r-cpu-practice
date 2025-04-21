`timescale 1ns / 1ps

`define BHT_IDX_W 13                    // 表索引位宽
`define BHT_ENTRY (1 << `BHT_IDX_W)     // 表项个数
`define BHT_TAG_W 12                    // tag字段位宽

`define BHT_IDX_OFFSET_LENGHT 5         // 表索引偏移量位宽
`define BHT_IDX_XOR_LENGHT   (`BHT_IDX_W - `BHT_IDX_OFFSET_LENGHT) // 表索引异或位宽 

`define STRONGLY_NOT_TAKEN 2'b00
`define WEAKLY_NOT_TAKEN   2'b01 
`define WEAKLY_TAKEN       2'b10 
`define STRONGLY_TAKEN     2'b11 

module BPU (
    input  wire         cpu_clk    ,
    input  wire         cpu_rstn   ,
    input  wire [31:0]  if_pc      ,        // IF阶段PC
    // predict branch direction and target
    output wire [31:0]  pred_target,        // 预测目标地址
    output wire         pred_error ,        // 是否预测错误
    // signals to update BHT and BTB
    input  wire         id_valid   ,        // ID阶段有效信号
    input  wire         id_is_bj   ,        // ID阶段是否是分支跳转指令
    input  wire [31:0]  id_pc      ,        // ID阶段PC
    input  wire         real_taken ,        // ID阶段得到的真实跳转方向
    input  wire [31:0]  real_target         // ID阶段得到的真实目标地址
);

// BHT and BTB
reg  [`BHT_TAG_W-1:0] tag     [`BHT_ENTRY-1:0];
reg  [`BHT_ENTRY-1:0] valid;
reg  [           1:0] history [`BHT_ENTRY-1:0];
reg  [          31:0] target  [`BHT_ENTRY-1:0];

wire [`BHT_TAG_W-1:0] if_tag = if_pc[31:32 - `BHT_TAG_W];      // IF阶段指令地址标签
wire [`BHT_TAG_W-1:0] ID_tag = id_pc[31:32 - `BHT_TAG_W];      // ID阶段指令地址标签

// 异或地址折叠
wire [          31:0] pc_hash = {if_pc[31:3*`BHT_IDX_XOR_LENGHT+`BHT_IDX_OFFSET_LENGHT+2], 
                                if_pc[`BHT_IDX_XOR_LENGHT+`BHT_IDX_OFFSET_LENGHT+1:`BHT_IDX_OFFSET_LENGHT+2] ^ 
                                if_pc[2*`BHT_IDX_XOR_LENGHT+`BHT_IDX_OFFSET_LENGHT+1:`BHT_IDX_XOR_LENGHT+`BHT_IDX_OFFSET_LENGHT+2] ^
                                if_pc[3*`BHT_IDX_XOR_LENGHT+`BHT_IDX_OFFSET_LENGHT+1:2*`BHT_IDX_XOR_LENGHT+`BHT_IDX_OFFSET_LENGHT+2],
                                if_pc[`BHT_IDX_OFFSET_LENGHT+1:0]};

wire [`BHT_IDX_W-1:0] index   = pc_hash[`BHT_IDX_W+1:2];    // 表索引

wire   pred_taken  = valid[index] & history[index][1] & (tag[index] == if_tag); // 生成预测跳转方向
assign pred_target = (pred_taken) ? target[index] : if_pc + 32'h4;                // 生成预测跳转的目标地址

// 假设在ID阶段才能判断分支跳转是否错误，故需把IF阶段的预测信号缓存起来
reg  [`BHT_IDX_W-1:0] id_index      ;
reg                   id_pred_taken ;
reg  [          31:0] id_pred_target;
always @(posedge cpu_clk or negedge cpu_rstn) begin
    if (!cpu_rstn) begin
        id_index       <= {`BHT_IDX_W{1'b0}};
        id_pred_taken  <= 1'b0;
        id_pred_target <= 32'h0;
    end else begin
        id_index       <= index;
        id_pred_taken  <= pred_taken;
        id_pred_target <= pred_target;
    end
end


// 检测分支跳转方向是否预测错误
wire taken_error  = (id_is_bj & (id_pred_taken ^ real_taken)) | // 检测分支跳转方向是否预测错误
                    (!id_is_bj & id_pred_taken);                // 检测分支跳转方向是否预测错误

wire target_error = id_is_bj & (id_pred_target != real_target);            // 检测目标地址是否预测错误

assign pred_error = id_valid & (taken_error | target_error);

wire add_entry     = id_valid & id_is_bj & !valid[id_index] & real_taken;     // 判断何种情形需要在BHT和BTB中新增表项
wire update_entry  = id_valid & id_is_bj & valid[id_index] & (tag[id_index] == ID_tag);                  // 判断何种情形需要更新BHT和BTB的现有表项
wire replace_entry = id_valid & id_is_bj & valid[id_index] & (tag[id_index] != ID_tag) & real_taken;     // 判断何种情形需要替换BHT和BTB的现有表项

// Update BHT and BTB
integer i;
always @(posedge cpu_clk or negedge cpu_rstn) begin
    if (!cpu_rstn) begin
        valid <= {`BHT_ENTRY{1'b0}};
        for (i = 0; i < `BHT_ENTRY; i = i + 1)
            history[i] <= 2'b10;
    end else begin
        // 根据add_entry、update_entry和replace_entry更新BHT和BTB表项
        if (add_entry) begin
            valid[id_index]   <= 1'b1;
            tag[id_index]     <= ID_tag;
            history[id_index] <= `WEAKLY_TAKEN;
            target[id_index]  <= real_target;
        end
        else if (update_entry) begin
            if (real_taken) begin
                if (history[id_index] == `STRONGLY_NOT_TAKEN) begin
                    history[id_index] <= `WEAKLY_NOT_TAKEN;
                end else if (history[id_index] == `WEAKLY_NOT_TAKEN) begin
                    history[id_index] <= `STRONGLY_TAKEN;
                end else if (history[id_index] == `WEAKLY_TAKEN) begin
                    history[id_index] <= `STRONGLY_TAKEN;
                end else if (history[id_index] == `STRONGLY_TAKEN) begin
                    history[id_index] <= `STRONGLY_TAKEN;
                end
            end else begin
                if (history[id_index] == `STRONGLY_TAKEN) begin
                    history[id_index] <= `WEAKLY_TAKEN;
                end else if (history[id_index] == `WEAKLY_TAKEN) begin
                    history[id_index] <= `STRONGLY_NOT_TAKEN;
                end else if (history[id_index] == `WEAKLY_NOT_TAKEN) begin
                    history[id_index] <= `STRONGLY_NOT_TAKEN;
                end else if (history[id_index] == `STRONGLY_NOT_TAKEN) begin
                    history[id_index] <= `STRONGLY_NOT_TAKEN;
                end
            end

            if (((!id_pred_taken) & real_taken) | 
                (id_pred_taken & real_taken & (id_pred_target != real_target))) begin
                target[id_index] <= real_target;
            end
        end
        else if (replace_entry) begin
            tag[id_index]     <= ID_tag;
            target[id_index]  <= real_target;
            history[id_index] <= `WEAKLY_TAKEN;
        end
    end
end

endmodule
