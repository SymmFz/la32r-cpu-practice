/*------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Copyright (c) 2016, Loongson Technology Corporation Limited.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this 
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

3. Neither the name of Loongson Technology Corporation Limited nor the names of 
its contributors may be used to endorse or promote products derived from this 
software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
DISCLAIMED. IN NO EVENT SHALL LOONGSON TECHNOLOGY CORPORATION LIMITED BE LIABLE
TO ANY PARTY FOR DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE 
GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/

//*************************************************************************
//   > File Name   : soc_top.v
//   > Description : SoC, included cpu, 2 x 3 bridge,
//                   inst ram, confreg, data ram
// 
//           -------------------------
//           |           cpu         |
//           -------------------------
//         inst|                  | data
//             |                  | 
//             |        ---------------------
//             |        |    1 x 2 bridge   |
//             |        ---------------------
//             |             |            |           
//             |             |            |           
//      -------------   -----------   -----------
//      | inst ram  |   | data ram|   | confreg |
//      -------------   -----------   -----------
//
//   > Author      : LOONGSON
//   > Date        : 2017-08-04
//*************************************************************************

`default_nettype none

//for simulation:
//1. if define SIMU_USE_PLL = 1, will use clk_pll to generate cpu_clk/timer_clk,
//   and simulation will be very slow.
//2. usually, please define SIMU_USE_PLL=0 to speed up simulation by assign
//   cpu_clk/timer_clk = clk.
//   at this time, cpu_clk/timer_clk frequency are both 100MHz, same as clk.
`define SIMU_USE_PLL 0 //set 0 to speed up simulation

module soc_lite_top #(parameter SIMULATION=1'b0)
(
    input  wire        resetn, 
    input  wire        clk,

    //------gpio-------
    output wire [15:0] led,
    output wire [1 :0] led_rg0,
    output wire [1 :0] led_rg1,
    output wire [7 :0] num_csn,
    output wire [6 :0] num_a_g,
    output wire [31:0] num_data,
    input  wire [7 :0] switch, 
    output wire [3 :0] btn_key_col,
    input  wire [3 :0] btn_key_row,
    input  wire [1 :0] btn_step
);
//clk and resetn
wire cpu_clk;
wire timer_clk;
reg cpu_resetn;
always @(posedge cpu_clk)
begin
    cpu_resetn <= resetn;
end
generate if(SIMULATION && `SIMU_USE_PLL==0)
begin: speedup_simulation
    assign cpu_clk   = clk;
    assign timer_clk = clk;
end
else
begin: pll
    clk_pll clk_pll
    (
        .clk_in1 (clk),
        .cpu_clk (cpu_clk),
        .timer_clk (timer_clk)
    );
end
endgenerate

//cpu axi
wire [3 :0] cpu_arid   , ref_arid   , usr_arid   ;
wire [31:0] cpu_araddr , ref_araddr , usr_araddr ;
wire [7 :0] cpu_arlen  , ref_arlen  , usr_arlen  ;
wire [2 :0] cpu_arsize , ref_arsize , usr_arsize ;
wire [1 :0] cpu_arburst, ref_arburst, usr_arburst;
wire [0 :0] cpu_arlock , ref_arlock , usr_arlock ;
wire [3 :0] cpu_arcache, ref_arcache, usr_arcache;
wire [2 :0] cpu_arprot , ref_arprot , usr_arprot ;
wire        cpu_arvalid, ref_arvalid, usr_arvalid;
wire        cpu_arready, ref_arready, usr_arready;
wire [3 :0] cpu_rid    , ref_rid    , usr_rid    ;
wire [31:0] cpu_rdata  , ref_rdata  , usr_rdata  ;
wire [1 :0] cpu_rresp  , ref_rresp  , usr_rresp  ;
wire        cpu_rlast  , ref_rlast  , usr_rlast  ;
wire        cpu_rvalid , ref_rvalid , usr_rvalid ;
wire        cpu_rready , ref_rready , usr_rready ;
wire [3 :0] cpu_awid   , ref_awid   , usr_awid   ;
wire [31:0] cpu_awaddr , ref_awaddr , usr_awaddr ;
wire [7 :0] cpu_awlen  , ref_awlen  , usr_awlen  ;
wire [2 :0] cpu_awsize , ref_awsize , usr_awsize ;
wire [1 :0] cpu_awburst, ref_awburst, usr_awburst;
wire [0 :0] cpu_awlock , ref_awlock , usr_awlock ;
wire [3 :0] cpu_awcache, ref_awcache, usr_awcache;
wire [2 :0] cpu_awprot , ref_awprot , usr_awprot ;
wire        cpu_awvalid, ref_awvalid, usr_awvalid;
wire        cpu_awready, ref_awready, usr_awready;
wire [3 :0] cpu_wid    , ref_wid    , usr_wid    ;
wire [31:0] cpu_wdata  , ref_wdata  , usr_wdata  ;
wire [3 :0] cpu_wstrb  , ref_wstrb  , usr_wstrb  ;
wire        cpu_wlast  , ref_wlast  , usr_wlast  ;
wire        cpu_wvalid , ref_wvalid , usr_wvalid ;
wire        cpu_wready , ref_wready , usr_wready ;
wire [3 :0] cpu_bid    , ref_bid    , usr_bid    ;
wire [1 :0] cpu_bresp  , ref_bresp  , usr_bresp  ;
wire        cpu_bvalid , ref_bvalid , usr_bvalid ;
wire        cpu_bready , ref_bready , usr_bready ;

//cpu axi wrap
wire        cpu_wrap_aclk   ;
wire        cpu_wrap_aresetn;
wire [3 :0] cpu_wrap_arid   ;
wire [31:0] cpu_wrap_araddr ;
wire [7 :0] cpu_wrap_arlen  ;
wire [2 :0] cpu_wrap_arsize ;
wire [1 :0] cpu_wrap_arburst;
wire [1 :0] cpu_wrap_arlock ;
wire [3 :0] cpu_wrap_arcache;
wire [2 :0] cpu_wrap_arprot ;
wire        cpu_wrap_arvalid;
wire        cpu_wrap_arready;
wire [3 :0] cpu_wrap_rid    ;
wire [31:0] cpu_wrap_rdata  ;
wire [1 :0] cpu_wrap_rresp  ;
wire        cpu_wrap_rlast  ;
wire        cpu_wrap_rvalid ;
wire        cpu_wrap_rready ;
wire [3 :0] cpu_wrap_awid   ;
wire [31:0] cpu_wrap_awaddr ;
wire [7 :0] cpu_wrap_awlen  ;
wire [2 :0] cpu_wrap_awsize ;
wire [1 :0] cpu_wrap_awburst;
wire [1 :0] cpu_wrap_awlock ;
wire [3 :0] cpu_wrap_awcache;
wire [2 :0] cpu_wrap_awprot ;
wire        cpu_wrap_awvalid;
wire        cpu_wrap_awready;
wire [3 :0] cpu_wrap_wid    ;
wire [31:0] cpu_wrap_wdata  ;
wire [3 :0] cpu_wrap_wstrb  ;
wire        cpu_wrap_wlast  ;
wire        cpu_wrap_wvalid ;
wire        cpu_wrap_wready ;
wire [3 :0] cpu_wrap_bid    ;
wire [1 :0] cpu_wrap_bresp  ;
wire        cpu_wrap_bvalid ;
wire        cpu_wrap_bready ;
//axi ram
wire [3 :0] ram_arid   ;
wire [31:0] ram_araddr ;
wire [3 :0] ram_arlen  ;
wire [2 :0] ram_arsize ;
wire [1 :0] ram_arburst;
wire [1 :0] ram_arlock ;
wire [3 :0] ram_arcache;
wire [2 :0] ram_arprot ;
wire        ram_arvalid;
wire        ram_arready;
wire [3 :0] ram_rid    ;
wire [31:0] ram_rdata  ;
wire [1 :0] ram_rresp  ;
wire        ram_rlast  ;
wire        ram_rvalid ;
wire        ram_rready ;
wire [3 :0] ram_awid   ;
wire [31:0] ram_awaddr ;
wire [3 :0] ram_awlen  ;
wire [2 :0] ram_awsize ;
wire [1 :0] ram_awburst;
wire [1 :0] ram_awlock ;
wire [3 :0] ram_awcache;
wire [2 :0] ram_awprot ;
wire        ram_awvalid;
wire        ram_awready;
wire [3 :0] ram_wid    ;
wire [31:0] ram_wdata  ;
wire [3 :0] ram_wstrb  ;
wire        ram_wlast  ;
wire        ram_wvalid ;
wire        ram_wready ;
wire [3 :0] ram_bid    ;
wire [1 :0] ram_bresp  ;
wire        ram_bvalid ;
wire        ram_bready ;
//conf
wire [3 :0] conf_arid   ;
wire [31:0] conf_araddr ;
wire [3 :0] conf_arlen  ;
wire [2 :0] conf_arsize ;
wire [1 :0] conf_arburst;
wire [1 :0] conf_arlock ;
wire [3 :0] conf_arcache;
wire [2 :0] conf_arprot ;
wire        conf_arvalid;
wire        conf_arready;
wire [3 :0] conf_rid    ;
wire [31:0] conf_rdata  ;
wire [1 :0] conf_rresp  ;
wire        conf_rlast  ;
wire        conf_rvalid ;
wire        conf_rready ;
wire [3 :0] conf_awid   ;
wire [31:0] conf_awaddr ;
wire [3 :0] conf_awlen  ;
wire [2 :0] conf_awsize ;
wire [1 :0] conf_awburst;
wire [1 :0] conf_awlock ;
wire [3 :0] conf_awcache;
wire [2 :0] conf_awprot ;
wire        conf_awvalid;
wire        conf_awready;
wire [3 :0] conf_wid    ;
wire [31:0] conf_wdata  ;
wire [3 :0] conf_wstrb  ;
wire        conf_wlast  ;
wire        conf_wvalid ;
wire        conf_wready ;
wire [3 :0] conf_bid    ;
wire [1 :0] conf_bresp  ;
wire        conf_bvalid ;
wire        conf_bready ;

//for lab6
wire [4 :0] ram_random_mask;

// inc_dev
wire        ref_pause     ;
wire        ref_ex_finish ;
wire        ref_excp      ;
wire [31:0] ref_excp_entry;
wire        ref_spinst    ;
wire [31:0] ref_spinst_pc ;
wire        ref_br_taken  ;
wire [31:0] ref_br_target ;

wire        ex_flag       ;
wire [31:0] ex_inst       ;
wire        ex_finish     ;
wire        sync_pc_inc   ;
wire        sync_pc_we    ;
wire [31:0] sync_pc       ;
wire        sync_wb_we    ;
wire [31:0] sync_wb_pc    ;
wire [ 4:0] sync_wb_wreg  ;
wire [31:0] sync_wb_wdata ;

//debug signals
wire [31:0] debug_wb_pc, debug0_wb_pc, debug1_wb_pc;
wire [3 :0] debug_wb_rf_we, debug0_wb_rf_we, debug1_wb_rf_we;
wire [4 :0] debug_wb_rf_wnum, debug0_wb_rf_wnum, debug1_wb_rf_wnum;
wire [31:0] debug_wb_rf_wdata, debug0_wb_rf_wdata, debug1_wb_rf_wdata;
wire [31:0] debug0_wb_inst;
`ifndef IMPL_TRAP
wire        debug_excp_occur;
`endif

assign debug_wb_pc       = debug1_wb_pc;
assign debug_wb_rf_we    = debug1_wb_rf_we;
assign debug_wb_rf_wnum  = debug1_wb_rf_wnum;
assign debug_wb_rf_wdata = debug1_wb_rf_wdata;

incdev_control U_incdev(
    .clk            (clk                ),
    .rstn           (resetn             ),
    // Interface to reference CPU
    .ref_pause      (ref_pause          ),
    .ref_ex_finish  (ref_ex_finish      ),
    .ref_excp       (ref_excp           ),
    .ref_excp_entry (ref_excp_entry     ),
    .ref_spinst     (ref_spinst         ),
    .ref_spinst_pc  (ref_spinst_pc      ),
    .ref_br_taken   (ref_br_taken       ),
    .ref_br_target  (ref_br_target      ),
    .ref_wb_pc      (debug0_wb_pc       ),
    .ref_wb_inst    (debug0_wb_inst     ),
    .ref_wb_we      (debug0_wb_rf_we    ),
    .ref_wb_rfnum   (debug0_wb_rf_wnum  ),
    .ref_wb_wdata   (debug0_wb_rf_wdata ),
    // Interface to user CPU
    .usr_ex_flag    (ex_flag            ),
    .usr_ex_inst    (ex_inst            ),
    .usr_ex_finish  (ex_finish          ),
    .usr_pc_inc     (sync_pc_inc        ),
    .usr_pc_we      (sync_pc_we         ),
    .usr_pc         (sync_pc            ),
    .usr_wb_we      (sync_wb_we         ),
    .usr_wb_pc      (sync_wb_pc         ),
    .usr_wb_wreg    (sync_wb_wreg       ),
    .usr_wb_wdata   (sync_wb_wdata      )
`ifndef IMPL_TRAP
    ,// to debug interface
    .debug_usr_wb_pc (debug1_wb_pc    ),
    .debug_excp_occur(debug_excp_occur)
`endif
);

//cpu axi
// Reference CPU
core_top openla500(
    .intrpt    (8'd0          ),  

    .aclk      (cpu_clk       ),
    .aresetn   (cpu_resetn    ),   //low active

    .arid      (ref_arid      ),
    .araddr    (ref_araddr    ),
    .arlen     (ref_arlen     ),
    .arsize    (ref_arsize    ),
    .arburst   (ref_arburst   ),
    .arlock    (ref_arlock    ),
    .arcache   (ref_arcache   ),
    .arprot    (ref_arprot    ),
    .arvalid   (ref_arvalid   ),
    .arready   (ref_arready   ),
                
    .rid       (ref_rid       ),
    .rdata     (ref_rdata     ),
    .rresp     (ref_rresp     ),
    .rlast     (ref_rlast     ),
    .rvalid    (ref_rvalid    ),
    .rready    (ref_rready    ),
               
    .awid      (ref_awid      ),
    .awaddr    (ref_awaddr    ),
    .awlen     (ref_awlen     ),
    .awsize    (ref_awsize    ),
    .awburst   (ref_awburst   ),
    .awlock    (ref_awlock    ),
    .awcache   (ref_awcache   ),
    .awprot    (ref_awprot    ),
    .awvalid   (ref_awvalid   ),
    .awready   (ref_awready   ),
    
    .wid       (ref_wid       ),
    .wdata     (ref_wdata     ),
    .wstrb     (ref_wstrb     ),
    .wlast     (ref_wlast     ),
    .wvalid    (ref_wvalid    ),
    .wready    (ref_wready    ),
    
    .bid       (ref_bid       ),
    .bresp     (ref_bresp     ),
    .bvalid    (ref_bvalid    ),
    .bready    (ref_bready    ),

    //incDev interface
    .incdev_pause      (ref_pause         ),
    .incdev_excp       (ref_excp          ),
    .incdev_excp_entry (ref_excp_entry    ),
    .incdev_spinst     (ref_spinst        ),
    .incdev_spinst_pc  (ref_spinst_pc     ),
    .incdev_br_taken   (ref_br_taken      ),
    .incdev_br_target  (ref_br_target     ),

    //debug interface
    .break_point       (1'b0              ),
    .infor_flag        (1'b0              ),
    .reg_num           (                  ),
    .ws_valid          (ref_ex_finish     ),
    .rf_rdata          (                  ),

    .debug0_wb_pc      (debug0_wb_pc      ),
    .debug0_wb_rf_wen  (debug0_wb_rf_we   ),
    .debug0_wb_rf_wnum (debug0_wb_rf_wnum ),
    .debug0_wb_rf_wdata(debug0_wb_rf_wdata),
    .debug0_wb_inst    (debug0_wb_inst    )
);

// Your CPU
mycpu_top u_cpu(
    .ext_int   (8'd0          ),  

    .aclk      (cpu_clk       ),
    .aresetn   (cpu_resetn    ),   //low active

    .arid      (usr_arid      ),
    .araddr    (usr_araddr    ),
    .arlen     (usr_arlen     ),
    .arsize    (usr_arsize    ),
    .arburst   (usr_arburst   ),
    .arlock    (usr_arlock    ),
    .arcache   (usr_arcache   ),
    .arprot    (usr_arprot    ),
    .arvalid   (usr_arvalid   ),
    .arready   (usr_arready   ),
                
    .rid       (usr_rid       ),
    .rdata     (usr_rdata     ),
    .rresp     (usr_rresp     ),
    .rlast     (usr_rlast     ),
    .rvalid    (usr_rvalid    ),
    .rready    (usr_rready    ),
               
    .awid      (usr_awid      ),
    .awaddr    (usr_awaddr    ),
    .awlen     (usr_awlen     ),
    .awsize    (usr_awsize    ),
    .awburst   (usr_awburst   ),
    .awlock    (usr_awlock    ),
    .awcache   (usr_awcache   ),
    .awprot    (usr_awprot    ),
    .awvalid   (usr_awvalid   ),
    .awready   (usr_awready   ),
    
    .wid       (usr_wid       ),
    .wdata     (usr_wdata     ),
    .wstrb     (usr_wstrb     ),
    .wlast     (usr_wlast     ),
    .wvalid    (usr_wvalid    ),
    .wready    (usr_wready    ),
    
    .bid       (usr_bid       ),
    .bresp     (usr_bresp     ),
    .bvalid    (usr_bvalid    ),
    .bready    (usr_bready    ),

    //incDev sync interface
    .ex_flag          (ex_flag       ),
    .ex_inst          (ex_inst       ),
    .ex_finish        (ex_finish     ),
    .sync_pc_inc      (sync_pc_inc   ),
    .sync_pc_we       (sync_pc_we    ),
    .sync_pc          (sync_pc       ),
    .sync_wb_we       (sync_wb_we    ),
    .sync_wb_pc       (sync_wb_pc    ),
    .sync_wb_wreg     (sync_wb_wreg  ),
    .sync_wb_wdata    (sync_wb_wdata ),
`ifndef IMPL_TRAP
    .excp_occur       (debug_excp_occur),
`endif

    //debug interface
    // .debug_wb_valid   (debug1_wb_valid   ),
    .debug_wb_pc      (debug1_wb_pc      ),
    .debug_wb_rf_we   (debug1_wb_rf_we   ),
    .debug_wb_rf_wnum (debug1_wb_rf_wnum ),
    .debug_wb_rf_wdata(debug1_wb_rf_wdata)
);

axi_crossbar_0 incdev_axi_bridge (
    .aclk               (cpu_clk   ),
    .aresetn            (cpu_resetn),
    .s_axi_awid         ({usr_awid   , ref_awid   }),
    .s_axi_awaddr       ({usr_awaddr , ref_awaddr }),
    .s_axi_awlen        ({usr_awlen  , ref_awlen  }),
    .s_axi_awsize       ({usr_awsize , ref_awsize }),
    .s_axi_awburst      ({usr_awburst, ref_awburst}),
    .s_axi_awlock       ({usr_awlock , ref_awlock }),
    .s_axi_awcache      ({usr_awcache, ref_awcache}),
    .s_axi_awprot       ({usr_awprot , ref_awprot }),
    .s_axi_awvalid      ({usr_awvalid, ref_awvalid}),
    .s_axi_awready      ({usr_awready, ref_awready}),
    .s_axi_wdata        ({usr_wdata  , ref_wdata  }),
    .s_axi_wstrb        ({usr_wstrb  , ref_wstrb  }),
    .s_axi_wlast        ({usr_wlast  , ref_wlast  }),
    .s_axi_wvalid       ({usr_wvalid , ref_wvalid }),
    .s_axi_wready       ({usr_wready , ref_wready }),
    .s_axi_bid          ({usr_bid    , ref_bid    }),
    .s_axi_bresp        ({usr_bresp  , ref_bresp  }),
    .s_axi_bvalid       ({usr_bvalid , ref_bvalid }),
    .s_axi_bready       ({usr_bready , ref_bready }),
    .s_axi_arid         ({usr_arid   , ref_arid   }),
    .s_axi_araddr       ({usr_araddr , ref_araddr }),
    .s_axi_arlen        ({usr_arlen  , ref_arlen  }),
    .s_axi_arsize       ({usr_arsize , ref_arsize }),
    .s_axi_arburst      ({usr_arburst, ref_arburst}),
    .s_axi_arlock       ({usr_arlock , ref_arlock }),
    .s_axi_arcache      ({usr_arcache, ref_arcache}),
    .s_axi_arprot       ({usr_arprot , ref_arprot }),
    .s_axi_arvalid      ({usr_arvalid, ref_arvalid}),
    .s_axi_arready      ({usr_arready, ref_arready}),
    .s_axi_rid          ({usr_rid    , ref_rid    }),
    .s_axi_rdata        ({usr_rdata  , ref_rdata  }),
    .s_axi_rresp        ({usr_rresp  , ref_rresp  }),
    .s_axi_rlast        ({usr_rlast  , ref_rlast  }),
    .s_axi_rvalid       ({usr_rvalid , ref_rvalid }),
    .s_axi_rready       ({usr_rready , ref_rready }),
    .m_axi_awid         (cpu_awid   ),
    .m_axi_awaddr       (cpu_awaddr ),
    .m_axi_awlen        (cpu_awlen  ),
    .m_axi_awsize       (cpu_awsize ),
    .m_axi_awburst      (cpu_awburst),
    .m_axi_awlock       (cpu_awlock ),
    .m_axi_awcache      (cpu_awcache),
    .m_axi_awprot       (cpu_awprot ),
    .m_axi_awvalid      (cpu_awvalid),
    .m_axi_awready      (cpu_awready),
    .m_axi_wdata        (cpu_wdata  ),
    .m_axi_wstrb        (cpu_wstrb  ),
    .m_axi_wlast        (cpu_wlast  ),
    .m_axi_wvalid       (cpu_wvalid ),
    .m_axi_wready       (cpu_wready ),
    .m_axi_bid          (cpu_bid    ),
    .m_axi_bresp        (cpu_bresp  ),
    .m_axi_bvalid       (cpu_bvalid ),
    .m_axi_bready       (cpu_bready ),
    .m_axi_arid         (cpu_arid   ),
    .m_axi_araddr       (cpu_araddr ),
    .m_axi_arlen        (cpu_arlen  ),
    .m_axi_arsize       (cpu_arsize ),
    .m_axi_arburst      (cpu_arburst),
    .m_axi_arlock       (cpu_arlock ),
    .m_axi_arcache      (cpu_arcache),
    .m_axi_arprot       (cpu_arprot ),
    .m_axi_arvalid      (cpu_arvalid),
    .m_axi_arready      (cpu_arready),
    .m_axi_rid          (cpu_rid    ),
    .m_axi_rdata        (cpu_rdata  ),
    .m_axi_rresp        (cpu_rresp  ),
    .m_axi_rlast        (cpu_rlast  ),
    .m_axi_rvalid       (cpu_rvalid ),
    .m_axi_rready       (cpu_rready )
);

//cpu axi wrap
assign cpu_wid = 4'h0;
axi_wrap u_cpu_axi_wrap(
  .m_aclk    ( cpu_clk     ),
  .m_aresetn ( cpu_resetn  ),
  //ar
  .m_arid    ( cpu_arid    ),
  .m_araddr  ( cpu_araddr  ),
  .m_arlen   ( cpu_arlen   ),
  .m_arsize  ( cpu_arsize  ),
  .m_arburst ( cpu_arburst ),
  .m_arlock  ({1'b0, cpu_arlock}),
  .m_arcache ( cpu_arcache ),
  .m_arprot  ( cpu_arprot  ),
  .m_arvalid ( cpu_arvalid ),
  .m_arready ( cpu_arready ),
  //r
  .m_rid     ( cpu_rid     ),
  .m_rdata   ( cpu_rdata   ),
  .m_rresp   ( cpu_rresp   ),
  .m_rlast   ( cpu_rlast   ),
  .m_rvalid  ( cpu_rvalid  ),
  .m_rready  ( cpu_rready  ),
  //aw
  .m_awid    ( cpu_awid    ),
  .m_awaddr  ( cpu_awaddr  ),
  .m_awlen   ( cpu_awlen   ),
  .m_awsize  ( cpu_awsize  ),
  .m_awburst ( cpu_awburst ),
  .m_awlock  ({1'b0, cpu_awlock}),
  .m_awcache ( cpu_awcache ),
  .m_awprot  ( cpu_awprot  ),
  .m_awvalid ( cpu_awvalid ),
  .m_awready ( cpu_awready ),
  //w
  .m_wid     ( cpu_wid     ),
  .m_wdata   ( cpu_wdata   ),
  .m_wstrb   ( cpu_wstrb   ),
  .m_wlast   ( cpu_wlast   ),
  .m_wvalid  ( cpu_wvalid  ),
  .m_wready  ( cpu_wready  ),
  //b
  .m_bid     ( cpu_bid     ),
  .m_bresp   ( cpu_bresp   ),
  .m_bvalid  ( cpu_bvalid  ),
  .m_bready  ( cpu_bready  ),

  .s_aclk    ( cpu_wrap_aclk    ),
  .s_aresetn ( cpu_wrap_aresetn ),
  //ar
  .s_arid    ( cpu_wrap_arid    ),
  .s_araddr  ( cpu_wrap_araddr  ),
  .s_arlen   ( cpu_wrap_arlen   ),
  .s_arsize  ( cpu_wrap_arsize  ),
  .s_arburst ( cpu_wrap_arburst ),
  .s_arlock  ( cpu_wrap_arlock  ),
  .s_arcache ( cpu_wrap_arcache ),
  .s_arprot  ( cpu_wrap_arprot  ),
  .s_arvalid ( cpu_wrap_arvalid ),
  .s_arready ( cpu_wrap_arready ),
  //r
  .s_rid     ( cpu_wrap_rid     ),
  .s_rdata   ( cpu_wrap_rdata   ),
  .s_rresp   ( cpu_wrap_rresp   ),
  .s_rlast   ( cpu_wrap_rlast   ),
  .s_rvalid  ( cpu_wrap_rvalid  ),
  .s_rready  ( cpu_wrap_rready  ),
  //aw
  .s_awid    ( cpu_wrap_awid    ),
  .s_awaddr  ( cpu_wrap_awaddr  ),
  .s_awlen   ( cpu_wrap_awlen   ),
  .s_awsize  ( cpu_wrap_awsize  ),
  .s_awburst ( cpu_wrap_awburst ),
  .s_awlock  ( cpu_wrap_awlock  ),
  .s_awcache ( cpu_wrap_awcache ),
  .s_awprot  ( cpu_wrap_awprot  ),
  .s_awvalid ( cpu_wrap_awvalid ),
  .s_awready ( cpu_wrap_awready ),
  //w
  .s_wid     ( cpu_wrap_wid     ),
  .s_wdata   ( cpu_wrap_wdata   ),
  .s_wstrb   ( cpu_wrap_wstrb   ),
  .s_wlast   ( cpu_wrap_wlast   ),
  .s_wvalid  ( cpu_wrap_wvalid  ),
  .s_wready  ( cpu_wrap_wready  ),
  //b
  .s_bid     ( cpu_wrap_bid     ),
  .s_bresp   ( cpu_wrap_bresp   ),
  .s_bvalid  ( cpu_wrap_bvalid  ),
  .s_bready  ( cpu_wrap_bready  ) 
);

axi_crossbar_1x2 u_axi_crossbar_1x2(
    .aclk             ( cpu_wrap_aclk        ), // i, 1                 
    .aresetn          ( cpu_wrap_aresetn     ), // i, 1                 

    .s_axi_arid       ( cpu_wrap_arid        ),
    .s_axi_araddr     ( cpu_wrap_araddr      ),
    .s_axi_arlen      ( cpu_wrap_arlen[3:0]  ),
    .s_axi_arsize     ( cpu_wrap_arsize      ),
    .s_axi_arburst    ( cpu_wrap_arburst     ),
    .s_axi_arlock     ( cpu_wrap_arlock      ),
    .s_axi_arcache    ( cpu_wrap_arcache     ),
    .s_axi_arprot     ( cpu_wrap_arprot      ),
    .s_axi_arqos      ( 4'd0                 ),
    .s_axi_arvalid    ( cpu_wrap_arvalid     ),
    .s_axi_arready    ( cpu_wrap_arready     ),
    .s_axi_rid        ( cpu_wrap_rid         ),
    .s_axi_rdata      ( cpu_wrap_rdata       ),
    .s_axi_rresp      ( cpu_wrap_rresp       ),
    .s_axi_rlast      ( cpu_wrap_rlast       ),
    .s_axi_rvalid     ( cpu_wrap_rvalid      ),
    .s_axi_rready     ( cpu_wrap_rready      ),
    .s_axi_awid       ( cpu_wrap_awid        ),
    .s_axi_awaddr     ( cpu_wrap_awaddr      ),
    .s_axi_awlen      ( cpu_wrap_awlen[3:0]  ),
    .s_axi_awsize     ( cpu_wrap_awsize      ),
    .s_axi_awburst    ( cpu_wrap_awburst     ),
    .s_axi_awlock     ( cpu_wrap_awlock      ),
    .s_axi_awcache    ( cpu_wrap_awcache     ),
    .s_axi_awprot     ( cpu_wrap_awprot      ),
    .s_axi_awqos      ( 4'd0                 ),
    .s_axi_awvalid    ( cpu_wrap_awvalid     ),
    .s_axi_awready    ( cpu_wrap_awready     ),
    .s_axi_wid        ( cpu_wrap_wid         ),
    .s_axi_wdata      ( cpu_wrap_wdata       ),
    .s_axi_wstrb      ( cpu_wrap_wstrb       ),
    .s_axi_wlast      ( cpu_wrap_wlast       ),
    .s_axi_wvalid     ( cpu_wrap_wvalid      ),
    .s_axi_wready     ( cpu_wrap_wready      ),
    .s_axi_bid        ( cpu_wrap_bid         ),
    .s_axi_bresp      ( cpu_wrap_bresp       ),
    .s_axi_bvalid     ( cpu_wrap_bvalid      ),
    .s_axi_bready     ( cpu_wrap_bready      ),

    .m_axi_arid       ( {ram_arid   ,conf_arid   } ),
    .m_axi_araddr     ( {ram_araddr ,conf_araddr } ),
    .m_axi_arlen      ( {ram_arlen  ,conf_arlen  } ),
    .m_axi_arsize     ( {ram_arsize ,conf_arsize } ),
    .m_axi_arburst    ( {ram_arburst,conf_arburst} ),
    .m_axi_arlock     ( {ram_arlock ,conf_arlock } ),
    .m_axi_arcache    ( {ram_arcache,conf_arcache} ),
    .m_axi_arprot     ( {ram_arprot ,conf_arprot } ),
    .m_axi_arqos      (                            ),
    .m_axi_arvalid    ( {ram_arvalid,conf_arvalid} ),
    .m_axi_arready    ( {ram_arready,conf_arready} ),
    .m_axi_rid        ( {ram_rid    ,conf_rid    } ),
    .m_axi_rdata      ( {ram_rdata  ,conf_rdata  } ),
    .m_axi_rresp      ( {ram_rresp  ,conf_rresp  } ),
    .m_axi_rlast      ( {ram_rlast  ,conf_rlast  } ),
    .m_axi_rvalid     ( {ram_rvalid ,conf_rvalid } ),
    .m_axi_rready     ( {ram_rready ,conf_rready } ),
    .m_axi_awid       ( {ram_awid   ,conf_awid   } ),
    .m_axi_awaddr     ( {ram_awaddr ,conf_awaddr } ),
    .m_axi_awlen      ( {ram_awlen  ,conf_awlen  } ),
    .m_axi_awsize     ( {ram_awsize ,conf_awsize } ),
    .m_axi_awburst    ( {ram_awburst,conf_awburst} ),
    .m_axi_awlock     ( {ram_awlock ,conf_awlock } ),
    .m_axi_awcache    ( {ram_awcache,conf_awcache} ),
    .m_axi_awprot     ( {ram_awprot ,conf_awprot } ),
    .m_axi_awqos      (                            ),
    .m_axi_awvalid    ( {ram_awvalid,conf_awvalid} ),
    .m_axi_awready    ( {ram_awready,conf_awready} ),
    .m_axi_wid        ( {ram_wid    ,conf_wid    } ),
    .m_axi_wdata      ( {ram_wdata  ,conf_wdata  } ),
    .m_axi_wstrb      ( {ram_wstrb  ,conf_wstrb  } ),
    .m_axi_wlast      ( {ram_wlast  ,conf_wlast  } ),
    .m_axi_wvalid     ( {ram_wvalid ,conf_wvalid } ),
    .m_axi_wready     ( {ram_wready ,conf_wready } ),
    .m_axi_bid        ( {ram_bid    ,conf_bid    } ),
    .m_axi_bresp      ( {ram_bresp  ,conf_bresp  } ),
    .m_axi_bvalid     ( {ram_bvalid ,conf_bvalid } ),
    .m_axi_bready     ( {ram_bready ,conf_bready } )

 );

//axi ram
axi_wrap_ram u_axi_ram
(
    .aclk          ( cpu_clk          ),
    .aresetn       ( cpu_resetn       ),
    //ar
    .axi_arid      ( ram_arid         ),
    .axi_araddr    ( ram_araddr       ),
    .axi_arlen     ( {4'd0,ram_arlen} ),
    .axi_arsize    ( ram_arsize       ),
    .axi_arburst   ( ram_arburst      ),
    .axi_arlock    ( ram_arlock       ),
    .axi_arcache   ( ram_arcache      ),
    .axi_arprot    ( ram_arprot       ),
    .axi_arvalid   ( ram_arvalid      ),
    .axi_arready   ( ram_arready      ),
    //r             
    .axi_rid       ( ram_rid          ),
    .axi_rdata     ( ram_rdata        ),
    .axi_rresp     ( ram_rresp        ),
    .axi_rlast     ( ram_rlast        ),
    .axi_rvalid    ( ram_rvalid       ),
    .axi_rready    ( ram_rready       ),
    //aw           
    .axi_awid      ( ram_awid         ),
    .axi_awaddr    ( ram_awaddr       ),
    .axi_awlen     ( {4'd0,ram_awlen[3:0]}        ),
    .axi_awsize    ( ram_awsize       ),
    .axi_awburst   ( ram_awburst      ),
    .axi_awlock    ( ram_awlock       ),
    .axi_awcache   ( ram_awcache      ),
    .axi_awprot    ( ram_awprot       ),
    .axi_awvalid   ( ram_awvalid      ),
    .axi_awready   ( ram_awready      ),
    //w          
    .axi_wid       ( ram_wid          ),
    .axi_wdata     ( ram_wdata        ),
    .axi_wstrb     ( ram_wstrb        ),
    .axi_wlast     ( ram_wlast        ),
    .axi_wvalid    ( ram_wvalid       ),
    .axi_wready    ( ram_wready       ),
    //b              ram
    .axi_bid       ( ram_bid          ),
    .axi_bresp     ( ram_bresp        ),
    .axi_bvalid    ( ram_bvalid       ),
    .axi_bready    ( ram_bready       ),

    //random mask
    .ram_random_mask ( ram_random_mask )
);

//confreg
confreg #(.SIMULATION(SIMULATION)) u_confreg
(
    .timer_clk   ( timer_clk  ),  // i, 1   
    .aclk        ( cpu_clk    ),  // i, 1   
    .aresetn     ( cpu_resetn ),  // i, 1    

    .arid        (conf_arid    ),
    .araddr      (conf_araddr  ),
    .arlen       (conf_arlen   ),
    .arsize      (conf_arsize  ),
    .arburst     (conf_arburst ),
    .arlock      (conf_arlock  ),
    .arcache     (conf_arcache ),
    .arprot      (conf_arprot  ),
    .arvalid     (conf_arvalid ),
    .arready     (conf_arready ),
    .rid         (conf_rid     ),
    .rdata       (conf_rdata   ),
    .rresp       (conf_rresp   ),
    .rlast       (conf_rlast   ),
    .rvalid      (conf_rvalid  ),
    .rready      (conf_rready  ),
    .awid        (conf_awid    ),
    .awaddr      (conf_awaddr  ),
    .awlen       (conf_awlen   ),
    .awsize      (conf_awsize  ),
    .awburst     (conf_awburst ),
    .awlock      (conf_awlock  ),
    .awcache     (conf_awcache ),
    .awprot      (conf_awprot  ),
    .awvalid     (conf_awvalid ),
    .awready     (conf_awready ),
    .wid         (conf_wid     ),
    .wdata       (conf_wdata   ),
    .wstrb       (conf_wstrb   ),
    .wlast       (conf_wlast   ),
    .wvalid      (conf_wvalid  ),
    .wready      (conf_wready  ),
    .bid         (conf_bid     ),
    .bresp       (conf_bresp   ),
    .bvalid      (conf_bvalid  ),
    .bready      (conf_bready  ), 

    .ram_random_mask ( ram_random_mask ),
    .led         ( led        ),  // o, 16   
    .led_rg0     ( led_rg0    ),  // o, 2      
    .led_rg1     ( led_rg1    ),  // o, 2      
    .num_csn     ( num_csn    ),  // o, 8      
    .num_a_g     ( num_a_g    ),  // o, 7      
    .num_data    ( num_data   ),  // o, 32
    .switch      ( switch     ),  // i, 8     
    .btn_key_col ( btn_key_col),  // o, 4          
    .btn_key_row ( btn_key_row),  // i, 4           
    .btn_step    ( btn_step   )   // i, 2   
);

endmodule

