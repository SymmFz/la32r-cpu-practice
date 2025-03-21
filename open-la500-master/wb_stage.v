`include "openla500.vh"
`include "csr.vh"

module wb_stage(
    input  wire                     clk            ,
    input  wire                     reset          ,
    //allowin
    output wire                     ws_allowin     ,
    //from ms
    input  wire                     ms_to_ws_valid ,
    input  wire [`MS_TO_WS_BUS_WD -1:0]  ms_to_ws_bus,
    //to rf: for write back
    output wire [`WS_TO_RF_BUS_WD -1:0]  ws_to_rf_bus,
    //to ds
    output wire                     ws_to_ds_valid ,
    //exception 
    output wire [31:0] csr_era                     ,
    output wire [ 8:0] csr_esubcode                ,
    output wire [ 5:0] csr_ecode                   ,
    output wire   excp_flush                       ,
    output wire   ertn_flush                       ,
    output wire   refetch_flush                    ,
    output wire   icacop_flush                     ,
    output wire   csr_wr_en                        ,
    output wire [13:0] wr_csr_addr                 ,
    output wire [31:0] wr_csr_data                 ,
    output wire   va_error                         ,
    output wire [31:0] bad_va                      ,
    output wire   excp_tlbrefill                   ,
    output wire   excp_tlb                         ,
    output wire [18:0] excp_tlb_vppn               ,
    //idle
    output wire   idle_flush                       ,
    //llbit
    output wire   ws_llbit_set                     ,
    output wire   ws_llbit                         ,
    output wire   ws_lladdr_set                    ,
    output wire [27:0] ws_lladdr                   ,
    //tlb ins
    output wire   tlb_inst_stall                   ,
    output wire   tlbsrch_en                       ,
    output wire   tlbsrch_found                    ,
    output wire [ 4:0] tlbsrch_index               ,
    output wire   tlbfill_en                       ,
    output wire   tlbwr_en                         ,
    output wire   tlbrd_en                         ,
    output wire   invtlb_en                        ,
    output wire [ 9:0] invtlb_asid                 ,
    output wire [18:0] invtlb_vpn                  ,
    output wire [ 4:0] invtlb_op                   ,
    //to perf_counter
    output wire   real_valid                       ,
    output wire   real_br_inst                     ,
    output wire   real_icache_miss                 ,
    output wire   real_dcache_miss                 ,
    output wire   real_mem_inst                    ,
    output wire   real_br_pre                      ,
    output wire   real_br_pre_error                ,
    //debug
    output wire   debug_ws_valid                    ,
    input  wire   debug_break_point                 ,
    //trace debug interface
    output wire [31:0] debug_wb_pc                  ,
    output wire [ 3:0] debug_wb_rf_wen              ,
    output wire [ 4:0] debug_wb_rf_wnum             ,
    output wire [31:0] debug_wb_rf_wdata            ,
    output wire [31:0] debug_wb_inst                ,

    // difftest
    output wire        ws_valid_diff                ,
    output wire        ws_cnt_inst_diff             ,
    output wire [63:0] ws_timer_64_diff             ,
    output wire [ 7:0] ws_inst_ld_en_diff           ,
    output wire [31:0] ws_ld_paddr_diff             ,
    output wire [31:0] ws_ld_vaddr_diff             ,
    output wire [ 7:0] ws_inst_st_en_diff           ,
    output wire [31:0] ws_st_paddr_diff             ,
    output wire [31:0] ws_st_vaddr_diff             ,
    output wire [31:0] ws_st_data_diff              ,
    output wire        ws_csr_rstat_en_diff         ,
    output wire [31:0] ws_csr_data_diff             ,
    // inc_dev
    input  wire        incdev_pause,
    output wire        br_taken,
    output wire [31:0] br_target
);

reg         ws_valid;
wire        ws_ready_go;

wire        flush_sign;

reg [`MS_TO_WS_BUS_WD -1:0] ms_to_ws_bus_r;
wire        ws_gr_we;
wire        ws_excp;
wire [15:0] ws_excp_num;
wire        ws_ertn;
wire [ 4:0] ws_dest;
wire [31:0] ws_final_result;
wire [31:0] ws_pc;
wire [31:0] ws_csr_result;
wire [13:0] ws_csr_idx;
wire        ws_csr_we;
wire        ws_ll_w;
wire        ws_sc_w;
wire [31:0] ws_error_va;
wire        ws_tlbsrch;
wire        ws_tlbfill;
wire        ws_tlbwr;
wire        ws_tlbrd;
wire        ws_refetch;
wire        ws_invtlb;
wire        ws_icacop_op_en;
wire        ws_br_inst;
wire        ws_icache_miss;
wire        ws_access_mem;
wire        ws_dcache_miss;
wire        ws_br_pre;
wire        ws_br_pre_error;
wire        ws_idle;
wire [31:0] ws_paddr;
wire        ws_data_uc;

// difftest
wire [31:0] ws_inst         ;
wire        ws_cnt_inst     ;
wire [63:0] ws_timer_64     ;
wire [ 7:0] ws_inst_ld_en   ;
wire [31:0] ws_ld_paddr     ;
wire [31:0] ws_ld_vaddr     ;
wire [ 7:0] ws_inst_st_en   ;
wire [31:0] ws_st_data      ;
wire        ws_csr_rstat_en ;
wire [31:0] ws_csr_data     ;

assign {br_taken       ,  //525:525 for inc_dev
        br_target      ,  //524:493 for dec_dev
        ws_csr_data    ,  //492:461 for difftest
        ws_csr_rstat_en,  //460:460 for difftest
        ws_st_data     ,  //459:428 for difftest
        ws_inst_st_en  ,  //427:420 for difftest
        ws_ld_vaddr    ,  //419:388 for difftest
        ws_ld_paddr    ,  //387:356 for difftest
        ws_inst_ld_en  ,  //355:348 for difftest
        ws_cnt_inst    ,  //347:347 for difftest
        ws_timer_64    ,  //346:283 for difftest
        ws_inst        ,  //282:251 for difftest
		ws_data_uc     ,  //250:250
		ws_paddr       ,  //249:218
        ws_idle        ,  //217:217
        ws_br_pre_error,  //216:216
        ws_br_pre      ,  //215:215
        ws_dcache_miss ,  //214:214
        ws_access_mem  ,  //213:213
        ws_icache_miss ,  //212:212
        ws_br_inst     ,  //211:211
        ws_icacop_op_en,  //210:210
        invtlb_vpn     ,  //209:191
        invtlb_asid    ,  //190:181
        ws_invtlb      ,  //180:180
        ws_tlbrd       ,  //179:179
        ws_refetch     ,  //178:178
        ws_tlbfill     ,  //177:177
        ws_tlbwr       ,  //176:176
        tlbsrch_index  ,  //175:171
        tlbsrch_found  ,  //170:170
        ws_tlbsrch     ,  //169:169
        ws_error_va    ,  //168:137
        ws_sc_w        ,  //136:136
        ws_ll_w        ,  //135:135
        ws_excp_num    ,  //134:119
        ws_csr_we      ,  //118:118
        ws_csr_idx     ,  //117:104
        ws_csr_result  ,  //103:72
        ws_ertn        ,  //71:71
        ws_excp        ,  //70:70
        ws_gr_we       ,  //69:69
        ws_dest        ,  //68:64
        ws_final_result,  //63:32
        ws_pc             //31:0
       } = ms_to_ws_bus_r;

assign ws_to_ds_valid = ws_valid;

assign flush_sign = excp_flush | ertn_flush | refetch_flush | icacop_flush | idle_flush;

wire        rf_we;
wire [4 :0] rf_waddr;
wire [31:0] rf_wdata;
assign ws_to_rf_bus = {rf_we   ,  //37:37
                       rf_waddr,  //36:32
                       rf_wdata   //31:0
                      };

assign ws_ready_go = !debug_break_point;
assign ws_allowin  = (!ws_valid || ws_ready_go);
always @(posedge clk) begin
    if (reset | flush_sign) begin
        ws_valid <= 1'b0;
    end
    else if (ws_allowin) begin
        ws_valid <= ms_to_ws_valid;
    end

    if (ms_to_ws_valid & ws_allowin) begin
        ms_to_ws_bus_r <= ms_to_ws_bus;
    end
end

assign real_br_inst = ws_br_inst & real_valid;
assign real_icache_miss = ws_icache_miss & real_valid;
assign real_dcache_miss = ws_dcache_miss & real_valid;
assign real_mem_inst = ws_access_mem & real_valid;
assign real_br_pre = ws_br_pre & real_valid;
assign real_br_pre_error = ws_br_pre_error & real_valid;

assign real_valid = ws_valid & ~ws_excp;  //ws valid and no exception

assign rf_we    = ws_gr_we & real_valid;
assign rf_waddr = ws_dest;
assign rf_wdata = ws_final_result;

assign excp_flush   = ws_excp & ws_valid;
assign ertn_flush   = ws_ertn & real_valid;
assign refetch_flush = (ws_csr_we || ((ws_ll_w || ws_sc_w) && !ws_excp) || ws_refetch) && ws_valid;
assign csr_era      = ws_pc;
assign csr_wr_en    = ws_csr_we && real_valid;
assign wr_csr_addr  = ws_csr_idx;
assign wr_csr_data  = ws_csr_result; 

assign icacop_flush = ws_icacop_op_en && ws_valid;

assign idle_flush = ws_idle && real_valid;

assign tlb_inst_stall = (ws_tlbsrch || ws_tlbrd) && ws_valid;

//tlb ins
assign {tlbsrch_en  , 
        tlbwr_en , 
        tlbfill_en , 
        tlbrd_en  ,
        invtlb_en } = {ws_tlbsrch  , 
                       ws_tlbwr , 
                       ws_tlbfill , 
                       ws_tlbrd  ,
                       ws_invtlb } & {5{real_valid}};

//llbit
assign ws_llbit_set  = (ws_ll_w | ws_sc_w) & real_valid; 
assign ws_llbit      = ((ws_ll_w&&!ws_data_uc) & 1'b1) | (ws_sc_w & 1'b0);
assign ws_lladdr_set =  ws_ll_w && !ws_data_uc && real_valid;
assign ws_lladdr     =  ws_paddr[31:4];

/*
excp_num[0]  int
        [1]  adef
        [2]  tlbr    |inst tlb exceptions
        [3]  pif     |
        [4]  ppi     |
        [5]  syscall
        [6]  brk
        [7]  ine
        [8]  ipe
        [9]  ale
        [10] <null>
        [11] tlbr    |
        [12] pme     |data tlb exceptions
        [13] ppi     |
        [14] pis     |
        [15] pil     |
        
*/

//exception have piority, onle one exception is valid 
assign {csr_ecode, 
        va_error, 
        bad_va, 
        csr_esubcode, 
        excp_tlbrefill,
        excp_tlb, 
        excp_tlb_vppn} = ws_excp_num[ 0] ? {`ECODE_INT , 1'b0    , 32'b0      , 9'b0          , 1'b0    , 1'b0    , 19'b0             } :
                         ws_excp_num[ 1] ? {`ECODE_ADEF, ws_valid, ws_pc      , `ESUBCODE_ADEF, 1'b0    , 1'b0    , 19'b0             } :
                         ws_excp_num[ 2] ? {`ECODE_TLBR, ws_valid, ws_pc      , 9'b0          , ws_valid, ws_valid, ws_pc[31:13]      } :
                         ws_excp_num[ 3] ? {`ECODE_PIF , ws_valid, ws_pc      , 9'b0          , 1'b0    , ws_valid, ws_pc[31:13]      } :
                         ws_excp_num[ 4] ? {`ECODE_PPI , ws_valid, ws_pc      , 9'b0          , 1'b0    , ws_valid, ws_pc[31:13]      } :
                         ws_excp_num[ 5] ? {`ECODE_SYS , 1'b0    , 32'b0      , 9'b0          , 1'b0    , 1'b0    , 19'b0             } :
                         ws_excp_num[ 6] ? {`ECODE_BRK , 1'b0    , 32'b0      , 9'b0          , 1'b0    , 1'b0    , 19'b0             } :
                         ws_excp_num[ 7] ? {`ECODE_INE , 1'b0    , 32'b0      , 9'b0          , 1'b0    , 1'b0    , 19'b0             } :
                         ws_excp_num[ 8] ? {`ECODE_IPE , 1'b0    , 32'b0      , 9'b0          , 1'b0    , 1'b0    , 19'b0             } :   //close ipe excp now
                         ws_excp_num[ 9] ? {`ECODE_ALE , ws_valid, ws_error_va, 9'b0          , 1'b0    , 1'b0    , 19'b0             } :
                         ws_excp_num[11] ? {`ECODE_TLBR, ws_valid, ws_error_va, 9'b0          , ws_valid, ws_valid, ws_error_va[31:13]} :
                         ws_excp_num[12] ? {`ECODE_PME , ws_valid, ws_error_va, 9'b0          , 1'b0    , ws_valid, ws_error_va[31:13]} :
                         ws_excp_num[13] ? {`ECODE_PPI , ws_valid, ws_error_va, 9'b0          , 1'b0    , ws_valid, ws_error_va[31:13]} :
                         ws_excp_num[14] ? {`ECODE_PIS , ws_valid, ws_error_va, 9'b0          , 1'b0    , ws_valid, ws_error_va[31:13]} :
                         ws_excp_num[15] ? {`ECODE_PIL , ws_valid, ws_error_va, 9'b0          , 1'b0    , ws_valid, ws_error_va[31:13]} :
                         69'b0;

//invtlb ins
assign invtlb_op = ws_dest;

// debug info generate
assign debug_wb_pc       = ws_pc;
assign debug_wb_rf_wen   = {4{rf_we}};
assign debug_wb_rf_wnum  = ws_dest;
assign debug_wb_rf_wdata = ws_final_result;
assign debug_wb_inst     = ws_inst;
assign debug_ws_valid    = ws_valid;

assign ws_valid_diff        = real_valid        ;
assign ws_timer_64_diff     = ws_timer_64       ;
assign ws_cnt_inst_diff     = ws_cnt_inst       ;

assign ws_inst_ld_en_diff   = ws_inst_ld_en     ;
assign ws_ld_paddr_diff     = ws_ld_paddr       ;
assign ws_ld_vaddr_diff     = ws_ld_vaddr       ;

assign ws_inst_st_en_diff   = ws_inst_st_en     ;
assign ws_st_paddr_diff     = ws_ld_paddr_diff  ;
assign ws_st_vaddr_diff     = ws_ld_vaddr_diff  ;
assign ws_st_data_diff      = ws_st_data        ;

assign ws_csr_rstat_en_diff = ws_csr_rstat_en   ;
assign ws_csr_data_diff     = ws_csr_data       ;

endmodule
