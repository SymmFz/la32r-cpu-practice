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
`define EXT_12   3'b010     // 2RI12型指令符号拓展
`define EXT_12Z  3'b011     // 2RI12型指令零拓展
`define EXT_5    3'b101     // 2RI5型指令3种立即数移位指令的拓展op
`define EXT_NONE 3'b000

// Load指令读数据后的扩展op
`define RAM_EXT_H  3'b001
`define RAM_EXT_N  3'b000

// Store指令写数据op
`define RAM_WE_N 4'b0000

// ALU op
`define ALU_ADD    5'b00000
`define ALU_SUB    5'b00010
`define ALU_AND    5'b01001
`define ALU_OR     5'b01010
`define ALU_XOR    5'b01011
`define ALU_NOR    5'b01000
`define ALU_SLL    5'b01110
`define ALU_SRL    5'b01111
`define ALU_SRA    5'b10000
`define ALU_SLT    5'b00100
`define ALU_SLTU   5'b00101 


// 指令译码相关
`define FR5_ADD  5'b00000
`define FR5_SUB  5'b00010
`define FR5_AND  5'b01001
`define FR5_OR   5'b01010
`define FR5_XOR  5'b01011
`define FR5_NOR  5'b01000
`define FR5_SLL  5'b01110
`define FR5_SRL  5'b01111
`define FR5_SRA  5'b10000
`define FR5_SLT  5'b00100
`define FR5_SLTU 5'b00101 

// 2RI5
`define FR5_SLLI 5'b00001
`define FR5_SRLI 5'b01001
`define FR5_SRAI 5'b10001

// 2RI12
`define FR3_ADDI    3'b010 
`define FR3_ANDI    3'b101 
`define FR3_ORI     3'b110 
`define FR3_XORI    3'b111 
`define FR3_SLTI    3'b000 
`define FR3_SLTUI   3'b001 


// 源操作数2的选择：选择rk或rd
`define R2_RK  1'b1
`define R2_RD  1'b0

// 目的操作数的选择：选择rd或r1
`define WR_RD  1'b1
`define WR_Rr1  1'b0

// 写数据选择：选择将ALU数据或将读主存的数据写回寄存器堆
`define WD_ALU  2'b11
`define WD_RAM  2'b01

// ALU操作数A的选择：选择源寄存器1或PC值或常数0
`define ALUA_R1     2'b01
`define ALUA_PC     2'b00
`define ALUA_ZERO   2'b10

// ALU操作数B的选择：选择源寄存器2或立即数
`define ALUB_R2  1'b1
`define ALUB_EXT 1'b0
