`ifndef MYCPU_INST_H
`define MYCPU_INST_H

`define IMPL_LU12I_W    1
`define IMPL_ADD_W      1
`define IMPL_ADDI_W     1
`define IMPL_SUB_W      1
`define IMPL_SLT        1
`define IMPL_SLTU       1
`define IMPL_AND        1
`define IMPL_OR         1
`define IMPL_XOR        1
`define IMPL_NOR        1
`define IMPL_SLLI_W     1
`define IMPL_SRLI_W     1
`define IMPL_SRAI_W     1
`define IMPL_LD_W       1 //LD
`define IMPL_ST_W       1 //ST
`define IMPL_BEQ        0 //B
`define IMPL_BNE        0 //B
`define IMPL_BL         0 //J
`define IMPL_JIRL       0 //J
`define IMPL_B          0 //J
`define IMPL_PCADDU12I  1
`define IMPL_SLTI       1
`define IMPL_SLTUI      1
`define IMPL_ANDI       1
`define IMPL_ORI        1
`define IMPL_XORI       1
`define IMPL_SLL_W      1
`define IMPL_SRA_W      1
`define IMPL_SRL_W      1
`define IMPL_DIV_W      0
`define IMPL_DIV_WU     0
`define IMPL_MUL_W      0
`define IMPL_MULH_W     0
`define IMPL_MULH_WU    0
`define IMPL_MOD_W      0
`define IMPL_MOD_WU     0
`define IMPL_BLT        0 //B
`define IMPL_BGE        0 //B
`define IMPL_BLTU       0 //B
`define IMPL_BGEU       0 //B
`define IMPL_LD_B       1 //LD
`define IMPL_LD_H       1 //LD
`define IMPL_LD_BU      1 //LD
`define IMPL_LD_HU      1 //LD
`define IMPL_ST_B       1 //ST
`define IMPL_ST_H       1 //ST
`define IMPL_EX_SYSCALL     0
`define IMPL_EX_BREAK       0
`define IMPL_EX_TI          0
`define IMPL_EX_INE         0
`define IMPL_EX_SOFT_INT    0
`define IMPL_EX_ADEF        0
`define IMPL_EX_ALE_LD_W    0
`define IMPL_EX_ALE_LD_H    0
`define IMPL_EX_ALE_LD_HU   0
`define IMPL_EX_ALE_ST_H    0
`define IMPL_EX_ALE_ST_W    0
`define IMPL_EX_RDCNT       0

// `define IMPL_TRAP

`endif

