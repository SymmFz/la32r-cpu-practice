// `define ENABLE_ICACHE
// `define ENABLE_DCACHE

// `define CACHE_BLK_LEN  4
// `define CACHE_BLK_SIZE (`CACHE_BLK_LEN*32)

// PC复位初始值
`define PC_INIT_VAL     32'h1C000000

// NPC op
`define NPC_PC4 2'b00

// 立即数扩展op
`define EXT_20   3'b110
`define EXT_12   3'b111
`define EXT_NONE 3'b000

// Load指令读数据后的扩展op
`define RAM_EXT_H  3'b001
`define RAM_EXT_N  3'b000

// Store指令写数据op
`define RAM_WE_N 4'b0000

// ALU op
`define ALU_ADD    5'b00000

// 指令译码相关
`define FR5_ADD  5'b00000

// 源操作数2的选择：选择rk或rd
`define R2_RK  1'b1
`define R2_RD  1'b0

// 目的操作数的选择：选择rd或r1
`define WR_RD  1'b1
`define WR_Rr1  1'b0

// 写数据选择：选择将ALU数据或将读主存的数据写回寄存器堆
`define WD_ALU  2'b11
`define WD_RAM  2'b01

// ALU操作数A的选择：选择源寄存器1或PC值
`define ALUA_R1  1'b1
`define ALUA_PC  1'b0

// ALU操作数B的选择：选择源寄存器2或立即数
`define ALUB_R2  1'b1
`define ALUB_EXT 1'b0
