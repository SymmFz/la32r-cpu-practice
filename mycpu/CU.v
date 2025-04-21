`timescale 1ns / 1ps

`include "defines.vh"

module CU (
    input  wire [16:0]  din,            // 指令码的高17位，下标从15开始
    output reg  [ 1:0]  npc_op,         // 控制下一条指令的PC值
    output reg  [ 2:0]  ext_op,         // 控制立即数扩展方式
    output reg  [ 2:0]  ram_ext_op,     // 控制读主存数据的扩展方式（针对load指令）
    output reg  [ 4:0]  alu_op,         // 控制运算类型
    output reg          rf_we,          // 控制是否写回寄存器堆
    output reg  [ 3:0]  ram_we,         // 写主存的写使能信号（针对store指令）
    output wire         r2_sel,         // 控制源寄存器2的选择
    output wire         wr_sel,         // 控制目的寄存器的选择
    output reg  [ 1:0]  wd_sel,         // 控制写回数据源
    output reg          rR1_re,         // 指令是否读取rR1，用于检测数据冒险
    output reg          rR2_re,         // 指令是否读取rR2，用于检测数据冒险
    output reg  [ 1:0]  alua_sel,       // 选择ALU操作数A的来源
    output reg          alub_sel,       // 选择ALU操作数B的来源

    output wire         id_is_br_jump   // id 阶段是否是分支或跳转指令
);

assign id_is_br_jump = din[15];
wire inst_is_b_bl = din[15:12] == 4'b1010;           // I26 型指令（b or bl）  
wire inst_is_jirl = din[15:11] == `FR5_JIRL;         // jirl 指令
wire inst_is_jump   = inst_is_b_bl | inst_is_jirl;   // 无条件跳转指令
wire inst_is_branch = id_is_br_jump & !inst_is_jump;   // 有条件跳转指令

always @(*) begin
    if (id_is_br_jump && inst_is_jirl)
        npc_op = `NPC_JIRL_JUMP;     // jirl 指令的跳转目标地址
    else if (id_is_br_jump)
        npc_op = `NPC_JUMP;          // 其他分支、跳转指令的跳转目标地址
    else 
        npc_op = `NPC_PC4;           // 顺序执行的下一条指令地址
end

always @(*) begin
    if (id_is_br_jump) begin
        ext_op = inst_is_b_bl ? `EXT_I26 : `EXT_2RI16; // 选择分支、跳转指令的立即数扩展方式
    end
    else begin
        case (din[15:13])
            3'b001 : ext_op=`EXT_20;            // 匹配四头 1RI20 类型的指令
            3'b000 : begin
                if (!din[10]) begin
                    if (!din[7]) begin          // 匹配到所有 3R 类型的指令
                        ext_op = `EXT_NONE;
                    end else begin              // 匹配到所有 2RI5 类型的指令
                        ext_op = `EXT_5;
                    end
                end else begin                  // 匹配除 load/store 指令外的所有 2RI12 类型指令
                    case (din[9:7])
                        `FR3_ADDI:   ext_op = `EXT_12;
                        `FR3_ANDI:   ext_op = `EXT_12Z;
                        `FR3_ORI :   ext_op = `EXT_12Z;
                        `FR3_XORI:   ext_op = `EXT_12Z;
                        `FR3_SLTI:   ext_op = `EXT_12;
                        `FR3_SLTUI:  ext_op = `EXT_12;
                        default:     ext_op = `EXT_NONE;
                    endcase
                end
            end
            3'b010 : ext_op = `EXT_12;          // 匹配所有访存指令
            default: ext_op=`EXT_NONE;
        endcase
    end
end

always @(*) begin
    case (din[15:13])
        3'b010: begin       // 锁定所有访存类指令
            case (din[10:7])
                4'b0000: ram_ext_op = `RAM_EXT_B;       // ld.b
                4'b1000: ram_ext_op = `RAM_EXT_BU;      // ld.bu
                4'b0001: ram_ext_op = `RAM_EXT_H;       // ld.h
                4'b1001: ram_ext_op = `RAM_EXT_HU;      // ld.hu
                default: ram_ext_op = `RAM_EXT_N;       // ld.w & store inst
            endcase
        end
        default: ram_ext_op = `RAM_EXT_N;
    endcase
end

always @(*) begin
    case (din[15:13])
        3'b000: begin
            if (!din[10]) begin
                if (!din[7]) begin
                    // * 选中所有的 3R 类型指令的情况
                    case (din[4:0])
                        `FR5_ADD: alu_op = `ALU_ADD;
                        `FR5_SUB: alu_op = `ALU_SUB;
                        `FR5_AND: alu_op = `ALU_AND;
                        `FR5_OR:  alu_op = `ALU_OR;
                        `FR5_XOR: alu_op = `ALU_XOR;
                        `FR5_NOR: alu_op = `ALU_NOR;
                        `FR5_SLL: alu_op = `ALU_SLL;
                        `FR5_SRL: alu_op = `ALU_SRL;
                        `FR5_SRA: alu_op = `ALU_SRA;
                        `FR5_SLT: alu_op = `ALU_SLT;
                        `FR5_SLTU:alu_op = `ALU_SLTU;
                        default : alu_op = `ALU_ADD;
                    endcase
                end else begin
                    // * 选中所有 2RI5 型指令的情况
                    case (din[4:0])
                        `FR5_SLLI: alu_op = `ALU_SLL;
                        `FR5_SRLI: alu_op = `ALU_SRL;
                        `FR5_SRAI: alu_op = `ALU_SRA;
                        default:   alu_op = `ALU_ADD;
                    endcase
                end
            end else begin              // 匹配除 load/store 指令外的所有 2RI12 类型指令
                case (din[9:7])
                    `FR3_ADDI:   alu_op = `ALU_ADD;
                    `FR3_ANDI:   alu_op = `ALU_AND;
                    `FR3_ORI :   alu_op = `ALU_OR;
                    `FR3_XORI:   alu_op = `ALU_XOR;
                    `FR3_SLTI:   alu_op = `ALU_SLT;
                    `FR3_SLTUI:  alu_op = `ALU_SLTU;
                    default:     alu_op = `ALU_ADD;
                endcase
            end
        end
        3'b001: begin                   // 匹配所有 1RI20 型指令
            if (!din[12]) begin         // 匹配 lu12i.w 指令
                alu_op = `ALU_OR;
            end else begin              // 匹配 pcaddu12i 指令
                alu_op = `ALU_ADD;
            end
        end
        default: alu_op=`ALU_ADD;
    endcase
end

always @(*) begin
    if (id_is_br_jump) begin
        case (din[15:11])
            `FR5_BL:   rf_we = 1'b1;       // bl 指令写回寄存器堆
            `FR5_JIRL: rf_we = 1'b1;       // jirl 指令写回寄存器堆
            default:   rf_we = 1'b0;       // 其他分支指令不写回寄存器堆
        endcase
    end
    else begin
        case (din[15:13])
            3'b010 : begin
                if (!din[9]) rf_we = 1'b1;  // 匹配到所有 load 指令：ld.b ld.bu ld.h ld.hu ld.w            
                else         rf_we = 1'b0;  // 匹配到所有 store 指令：st.b st.h st.w
            end
            default: rf_we = 1'b1;
        endcase
    end
end

always @(*) begin
    case (din[15:13])
        3'b010: begin
            case(din[8:7])
                2'b00:  ram_we = `RAM_WE_B;
                2'b01:  ram_we = `RAM_WE_H;
                2'b10:  ram_we = `RAM_WE_W;
            endcase
        end
        default: ram_we = `RAM_WE_N;
    endcase
end

// assign r2_sel = XXX ? `R2_RK : `R2_RD;
// assign wr_sel = XXX ? `WR_Rr1: `WR_RD;
assign r2_sel = (din[15:13] == 3'b010 && din[9]) || id_is_br_jump ? `R2_RD : `R2_RK;     // 选择rk为源寄存器2，（store 或分支跳转指令）
assign wr_sel = (din[15:11] == `FR5_BL) ? `WR_Rr1 : `WR_RD;     // 选择rd或r1为目的寄存器

always @(*) begin
    case (din[15:13])
        3'b000 : wd_sel = `WD_ALU;
        3'b010 : wd_sel = `WD_RAM;          // 匹配所有访存指令
        3'b001 : wd_sel = `WD_ALU;
        3'b100 : wd_sel = `WD_PC4;          // 匹配 JIEL 指令
        3'b101 : wd_sel = `WD_PC4;          // 匹配 b bl beq bne 指令，（注意 beq bne 不需要写回）
        default: wd_sel = `WD_ALU;
    endcase
end

always @(*) begin
    if (din[15:13] == 3'b001)
        rR1_re = 1'b0;
    else
        rR1_re = 1'b1;
end

always @(*) begin
    if (id_is_br_jump && !inst_is_b_bl) begin
        rR2_re = 1'b1;
    end
    else begin
        case (din[15:12])
            4'b0000: begin
                if (!din[10]) begin
                    if (!din[7]) begin  // 匹配到所有 3R 类型指令
                        rR2_re=1'b1;
                    end else begin      // 匹配到所有 2RI5 类型指令
                        rR2_re=1'b0;
                    end
                end else begin
                    rR2_re = 1'b0;      // 匹配除 load/store 指令外的所有 2RI12 类型指令
                end
            end
            4'b0101: begin                    // store/load
                if (din[9]) rR2_re = 1'b1;    // store
                else        rR2_re = 1'b0;    // load
            end
            
            default: rR2_re=1'b0;
        endcase
    end
end

always @(*) begin
    case (din[15:11])
        5'b00111: alua_sel = `ALUA_PC;
        5'b00101: alua_sel = `ALUA_ZERO;
        default:  alua_sel = `ALUA_R1;
    endcase
end


always @(*) begin
    case (din[15:13])
        3'b000 : begin
            if (!din[10]) begin
                if (!din[7]) begin          // 匹配到所有 3R 类型指令
                    alub_sel = `ALUB_R2;
                end else begin              // 匹配到所有 2RI5 类型指令
                    alub_sel = `ALUB_EXT;
                end
            end else begin
                alub_sel = `ALUB_EXT;       // 匹配除 load/store 指令外的所有 2RI12 类型指令
            end
        end
        
        3'b001 : alub_sel = `ALUB_EXT;
        3'b010 : alub_sel = `ALUB_EXT;      // 匹配所有访存指令
        default: alub_sel = `ALUB_R2;
    endcase
end

endmodule
