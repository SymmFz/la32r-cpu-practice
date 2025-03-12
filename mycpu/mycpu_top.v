module mycpu_top(
    input           aclk,
    input           aresetn,
    input    [ 7:0] ext_int, 
    //AXI interface 
    //read reqest
    output   [ 3:0] arid,
    output   [31:0] araddr,
    output   [ 7:0] arlen,
    output   [ 2:0] arsize,
    output   [ 1:0] arburst,
    output   [ 1:0] arlock,
    output   [ 3:0] arcache,
    output   [ 2:0] arprot,
    output          arvalid,
    input           arready,
    //read back
    input    [ 3:0] rid,
    input    [31:0] rdata,
    input    [ 1:0] rresp,
    input           rlast,
    input           rvalid,
    output          rready,
    //write request
    output   [ 3:0] awid,
    output   [31:0] awaddr,
    output   [ 7:0] awlen,
    output   [ 2:0] awsize,
    output   [ 1:0] awburst,
    output   [ 1:0] awlock,
    output   [ 3:0] awcache,
    output   [ 2:0] awprot,
    output          awvalid,
    input           awready,
    //write data
    output   [ 3:0] wid,
    output   [31:0] wdata,
    output   [ 3:0] wstrb,
    output          wlast,
    output          wvalid,
    input           wready,
    //write back
    input    [ 3:0] bid,
    input    [ 1:0] bresp,
    input           bvalid,
    output          bready,

    //incDev
    input         ex_flag,
    input  [31:0] ex_inst,
    output        ex_finish,
    input         sync_pc_inc,
    input         sync_pc_we,
    input  [31:0] sync_pc,
    input         sync_wb_we,
    input  [31:0] sync_wb_pc,
    input  [ 4:0] sync_wb_wreg,
    input  [31:0] sync_wb_wdata,
`ifndef IMPL_TRAP
    input         excp_occur,
`endif

    //debug
    output        debug_wb_valid,
    output [31:0] debug_wb_pc,
    output [ 3:0] debug_wb_rf_we,
    output [ 4:0] debug_wb_rf_wnum,
    output [31:0] debug_wb_rf_wdata
);

myCPU u_mycpu (
    .cpu_rstn   (aresetn),
    .cpu_clk    (aclk),
    
    // Data Access Interface
    .daccess_ren    (),     // output wire [ 3:0]
    .daccess_addr   (),     // output wire [31:0]
    .daccess_valid  (1'b0), // input  wire
    .daccess_rdata  (),     // input  wire [31:0]
    .daccess_wen    (),     // output wire [ 3:0]
    .daccess_wdata  (),     // output wire [31:0]
    .daccess_wresp  (1'b0), // input  wire

    //incDev
    .ex_flag            (ex_flag),
    .ex_inst            (ex_inst),
    .ex_finish          (ex_finish),
    .sync_pc_inc        (sync_pc_inc),
    .sync_pc_we         (sync_pc_we),
    .sync_pc            (sync_pc),
    .sync_wb_we         (sync_wb_we),
    .sync_wb_pc         (sync_wb_pc),
    .sync_wb_wreg       (sync_wb_wreg),
    .sync_wb_wdata      (sync_wb_wdata),
`ifndef IMPL_TRAP
    .excp_occur         (excp_occur),
`endif
    // Debug Interface
    .debug_wb_valid     (debug_wb_valid),
    .debug_wb_pc        (debug_wb_pc),
    .debug_wb_ena       (debug_wb_rf_we),
    .debug_wb_reg       (debug_wb_rf_wnum),
    .debug_wb_value     (debug_wb_rf_wdata)
);

endmodule