`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module axi_master
   (aclk,
    aresetn,
    ic_dev_rrdy,
    ic_cpu_ren,
    ic_cpu_raddr,
    ic_dev_rvalid,
    ic_dev_rdata,
    dc_dev_wrdy,
    dc_cpu_wen,
    dc_cpu_waddr,
    dc_cpu_wdata,
    dc_dev_rrdy,
    dc_cpu_ren,
    dc_cpu_raddr,
    dc_dev_rvalid,
    dc_dev_rdata,
    m_axi_awid,
    m_axi_awaddr,
    m_axi_awlen,
    m_axi_awsize,
    m_axi_awburst,
    m_axi_awlock,
    m_axi_awcache,
    m_axi_awprot,
    m_axi_awvalid,
    m_axi_awready,
    m_axi_wid,
    m_axi_wdata,
    m_axi_wstrb,
    m_axi_wlast,
    m_axi_wvalid,
    m_axi_wready,
    m_axi_bid,
    m_axi_bready,
    m_axi_bresp,
    m_axi_bvalid,
    m_axi_arid,
    m_axi_araddr,
    m_axi_arlen,
    m_axi_arsize,
    m_axi_arburst,
    m_axi_arlock,
    m_axi_arcache,
    m_axi_arprot,
    m_axi_arvalid,
    m_axi_arready,
    m_axi_rid,
    m_axi_rready,
    m_axi_rdata,
    m_axi_rresp,
    m_axi_rlast,
    m_axi_rvalid);
  input aclk;
  input aresetn;
  output ic_dev_rrdy;
  input ic_cpu_ren;
  input [31:0]ic_cpu_raddr;
  output ic_dev_rvalid;
  output [127:0]ic_dev_rdata;
  output dc_dev_wrdy;
  input [3:0]dc_cpu_wen;
  input [31:0]dc_cpu_waddr;
  input [31:0]dc_cpu_wdata;
  output dc_dev_rrdy;
  input dc_cpu_ren;
  input [31:0]dc_cpu_raddr;
  output dc_dev_rvalid;
  output [127:0]dc_dev_rdata;
  output [3:0]m_axi_awid;
  output [31:0]m_axi_awaddr;
  output [7:0]m_axi_awlen;
  output [2:0]m_axi_awsize;
  output [1:0]m_axi_awburst;
  output [1:0]m_axi_awlock;
  output [3:0]m_axi_awcache;
  output [2:0]m_axi_awprot;
  output m_axi_awvalid;
  input m_axi_awready;
  output [3:0]m_axi_wid;
  output [31:0]m_axi_wdata;
  output [3:0]m_axi_wstrb;
  output m_axi_wlast;
  output m_axi_wvalid;
  input m_axi_wready;
  input [3:0]m_axi_bid;
  output m_axi_bready;
  input [1:0]m_axi_bresp;
  input m_axi_bvalid;
  output [3:0]m_axi_arid;
  output [31:0]m_axi_araddr;
  output [7:0]m_axi_arlen;
  output [2:0]m_axi_arsize;
  output [1:0]m_axi_arburst;
  output [1:0]m_axi_arlock;
  output [3:0]m_axi_arcache;
  output [2:0]m_axi_arprot;
  output m_axi_arvalid;
  input m_axi_arready;
  input [3:0]m_axi_rid;
  output m_axi_rready;
  input [31:0]m_axi_rdata;
  input [1:0]m_axi_rresp;
  input m_axi_rlast;
  input m_axi_rvalid;

  wire \<const0> ;
  wire \<const1> ;
  wire aclk;
  wire aresetn;
  wire [31:0]dc_cpu_raddr;
  wire dc_cpu_ren;
  wire [31:0]dc_cpu_waddr;
  wire [31:0]dc_cpu_wdata;
  wire [3:0]dc_cpu_wen;
  wire [127:0]dc_dev_rdata;
  wire \dc_dev_rdata[127]_i_1_n_0 ;
  wire \dc_dev_rdata[31]_i_1_n_0 ;
  wire \dc_dev_rdata[63]_i_1_n_0 ;
  wire \dc_dev_rdata[95]_i_1_n_0 ;
  wire dc_dev_rrdy;
  wire dc_dev_rrdy_i_1_n_0;
  wire dc_dev_rvalid;
  wire dc_dev_rvalid_i_1_n_0;
  wire dc_dev_wrdy;
  wire dc_dev_wrdy_i_1_n_0;
  wire dc_dev_wrdy_i_2_n_0;
  wire \dc_recv_cnt[5]_i_1_n_0 ;
  wire \dc_recv_cnt[6]_i_1_n_0 ;
  wire \dc_recv_cnt[7]_i_1_n_0 ;
  wire [7:5]dc_recv_cnt_reg__0;
  wire has_dc_rd_req;
  wire has_dc_rd_req_r;
  wire has_dc_rd_req_r_i_1_n_0;
  wire has_dc_wr_req;
  wire has_ic_rd_req_r;
  wire has_ic_rd_req_r_i_1_n_0;
  wire has_rd_req;
  wire [31:0]ic_cpu_raddr;
  wire ic_cpu_ren;
  wire [127:0]ic_dev_rdata;
  wire \ic_dev_rdata[121]_i_1_n_0 ;
  wire \ic_dev_rdata[127]_i_2_n_0 ;
  wire ic_dev_rrdy;
  wire ic_dev_rrdy_i_1_n_0;
  wire ic_dev_rrdy_i_2_n_0;
  wire ic_dev_rvalid;
  wire ic_dev_rvalid_i_1_n_0;
  wire ic_recv_cnt;
  wire \ic_recv_cnt[5]_i_1_n_0 ;
  wire \ic_recv_cnt[6]_i_1_n_0 ;
  wire \ic_recv_cnt[7]_i_1_n_0 ;
  wire [7:5]ic_recv_cnt_reg__0;
  wire [31:0]m_axi_araddr;
  wire \m_axi_araddr[0]_i_1_n_0 ;
  wire \m_axi_araddr[10]_i_1_n_0 ;
  wire \m_axi_araddr[11]_i_1_n_0 ;
  wire \m_axi_araddr[12]_i_1_n_0 ;
  wire \m_axi_araddr[13]_i_1_n_0 ;
  wire \m_axi_araddr[14]_i_1_n_0 ;
  wire \m_axi_araddr[15]_i_1_n_0 ;
  wire \m_axi_araddr[16]_i_1_n_0 ;
  wire \m_axi_araddr[17]_i_1_n_0 ;
  wire \m_axi_araddr[18]_i_1_n_0 ;
  wire \m_axi_araddr[19]_i_1_n_0 ;
  wire \m_axi_araddr[1]_i_1_n_0 ;
  wire \m_axi_araddr[20]_i_1_n_0 ;
  wire \m_axi_araddr[21]_i_1_n_0 ;
  wire \m_axi_araddr[22]_i_1_n_0 ;
  wire \m_axi_araddr[23]_i_1_n_0 ;
  wire \m_axi_araddr[24]_i_1_n_0 ;
  wire \m_axi_araddr[25]_i_1_n_0 ;
  wire \m_axi_araddr[26]_i_1_n_0 ;
  wire \m_axi_araddr[27]_i_1_n_0 ;
  wire \m_axi_araddr[28]_i_1_n_0 ;
  wire \m_axi_araddr[29]_i_1_n_0 ;
  wire \m_axi_araddr[2]_i_1_n_0 ;
  wire \m_axi_araddr[30]_i_1_n_0 ;
  wire \m_axi_araddr[31]_i_2_n_0 ;
  wire \m_axi_araddr[3]_i_1_n_0 ;
  wire \m_axi_araddr[4]_i_1_n_0 ;
  wire \m_axi_araddr[5]_i_1_n_0 ;
  wire \m_axi_araddr[6]_i_1_n_0 ;
  wire \m_axi_araddr[7]_i_1_n_0 ;
  wire \m_axi_araddr[8]_i_1_n_0 ;
  wire \m_axi_araddr[9]_i_1_n_0 ;
  wire [0:0]\^m_axi_arlen ;
  wire \m_axi_arlen[1]_i_1_n_0 ;
  wire m_axi_arready;
  wire m_axi_arvalid;
  wire m_axi_arvalid_i_1_n_0;
  wire [31:0]m_axi_awaddr;
  wire \m_axi_awaddr[31]_i_1_n_0 ;
  wire [0:0]\^m_axi_awburst ;
  wire m_axi_awready;
  wire \m_axi_awsize[1]_i_1_n_0 ;
  wire m_axi_awvalid;
  wire m_axi_awvalid_i_1_n_0;
  wire m_axi_bvalid;
  wire [31:0]m_axi_rdata;
  wire m_axi_rlast;
  wire m_axi_rready;
  wire m_axi_rvalid;
  wire [31:0]m_axi_wdata;
  wire \m_axi_wdata[31]_i_1_n_0 ;
  wire m_axi_wlast;
  wire m_axi_wready;
  wire [3:0]m_axi_wstrb;
  wire m_axi_wvalid_i_1_n_0;
  wire [127:31]p_0_in;

  assign m_axi_arburst[1] = \<const0> ;
  assign m_axi_arburst[0] = \^m_axi_arlen [0];
  assign m_axi_arcache[3] = \<const0> ;
  assign m_axi_arcache[2] = \<const0> ;
  assign m_axi_arcache[1] = \<const1> ;
  assign m_axi_arcache[0] = \<const0> ;
  assign m_axi_arid[3] = \<const1> ;
  assign m_axi_arid[2] = \<const0> ;
  assign m_axi_arid[1] = \<const0> ;
  assign m_axi_arid[0] = \<const0> ;
  assign m_axi_arlen[7] = \<const0> ;
  assign m_axi_arlen[6] = \<const0> ;
  assign m_axi_arlen[5] = \<const0> ;
  assign m_axi_arlen[4] = \<const0> ;
  assign m_axi_arlen[3] = \<const0> ;
  assign m_axi_arlen[2] = \<const0> ;
  assign m_axi_arlen[1] = \^m_axi_arlen [0];
  assign m_axi_arlen[0] = \^m_axi_arlen [0];
  assign m_axi_arlock[1] = \<const0> ;
  assign m_axi_arlock[0] = \<const0> ;
  assign m_axi_arprot[2] = \<const0> ;
  assign m_axi_arprot[1] = \<const0> ;
  assign m_axi_arprot[0] = \<const0> ;
  assign m_axi_arsize[2] = \<const0> ;
  assign m_axi_arsize[1] = \^m_axi_arlen [0];
  assign m_axi_arsize[0] = \<const0> ;
  assign m_axi_awburst[1] = \<const0> ;
  assign m_axi_awburst[0] = \^m_axi_awburst [0];
  assign m_axi_awcache[3] = \<const0> ;
  assign m_axi_awcache[2] = \<const0> ;
  assign m_axi_awcache[1] = \<const1> ;
  assign m_axi_awcache[0] = \<const0> ;
  assign m_axi_awid[3] = \<const1> ;
  assign m_axi_awid[2] = \<const0> ;
  assign m_axi_awid[1] = \<const0> ;
  assign m_axi_awid[0] = \<const0> ;
  assign m_axi_awlen[7] = \<const0> ;
  assign m_axi_awlen[6] = \<const0> ;
  assign m_axi_awlen[5] = \<const0> ;
  assign m_axi_awlen[4] = \<const0> ;
  assign m_axi_awlen[3] = \<const0> ;
  assign m_axi_awlen[2] = \<const0> ;
  assign m_axi_awlen[1] = \<const0> ;
  assign m_axi_awlen[0] = \<const0> ;
  assign m_axi_awlock[1] = \<const0> ;
  assign m_axi_awlock[0] = \<const0> ;
  assign m_axi_awprot[2] = \<const0> ;
  assign m_axi_awprot[1] = \<const0> ;
  assign m_axi_awprot[0] = \<const0> ;
  assign m_axi_awsize[2] = \<const0> ;
  assign m_axi_awsize[1] = \^m_axi_awburst [0];
  assign m_axi_awsize[0] = \<const0> ;
  assign m_axi_bready = m_axi_rready;
  assign m_axi_wid[3] = \<const1> ;
  assign m_axi_wid[2] = \<const0> ;
  assign m_axi_wid[1] = \<const0> ;
  assign m_axi_wid[0] = \<const0> ;
  assign m_axi_wvalid = m_axi_wlast;
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT5 #(
    .INIT(32'h08000000)) 
    \dc_dev_rdata[127]_i_1 
       (.I0(m_axi_rvalid),
        .I1(dc_recv_cnt_reg__0[6]),
        .I2(dc_recv_cnt_reg__0[7]),
        .I3(dc_recv_cnt_reg__0[5]),
        .I4(has_dc_rd_req_r),
        .O(\dc_dev_rdata[127]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00020000)) 
    \dc_dev_rdata[31]_i_1 
       (.I0(m_axi_rvalid),
        .I1(dc_recv_cnt_reg__0[5]),
        .I2(dc_recv_cnt_reg__0[7]),
        .I3(dc_recv_cnt_reg__0[6]),
        .I4(has_dc_rd_req_r),
        .O(\dc_dev_rdata[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00200000)) 
    \dc_dev_rdata[63]_i_1 
       (.I0(m_axi_rvalid),
        .I1(dc_recv_cnt_reg__0[7]),
        .I2(dc_recv_cnt_reg__0[5]),
        .I3(dc_recv_cnt_reg__0[6]),
        .I4(has_dc_rd_req_r),
        .O(\dc_dev_rdata[63]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00080000)) 
    \dc_dev_rdata[95]_i_1 
       (.I0(m_axi_rvalid),
        .I1(dc_recv_cnt_reg__0[6]),
        .I2(dc_recv_cnt_reg__0[5]),
        .I3(dc_recv_cnt_reg__0[7]),
        .I4(has_dc_rd_req_r),
        .O(\dc_dev_rdata[95]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[0] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[0]),
        .Q(dc_dev_rdata[0]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[100] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[4]),
        .Q(dc_dev_rdata[100]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[101] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[5]),
        .Q(dc_dev_rdata[101]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[102] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[6]),
        .Q(dc_dev_rdata[102]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[103] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[7]),
        .Q(dc_dev_rdata[103]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[104] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[8]),
        .Q(dc_dev_rdata[104]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[105] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[9]),
        .Q(dc_dev_rdata[105]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[106] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[10]),
        .Q(dc_dev_rdata[106]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[107] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[11]),
        .Q(dc_dev_rdata[107]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[108] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[12]),
        .Q(dc_dev_rdata[108]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[109] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[13]),
        .Q(dc_dev_rdata[109]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[10] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[10]),
        .Q(dc_dev_rdata[10]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[110] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[14]),
        .Q(dc_dev_rdata[110]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[111] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[15]),
        .Q(dc_dev_rdata[111]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[112] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[16]),
        .Q(dc_dev_rdata[112]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[113] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[17]),
        .Q(dc_dev_rdata[113]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[114] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[18]),
        .Q(dc_dev_rdata[114]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[115] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[19]),
        .Q(dc_dev_rdata[115]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[116] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[20]),
        .Q(dc_dev_rdata[116]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[117] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[21]),
        .Q(dc_dev_rdata[117]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[118] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[22]),
        .Q(dc_dev_rdata[118]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[119] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[23]),
        .Q(dc_dev_rdata[119]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[11] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[11]),
        .Q(dc_dev_rdata[11]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[120] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[24]),
        .Q(dc_dev_rdata[120]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[121] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[25]),
        .Q(dc_dev_rdata[121]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[122] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[26]),
        .Q(dc_dev_rdata[122]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[123] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[27]),
        .Q(dc_dev_rdata[123]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[124] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[28]),
        .Q(dc_dev_rdata[124]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[125] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[29]),
        .Q(dc_dev_rdata[125]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[126] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[30]),
        .Q(dc_dev_rdata[126]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[127] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[31]),
        .Q(dc_dev_rdata[127]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[12] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[12]),
        .Q(dc_dev_rdata[12]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[13] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[13]),
        .Q(dc_dev_rdata[13]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[14] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[14]),
        .Q(dc_dev_rdata[14]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[15] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[15]),
        .Q(dc_dev_rdata[15]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[16] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[16]),
        .Q(dc_dev_rdata[16]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[17] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[17]),
        .Q(dc_dev_rdata[17]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[18] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[18]),
        .Q(dc_dev_rdata[18]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[19] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[19]),
        .Q(dc_dev_rdata[19]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[1] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[1]),
        .Q(dc_dev_rdata[1]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[20] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[20]),
        .Q(dc_dev_rdata[20]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[21] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[21]),
        .Q(dc_dev_rdata[21]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[22] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[22]),
        .Q(dc_dev_rdata[22]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[23] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[23]),
        .Q(dc_dev_rdata[23]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[24] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[24]),
        .Q(dc_dev_rdata[24]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[25] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[25]),
        .Q(dc_dev_rdata[25]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[26] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[26]),
        .Q(dc_dev_rdata[26]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[27] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[27]),
        .Q(dc_dev_rdata[27]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[28] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[28]),
        .Q(dc_dev_rdata[28]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[29] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[29]),
        .Q(dc_dev_rdata[29]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[2] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[2]),
        .Q(dc_dev_rdata[2]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[30] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[30]),
        .Q(dc_dev_rdata[30]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[31] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[31]),
        .Q(dc_dev_rdata[31]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[32] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[0]),
        .Q(dc_dev_rdata[32]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[33] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[1]),
        .Q(dc_dev_rdata[33]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[34] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[2]),
        .Q(dc_dev_rdata[34]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[35] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[3]),
        .Q(dc_dev_rdata[35]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[36] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[4]),
        .Q(dc_dev_rdata[36]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[37] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[5]),
        .Q(dc_dev_rdata[37]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[38] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[6]),
        .Q(dc_dev_rdata[38]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[39] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[7]),
        .Q(dc_dev_rdata[39]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[3] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[3]),
        .Q(dc_dev_rdata[3]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[40] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[8]),
        .Q(dc_dev_rdata[40]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[41] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[9]),
        .Q(dc_dev_rdata[41]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[42] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[10]),
        .Q(dc_dev_rdata[42]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[43] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[11]),
        .Q(dc_dev_rdata[43]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[44] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[12]),
        .Q(dc_dev_rdata[44]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[45] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[13]),
        .Q(dc_dev_rdata[45]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[46] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[14]),
        .Q(dc_dev_rdata[46]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[47] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[15]),
        .Q(dc_dev_rdata[47]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[48] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[16]),
        .Q(dc_dev_rdata[48]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[49] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[17]),
        .Q(dc_dev_rdata[49]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[4] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[4]),
        .Q(dc_dev_rdata[4]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[50] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[18]),
        .Q(dc_dev_rdata[50]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[51] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[19]),
        .Q(dc_dev_rdata[51]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[52] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[20]),
        .Q(dc_dev_rdata[52]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[53] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[21]),
        .Q(dc_dev_rdata[53]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[54] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[22]),
        .Q(dc_dev_rdata[54]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[55] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[23]),
        .Q(dc_dev_rdata[55]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[56] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[24]),
        .Q(dc_dev_rdata[56]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[57] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[25]),
        .Q(dc_dev_rdata[57]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[58] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[26]),
        .Q(dc_dev_rdata[58]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[59] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[27]),
        .Q(dc_dev_rdata[59]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[5] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[5]),
        .Q(dc_dev_rdata[5]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[60] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[28]),
        .Q(dc_dev_rdata[60]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[61] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[29]),
        .Q(dc_dev_rdata[61]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[62] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[30]),
        .Q(dc_dev_rdata[62]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[63] 
       (.C(aclk),
        .CE(\dc_dev_rdata[63]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[31]),
        .Q(dc_dev_rdata[63]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[64] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[0]),
        .Q(dc_dev_rdata[64]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[65] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[1]),
        .Q(dc_dev_rdata[65]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[66] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[2]),
        .Q(dc_dev_rdata[66]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[67] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[3]),
        .Q(dc_dev_rdata[67]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[68] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[4]),
        .Q(dc_dev_rdata[68]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[69] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[5]),
        .Q(dc_dev_rdata[69]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[6] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[6]),
        .Q(dc_dev_rdata[6]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[70] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[6]),
        .Q(dc_dev_rdata[70]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[71] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[7]),
        .Q(dc_dev_rdata[71]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[72] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[8]),
        .Q(dc_dev_rdata[72]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[73] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[9]),
        .Q(dc_dev_rdata[73]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[74] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[10]),
        .Q(dc_dev_rdata[74]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[75] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[11]),
        .Q(dc_dev_rdata[75]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[76] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[12]),
        .Q(dc_dev_rdata[76]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[77] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[13]),
        .Q(dc_dev_rdata[77]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[78] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[14]),
        .Q(dc_dev_rdata[78]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[79] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[15]),
        .Q(dc_dev_rdata[79]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[7] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[7]),
        .Q(dc_dev_rdata[7]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[80] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[16]),
        .Q(dc_dev_rdata[80]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[81] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[17]),
        .Q(dc_dev_rdata[81]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[82] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[18]),
        .Q(dc_dev_rdata[82]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[83] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[19]),
        .Q(dc_dev_rdata[83]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[84] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[20]),
        .Q(dc_dev_rdata[84]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[85] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[21]),
        .Q(dc_dev_rdata[85]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[86] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[22]),
        .Q(dc_dev_rdata[86]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[87] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[23]),
        .Q(dc_dev_rdata[87]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[88] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[24]),
        .Q(dc_dev_rdata[88]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[89] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[25]),
        .Q(dc_dev_rdata[89]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[8] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[8]),
        .Q(dc_dev_rdata[8]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[90] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[26]),
        .Q(dc_dev_rdata[90]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[91] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[27]),
        .Q(dc_dev_rdata[91]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[92] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[28]),
        .Q(dc_dev_rdata[92]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[93] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[29]),
        .Q(dc_dev_rdata[93]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[94] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[30]),
        .Q(dc_dev_rdata[94]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[95] 
       (.C(aclk),
        .CE(\dc_dev_rdata[95]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[31]),
        .Q(dc_dev_rdata[95]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[96] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[0]),
        .Q(dc_dev_rdata[96]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[97] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[1]),
        .Q(dc_dev_rdata[97]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[98] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[2]),
        .Q(dc_dev_rdata[98]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[99] 
       (.C(aclk),
        .CE(\dc_dev_rdata[127]_i_1_n_0 ),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_rdata[3]),
        .Q(dc_dev_rdata[99]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_dev_rdata_reg[9] 
       (.C(aclk),
        .CE(\dc_dev_rdata[31]_i_1_n_0 ),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[9]),
        .Q(dc_dev_rdata[9]));
  LUT4 #(
    .INIT(16'hD5C0)) 
    dc_dev_rrdy_i_1
       (.I0(has_dc_rd_req_r),
        .I1(m_axi_rlast),
        .I2(m_axi_rvalid),
        .I3(dc_dev_rrdy),
        .O(dc_dev_rrdy_i_1_n_0));
  FDPE #(
    .INIT(1'b1)) 
    dc_dev_rrdy_reg
       (.C(aclk),
        .CE(1'b1),
        .D(dc_dev_rrdy_i_1_n_0),
        .PRE(ic_dev_rrdy_i_2_n_0),
        .Q(dc_dev_rrdy));
  LUT5 #(
    .INIT(32'h00004000)) 
    dc_dev_rvalid_i_1
       (.I0(ic_dev_rvalid),
        .I1(m_axi_rlast),
        .I2(m_axi_rvalid),
        .I3(has_dc_rd_req_r),
        .I4(dc_dev_rvalid),
        .O(dc_dev_rvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    dc_dev_rvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(dc_dev_rvalid_i_1_n_0),
        .Q(dc_dev_rvalid));
  LUT6 #(
    .INIT(64'hFFFFFFFF00010000)) 
    dc_dev_wrdy_i_1
       (.I0(dc_cpu_wen[3]),
        .I1(dc_cpu_wen[2]),
        .I2(dc_cpu_wen[0]),
        .I3(dc_cpu_wen[1]),
        .I4(dc_dev_wrdy),
        .I5(m_axi_bvalid),
        .O(dc_dev_wrdy_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    dc_dev_wrdy_i_2
       (.I0(aresetn),
        .O(dc_dev_wrdy_i_2_n_0));
  FDPE #(
    .INIT(1'b1)) 
    dc_dev_wrdy_reg
       (.C(aclk),
        .CE(1'b1),
        .D(dc_dev_wrdy_i_1_n_0),
        .PRE(dc_dev_wrdy_i_2_n_0),
        .Q(dc_dev_wrdy));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h3F40)) 
    \dc_recv_cnt[5]_i_1 
       (.I0(m_axi_rlast),
        .I1(m_axi_rvalid),
        .I2(has_dc_rd_req_r),
        .I3(dc_recv_cnt_reg__0[5]),
        .O(\dc_recv_cnt[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h1FFF2000)) 
    \dc_recv_cnt[6]_i_1 
       (.I0(dc_recv_cnt_reg__0[5]),
        .I1(m_axi_rlast),
        .I2(m_axi_rvalid),
        .I3(has_dc_rd_req_r),
        .I4(dc_recv_cnt_reg__0[6]),
        .O(\dc_recv_cnt[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h07FFFFFF08000000)) 
    \dc_recv_cnt[7]_i_1 
       (.I0(dc_recv_cnt_reg__0[6]),
        .I1(dc_recv_cnt_reg__0[5]),
        .I2(m_axi_rlast),
        .I3(m_axi_rvalid),
        .I4(has_dc_rd_req_r),
        .I5(dc_recv_cnt_reg__0[7]),
        .O(\dc_recv_cnt[7]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \dc_recv_cnt_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\dc_recv_cnt[5]_i_1_n_0 ),
        .Q(dc_recv_cnt_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_recv_cnt_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\dc_recv_cnt[6]_i_1_n_0 ),
        .Q(dc_recv_cnt_reg__0[6]));
  FDCE #(
    .INIT(1'b0)) 
    \dc_recv_cnt_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\dc_recv_cnt[7]_i_1_n_0 ),
        .Q(dc_recv_cnt_reg__0[7]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0FFF0888)) 
    has_dc_rd_req_r_i_1
       (.I0(dc_cpu_ren),
        .I1(dc_dev_rrdy),
        .I2(m_axi_rlast),
        .I3(m_axi_rvalid),
        .I4(has_dc_rd_req_r),
        .O(has_dc_rd_req_r_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    has_dc_rd_req_r_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(has_dc_rd_req_r_i_1_n_0),
        .Q(has_dc_rd_req_r));
  LUT5 #(
    .INIT(32'h0FFF0888)) 
    has_ic_rd_req_r_i_1
       (.I0(ic_cpu_ren),
        .I1(ic_dev_rrdy),
        .I2(m_axi_rlast),
        .I3(m_axi_rvalid),
        .I4(has_ic_rd_req_r),
        .O(has_ic_rd_req_r_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    has_ic_rd_req_r_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(has_ic_rd_req_r_i_1_n_0),
        .Q(has_ic_rd_req_r));
  LUT1 #(
    .INIT(2'h1)) 
    \ic_dev_rdata[121]_i_1 
       (.I0(aresetn),
        .O(\ic_dev_rdata[121]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000200000000000)) 
    \ic_dev_rdata[127]_i_1 
       (.I0(m_axi_rvalid),
        .I1(has_dc_rd_req_r),
        .I2(has_ic_rd_req_r),
        .I3(ic_recv_cnt_reg__0[5]),
        .I4(ic_recv_cnt_reg__0[7]),
        .I5(ic_recv_cnt_reg__0[6]),
        .O(p_0_in[127]));
  LUT1 #(
    .INIT(2'h1)) 
    \ic_dev_rdata[127]_i_2 
       (.I0(aresetn),
        .O(\ic_dev_rdata[127]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000020)) 
    \ic_dev_rdata[31]_i_1 
       (.I0(m_axi_rvalid),
        .I1(has_dc_rd_req_r),
        .I2(has_ic_rd_req_r),
        .I3(ic_recv_cnt_reg__0[6]),
        .I4(ic_recv_cnt_reg__0[7]),
        .I5(ic_recv_cnt_reg__0[5]),
        .O(p_0_in[31]));
  LUT6 #(
    .INIT(64'h0000000000200000)) 
    \ic_dev_rdata[63]_i_1 
       (.I0(m_axi_rvalid),
        .I1(has_dc_rd_req_r),
        .I2(has_ic_rd_req_r),
        .I3(ic_recv_cnt_reg__0[6]),
        .I4(ic_recv_cnt_reg__0[5]),
        .I5(ic_recv_cnt_reg__0[7]),
        .O(p_0_in[63]));
  LUT6 #(
    .INIT(64'h0000002000000000)) 
    \ic_dev_rdata[95]_i_1 
       (.I0(m_axi_rvalid),
        .I1(has_dc_rd_req_r),
        .I2(has_ic_rd_req_r),
        .I3(ic_recv_cnt_reg__0[7]),
        .I4(ic_recv_cnt_reg__0[5]),
        .I5(ic_recv_cnt_reg__0[6]),
        .O(p_0_in[95]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[0] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[0]),
        .Q(ic_dev_rdata[0]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[100] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[4]),
        .Q(ic_dev_rdata[100]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[101] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[5]),
        .Q(ic_dev_rdata[101]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[102] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[6]),
        .Q(ic_dev_rdata[102]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[103] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[7]),
        .Q(ic_dev_rdata[103]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[104] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[8]),
        .Q(ic_dev_rdata[104]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[105] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[9]),
        .Q(ic_dev_rdata[105]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[106] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[10]),
        .Q(ic_dev_rdata[106]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[107] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[11]),
        .Q(ic_dev_rdata[107]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[108] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[12]),
        .Q(ic_dev_rdata[108]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[109] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[13]),
        .Q(ic_dev_rdata[109]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[10] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[10]),
        .Q(ic_dev_rdata[10]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[110] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[14]),
        .Q(ic_dev_rdata[110]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[111] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[15]),
        .Q(ic_dev_rdata[111]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[112] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[16]),
        .Q(ic_dev_rdata[112]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[113] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[17]),
        .Q(ic_dev_rdata[113]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[114] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[18]),
        .Q(ic_dev_rdata[114]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[115] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[19]),
        .Q(ic_dev_rdata[115]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[116] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[20]),
        .Q(ic_dev_rdata[116]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[117] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[21]),
        .Q(ic_dev_rdata[117]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[118] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[22]),
        .Q(ic_dev_rdata[118]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[119] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[23]),
        .Q(ic_dev_rdata[119]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[11] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[11]),
        .Q(ic_dev_rdata[11]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[120] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[24]),
        .Q(ic_dev_rdata[120]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[121] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[25]),
        .Q(ic_dev_rdata[121]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[122] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[26]),
        .Q(ic_dev_rdata[122]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[123] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[27]),
        .Q(ic_dev_rdata[123]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[124] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[28]),
        .Q(ic_dev_rdata[124]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[125] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[29]),
        .Q(ic_dev_rdata[125]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[126] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[30]),
        .Q(ic_dev_rdata[126]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[127] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[31]),
        .Q(ic_dev_rdata[127]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[12] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[12]),
        .Q(ic_dev_rdata[12]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[13] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[13]),
        .Q(ic_dev_rdata[13]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[14] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[14]),
        .Q(ic_dev_rdata[14]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[15] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[15]),
        .Q(ic_dev_rdata[15]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[16] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[16]),
        .Q(ic_dev_rdata[16]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[17] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[17]),
        .Q(ic_dev_rdata[17]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[18] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[18]),
        .Q(ic_dev_rdata[18]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[19] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[19]),
        .Q(ic_dev_rdata[19]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[1] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[1]),
        .Q(ic_dev_rdata[1]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[20] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[20]),
        .Q(ic_dev_rdata[20]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[21] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[21]),
        .Q(ic_dev_rdata[21]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[22] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[22]),
        .Q(ic_dev_rdata[22]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[23] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[23]),
        .Q(ic_dev_rdata[23]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[24] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[24]),
        .Q(ic_dev_rdata[24]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[25] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[25]),
        .Q(ic_dev_rdata[25]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[26] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[26]),
        .Q(ic_dev_rdata[26]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[27] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[27]),
        .Q(ic_dev_rdata[27]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[28] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[28]),
        .Q(ic_dev_rdata[28]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[29] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[29]),
        .Q(ic_dev_rdata[29]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[2] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[2]),
        .Q(ic_dev_rdata[2]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[30] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[30]),
        .Q(ic_dev_rdata[30]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[31] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[31]),
        .Q(ic_dev_rdata[31]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[32] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[0]),
        .Q(ic_dev_rdata[32]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[33] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[1]),
        .Q(ic_dev_rdata[33]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[34] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[2]),
        .Q(ic_dev_rdata[34]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[35] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[3]),
        .Q(ic_dev_rdata[35]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[36] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[4]),
        .Q(ic_dev_rdata[36]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[37] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[5]),
        .Q(ic_dev_rdata[37]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[38] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[6]),
        .Q(ic_dev_rdata[38]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[39] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[7]),
        .Q(ic_dev_rdata[39]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[3] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[3]),
        .Q(ic_dev_rdata[3]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[40] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[8]),
        .Q(ic_dev_rdata[40]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[41] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[9]),
        .Q(ic_dev_rdata[41]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[42] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[10]),
        .Q(ic_dev_rdata[42]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[43] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[11]),
        .Q(ic_dev_rdata[43]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[44] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[12]),
        .Q(ic_dev_rdata[44]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[45] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[13]),
        .Q(ic_dev_rdata[45]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[46] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[14]),
        .Q(ic_dev_rdata[46]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[47] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[15]),
        .Q(ic_dev_rdata[47]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[48] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[16]),
        .Q(ic_dev_rdata[48]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[49] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[17]),
        .Q(ic_dev_rdata[49]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[4] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[4]),
        .Q(ic_dev_rdata[4]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[50] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[18]),
        .Q(ic_dev_rdata[50]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[51] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[19]),
        .Q(ic_dev_rdata[51]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[52] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[20]),
        .Q(ic_dev_rdata[52]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[53] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[21]),
        .Q(ic_dev_rdata[53]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[54] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[22]),
        .Q(ic_dev_rdata[54]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[55] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[23]),
        .Q(ic_dev_rdata[55]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[56] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[24]),
        .Q(ic_dev_rdata[56]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[57] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[25]),
        .Q(ic_dev_rdata[57]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[58] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[26]),
        .Q(ic_dev_rdata[58]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[59] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[27]),
        .Q(ic_dev_rdata[59]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[5] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[5]),
        .Q(ic_dev_rdata[5]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[60] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[28]),
        .Q(ic_dev_rdata[60]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[61] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[29]),
        .Q(ic_dev_rdata[61]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[62] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[30]),
        .Q(ic_dev_rdata[62]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[63] 
       (.C(aclk),
        .CE(p_0_in[63]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[31]),
        .Q(ic_dev_rdata[63]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[64] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[0]),
        .Q(ic_dev_rdata[64]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[65] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[1]),
        .Q(ic_dev_rdata[65]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[66] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[2]),
        .Q(ic_dev_rdata[66]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[67] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[3]),
        .Q(ic_dev_rdata[67]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[68] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[4]),
        .Q(ic_dev_rdata[68]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[69] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[5]),
        .Q(ic_dev_rdata[69]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[6] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[6]),
        .Q(ic_dev_rdata[6]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[70] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[6]),
        .Q(ic_dev_rdata[70]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[71] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[7]),
        .Q(ic_dev_rdata[71]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[72] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[8]),
        .Q(ic_dev_rdata[72]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[73] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[9]),
        .Q(ic_dev_rdata[73]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[74] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[10]),
        .Q(ic_dev_rdata[74]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[75] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[11]),
        .Q(ic_dev_rdata[75]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[76] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[12]),
        .Q(ic_dev_rdata[76]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[77] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[13]),
        .Q(ic_dev_rdata[77]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[78] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[14]),
        .Q(ic_dev_rdata[78]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[79] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[15]),
        .Q(ic_dev_rdata[79]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[7] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[7]),
        .Q(ic_dev_rdata[7]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[80] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[16]),
        .Q(ic_dev_rdata[80]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[81] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[17]),
        .Q(ic_dev_rdata[81]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[82] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[18]),
        .Q(ic_dev_rdata[82]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[83] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[19]),
        .Q(ic_dev_rdata[83]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[84] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[20]),
        .Q(ic_dev_rdata[84]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[85] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[21]),
        .Q(ic_dev_rdata[85]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[86] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[22]),
        .Q(ic_dev_rdata[86]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[87] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[23]),
        .Q(ic_dev_rdata[87]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[88] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[24]),
        .Q(ic_dev_rdata[88]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[89] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[25]),
        .Q(ic_dev_rdata[89]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[8] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[8]),
        .Q(ic_dev_rdata[8]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[90] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[26]),
        .Q(ic_dev_rdata[90]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[91] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[27]),
        .Q(ic_dev_rdata[91]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[92] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[28]),
        .Q(ic_dev_rdata[92]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[93] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[29]),
        .Q(ic_dev_rdata[93]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[94] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[30]),
        .Q(ic_dev_rdata[94]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[95] 
       (.C(aclk),
        .CE(p_0_in[95]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[31]),
        .Q(ic_dev_rdata[95]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[96] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[0]),
        .Q(ic_dev_rdata[96]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[97] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[1]),
        .Q(ic_dev_rdata[97]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[98] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[2]),
        .Q(ic_dev_rdata[98]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[99] 
       (.C(aclk),
        .CE(p_0_in[127]),
        .CLR(\ic_dev_rdata[121]_i_1_n_0 ),
        .D(m_axi_rdata[3]),
        .Q(ic_dev_rdata[99]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_dev_rdata_reg[9] 
       (.C(aclk),
        .CE(p_0_in[31]),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(m_axi_rdata[9]),
        .Q(ic_dev_rdata[9]));
  LUT5 #(
    .INIT(32'hFBBBF000)) 
    ic_dev_rrdy_i_1
       (.I0(has_dc_rd_req_r),
        .I1(has_ic_rd_req_r),
        .I2(m_axi_rlast),
        .I3(m_axi_rvalid),
        .I4(ic_dev_rrdy),
        .O(ic_dev_rrdy_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    ic_dev_rrdy_i_2
       (.I0(aresetn),
        .O(ic_dev_rrdy_i_2_n_0));
  FDPE #(
    .INIT(1'b1)) 
    ic_dev_rrdy_reg
       (.C(aclk),
        .CE(1'b1),
        .D(ic_dev_rrdy_i_1_n_0),
        .PRE(ic_dev_rrdy_i_2_n_0),
        .Q(ic_dev_rrdy));
  LUT6 #(
    .INIT(64'hAAAAAAAA00400000)) 
    ic_dev_rvalid_i_1
       (.I0(ic_dev_rvalid),
        .I1(m_axi_rlast),
        .I2(m_axi_rvalid),
        .I3(has_dc_rd_req_r),
        .I4(has_ic_rd_req_r),
        .I5(dc_dev_rvalid),
        .O(ic_dev_rvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    ic_dev_rvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(ic_dev_rvalid_i_1_n_0),
        .Q(ic_dev_rvalid));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hF3FF0400)) 
    \ic_recv_cnt[5]_i_1 
       (.I0(m_axi_rlast),
        .I1(m_axi_rvalid),
        .I2(has_dc_rd_req_r),
        .I3(has_ic_rd_req_r),
        .I4(ic_recv_cnt_reg__0[5]),
        .O(\ic_recv_cnt[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFF1FFFFF00200000)) 
    \ic_recv_cnt[6]_i_1 
       (.I0(ic_recv_cnt_reg__0[5]),
        .I1(m_axi_rlast),
        .I2(m_axi_rvalid),
        .I3(has_dc_rd_req_r),
        .I4(has_ic_rd_req_r),
        .I5(ic_recv_cnt_reg__0[6]),
        .O(\ic_recv_cnt[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h07FF0800)) 
    \ic_recv_cnt[7]_i_1 
       (.I0(ic_recv_cnt_reg__0[6]),
        .I1(ic_recv_cnt_reg__0[5]),
        .I2(m_axi_rlast),
        .I3(ic_recv_cnt),
        .I4(ic_recv_cnt_reg__0[7]),
        .O(\ic_recv_cnt[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \ic_recv_cnt[7]_i_2 
       (.I0(m_axi_rvalid),
        .I1(has_dc_rd_req_r),
        .I2(has_ic_rd_req_r),
        .O(ic_recv_cnt));
  FDCE #(
    .INIT(1'b0)) 
    \ic_recv_cnt_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\ic_recv_cnt[5]_i_1_n_0 ),
        .Q(ic_recv_cnt_reg__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_recv_cnt_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\ic_recv_cnt[6]_i_1_n_0 ),
        .Q(ic_recv_cnt_reg__0[6]));
  FDCE #(
    .INIT(1'b0)) 
    \ic_recv_cnt_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\ic_recv_cnt[7]_i_1_n_0 ),
        .Q(ic_recv_cnt_reg__0[7]));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[0]_i_1 
       (.I0(dc_cpu_raddr[0]),
        .I1(ic_cpu_raddr[0]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[10]_i_1 
       (.I0(dc_cpu_raddr[10]),
        .I1(ic_cpu_raddr[10]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[11]_i_1 
       (.I0(dc_cpu_raddr[11]),
        .I1(ic_cpu_raddr[11]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[11]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[12]_i_1 
       (.I0(dc_cpu_raddr[12]),
        .I1(ic_cpu_raddr[12]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[12]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[13]_i_1 
       (.I0(dc_cpu_raddr[13]),
        .I1(ic_cpu_raddr[13]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[13]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[14]_i_1 
       (.I0(dc_cpu_raddr[14]),
        .I1(ic_cpu_raddr[14]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[15]_i_1 
       (.I0(dc_cpu_raddr[15]),
        .I1(ic_cpu_raddr[15]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[16]_i_1 
       (.I0(dc_cpu_raddr[16]),
        .I1(ic_cpu_raddr[16]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[17]_i_1 
       (.I0(dc_cpu_raddr[17]),
        .I1(ic_cpu_raddr[17]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[17]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[18]_i_1 
       (.I0(dc_cpu_raddr[18]),
        .I1(ic_cpu_raddr[18]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[18]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[19]_i_1 
       (.I0(dc_cpu_raddr[19]),
        .I1(ic_cpu_raddr[19]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[1]_i_1 
       (.I0(dc_cpu_raddr[1]),
        .I1(ic_cpu_raddr[1]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[20]_i_1 
       (.I0(dc_cpu_raddr[20]),
        .I1(ic_cpu_raddr[20]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[20]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[21]_i_1 
       (.I0(dc_cpu_raddr[21]),
        .I1(ic_cpu_raddr[21]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[21]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[22]_i_1 
       (.I0(dc_cpu_raddr[22]),
        .I1(ic_cpu_raddr[22]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[23]_i_1 
       (.I0(dc_cpu_raddr[23]),
        .I1(ic_cpu_raddr[23]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[24]_i_1 
       (.I0(dc_cpu_raddr[24]),
        .I1(ic_cpu_raddr[24]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[24]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[25]_i_1 
       (.I0(dc_cpu_raddr[25]),
        .I1(ic_cpu_raddr[25]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[25]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[26]_i_1 
       (.I0(dc_cpu_raddr[26]),
        .I1(ic_cpu_raddr[26]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[27]_i_1 
       (.I0(dc_cpu_raddr[27]),
        .I1(ic_cpu_raddr[27]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[28]_i_1 
       (.I0(dc_cpu_raddr[28]),
        .I1(ic_cpu_raddr[28]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[28]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[29]_i_1 
       (.I0(dc_cpu_raddr[29]),
        .I1(ic_cpu_raddr[29]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[29]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[2]_i_1 
       (.I0(dc_cpu_raddr[2]),
        .I1(ic_cpu_raddr[2]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[30]_i_1 
       (.I0(dc_cpu_raddr[30]),
        .I1(ic_cpu_raddr[30]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[30]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \m_axi_araddr[31]_i_1 
       (.I0(dc_cpu_ren),
        .I1(dc_dev_rrdy),
        .I2(ic_cpu_ren),
        .I3(ic_dev_rrdy),
        .O(has_rd_req));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[31]_i_2 
       (.I0(dc_cpu_raddr[31]),
        .I1(ic_cpu_raddr[31]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[3]_i_1 
       (.I0(dc_cpu_raddr[3]),
        .I1(ic_cpu_raddr[3]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[4]_i_1 
       (.I0(dc_cpu_raddr[4]),
        .I1(ic_cpu_raddr[4]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[5]_i_1 
       (.I0(dc_cpu_raddr[5]),
        .I1(ic_cpu_raddr[5]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[6]_i_1 
       (.I0(dc_cpu_raddr[6]),
        .I1(ic_cpu_raddr[6]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[7]_i_1 
       (.I0(dc_cpu_raddr[7]),
        .I1(ic_cpu_raddr[7]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[8]_i_1 
       (.I0(dc_cpu_raddr[8]),
        .I1(ic_cpu_raddr[8]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hACCC)) 
    \m_axi_araddr[9]_i_1 
       (.I0(dc_cpu_raddr[9]),
        .I1(ic_cpu_raddr[9]),
        .I2(dc_dev_rrdy),
        .I3(dc_cpu_ren),
        .O(\m_axi_araddr[9]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[0] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(\m_axi_araddr[0]_i_1_n_0 ),
        .Q(m_axi_araddr[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[10] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[10]_i_1_n_0 ),
        .Q(m_axi_araddr[10]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[11] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[11]_i_1_n_0 ),
        .Q(m_axi_araddr[11]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[12] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[12]_i_1_n_0 ),
        .Q(m_axi_araddr[12]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[13] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[13]_i_1_n_0 ),
        .Q(m_axi_araddr[13]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[14] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[14]_i_1_n_0 ),
        .Q(m_axi_araddr[14]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[15] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[15]_i_1_n_0 ),
        .Q(m_axi_araddr[15]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[16] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[16]_i_1_n_0 ),
        .Q(m_axi_araddr[16]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[17] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[17]_i_1_n_0 ),
        .Q(m_axi_araddr[17]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[18] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[18]_i_1_n_0 ),
        .Q(m_axi_araddr[18]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[19] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[19]_i_1_n_0 ),
        .Q(m_axi_araddr[19]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[1] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(\m_axi_araddr[1]_i_1_n_0 ),
        .Q(m_axi_araddr[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[20] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[20]_i_1_n_0 ),
        .Q(m_axi_araddr[20]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[21] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[21]_i_1_n_0 ),
        .Q(m_axi_araddr[21]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[22] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[22]_i_1_n_0 ),
        .Q(m_axi_araddr[22]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[23] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[23]_i_1_n_0 ),
        .Q(m_axi_araddr[23]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[24] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[24]_i_1_n_0 ),
        .Q(m_axi_araddr[24]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[25] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[25]_i_1_n_0 ),
        .Q(m_axi_araddr[25]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[26] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[26]_i_1_n_0 ),
        .Q(m_axi_araddr[26]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[27] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[27]_i_1_n_0 ),
        .Q(m_axi_araddr[27]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[28] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[28]_i_1_n_0 ),
        .Q(m_axi_araddr[28]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[29] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[29]_i_1_n_0 ),
        .Q(m_axi_araddr[29]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[2] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[2]_i_1_n_0 ),
        .Q(m_axi_araddr[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[30] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[30]_i_1_n_0 ),
        .Q(m_axi_araddr[30]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[31] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[31]_i_2_n_0 ),
        .Q(m_axi_araddr[31]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[3] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[3]_i_1_n_0 ),
        .Q(m_axi_araddr[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[4] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[4]_i_1_n_0 ),
        .Q(m_axi_araddr[4]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[5] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[5]_i_1_n_0 ),
        .Q(m_axi_araddr[5]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[6] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[6]_i_1_n_0 ),
        .Q(m_axi_araddr[6]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[7] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[7]_i_1_n_0 ),
        .Q(m_axi_araddr[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[8] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[8]_i_1_n_0 ),
        .Q(m_axi_araddr[8]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_araddr_reg[9] 
       (.C(aclk),
        .CE(has_rd_req),
        .CLR(\ic_dev_rdata[127]_i_2_n_0 ),
        .D(\m_axi_araddr[9]_i_1_n_0 ),
        .Q(m_axi_araddr[9]));
  LUT6 #(
    .INIT(64'hFFFFF777FFFFF000)) 
    \m_axi_arlen[1]_i_1 
       (.I0(m_axi_arready),
        .I1(m_axi_arvalid),
        .I2(ic_dev_rrdy),
        .I3(ic_cpu_ren),
        .I4(has_dc_rd_req),
        .I5(\^m_axi_arlen ),
        .O(\m_axi_arlen[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \m_axi_arlen[1]_i_2 
       (.I0(dc_dev_rrdy),
        .I1(dc_cpu_ren),
        .O(has_dc_rd_req));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_arlen_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(\m_axi_arlen[1]_i_1_n_0 ),
        .Q(\^m_axi_arlen ));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    m_axi_arvalid_i_1
       (.I0(m_axi_arready),
        .I1(m_axi_arvalid),
        .I2(ic_dev_rrdy),
        .I3(ic_cpu_ren),
        .I4(dc_dev_rrdy),
        .I5(dc_cpu_ren),
        .O(m_axi_arvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_arvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(ic_dev_rrdy_i_2_n_0),
        .D(m_axi_arvalid_i_1_n_0),
        .Q(m_axi_arvalid));
  LUT3 #(
    .INIT(8'h2A)) 
    \m_axi_awaddr[31]_i_1 
       (.I0(has_dc_wr_req),
        .I1(m_axi_awready),
        .I2(m_axi_awvalid),
        .O(\m_axi_awaddr[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAAAA8)) 
    \m_axi_awaddr[31]_i_2 
       (.I0(dc_dev_wrdy),
        .I1(dc_cpu_wen[1]),
        .I2(dc_cpu_wen[0]),
        .I3(dc_cpu_wen[2]),
        .I4(dc_cpu_wen[3]),
        .O(has_dc_wr_req));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[0] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[0]),
        .Q(m_axi_awaddr[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[10] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[10]),
        .Q(m_axi_awaddr[10]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[11] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[11]),
        .Q(m_axi_awaddr[11]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[12] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[12]),
        .Q(m_axi_awaddr[12]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[13] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[13]),
        .Q(m_axi_awaddr[13]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[14] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[14]),
        .Q(m_axi_awaddr[14]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[15] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[15]),
        .Q(m_axi_awaddr[15]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[16] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[16]),
        .Q(m_axi_awaddr[16]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[17] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[17]),
        .Q(m_axi_awaddr[17]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[18] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[18]),
        .Q(m_axi_awaddr[18]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[19] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[19]),
        .Q(m_axi_awaddr[19]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[1] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[1]),
        .Q(m_axi_awaddr[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[20] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[20]),
        .Q(m_axi_awaddr[20]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[21] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[21]),
        .Q(m_axi_awaddr[21]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[22] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[22]),
        .Q(m_axi_awaddr[22]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[23] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[23]),
        .Q(m_axi_awaddr[23]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[24] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[24]),
        .Q(m_axi_awaddr[24]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[25] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[25]),
        .Q(m_axi_awaddr[25]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[26] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[26]),
        .Q(m_axi_awaddr[26]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[27] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[27]),
        .Q(m_axi_awaddr[27]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[28] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[28]),
        .Q(m_axi_awaddr[28]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[29] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[29]),
        .Q(m_axi_awaddr[29]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[2] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[2]),
        .Q(m_axi_awaddr[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[30] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[30]),
        .Q(m_axi_awaddr[30]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[31] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[31]),
        .Q(m_axi_awaddr[31]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[3] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[3]),
        .Q(m_axi_awaddr[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[4] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[4]),
        .Q(m_axi_awaddr[4]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[5] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[5]),
        .Q(m_axi_awaddr[5]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[6] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[6]),
        .Q(m_axi_awaddr[6]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[7] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[7]),
        .Q(m_axi_awaddr[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[8] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[8]),
        .Q(m_axi_awaddr[8]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_awaddr_reg[9] 
       (.C(aclk),
        .CE(\m_axi_awaddr[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_waddr[9]),
        .Q(m_axi_awaddr[9]));
  LUT5 #(
    .INIT(32'h7F7F2A00)) 
    \m_axi_awsize[1]_i_1 
       (.I0(aresetn),
        .I1(m_axi_awvalid),
        .I2(m_axi_awready),
        .I3(has_dc_wr_req),
        .I4(\^m_axi_awburst ),
        .O(\m_axi_awsize[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \m_axi_awsize_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(\m_axi_awsize[1]_i_1_n_0 ),
        .Q(\^m_axi_awburst ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h3A)) 
    m_axi_awvalid_i_1
       (.I0(has_dc_wr_req),
        .I1(m_axi_awready),
        .I2(m_axi_awvalid),
        .O(m_axi_awvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_awvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(m_axi_awvalid_i_1_n_0),
        .Q(m_axi_awvalid));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_bready_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(1'b1),
        .Q(m_axi_rready));
  LUT3 #(
    .INIT(8'h2A)) 
    \m_axi_wdata[31]_i_1 
       (.I0(has_dc_wr_req),
        .I1(m_axi_wready),
        .I2(m_axi_wlast),
        .O(\m_axi_wdata[31]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[0] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[0]),
        .Q(m_axi_wdata[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[10] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[10]),
        .Q(m_axi_wdata[10]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[11] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[11]),
        .Q(m_axi_wdata[11]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[12] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[12]),
        .Q(m_axi_wdata[12]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[13] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[13]),
        .Q(m_axi_wdata[13]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[14] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[14]),
        .Q(m_axi_wdata[14]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[15] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[15]),
        .Q(m_axi_wdata[15]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[16] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[16]),
        .Q(m_axi_wdata[16]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[17] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[17]),
        .Q(m_axi_wdata[17]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[18] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[18]),
        .Q(m_axi_wdata[18]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[19] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[19]),
        .Q(m_axi_wdata[19]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[1] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[1]),
        .Q(m_axi_wdata[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[20] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[20]),
        .Q(m_axi_wdata[20]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[21] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[21]),
        .Q(m_axi_wdata[21]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[22] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[22]),
        .Q(m_axi_wdata[22]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[23] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[23]),
        .Q(m_axi_wdata[23]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[24] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[24]),
        .Q(m_axi_wdata[24]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[25] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[25]),
        .Q(m_axi_wdata[25]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[26] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[26]),
        .Q(m_axi_wdata[26]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[27] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[27]),
        .Q(m_axi_wdata[27]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[28] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[28]),
        .Q(m_axi_wdata[28]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[29] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[29]),
        .Q(m_axi_wdata[29]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[2] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[2]),
        .Q(m_axi_wdata[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[30] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[30]),
        .Q(m_axi_wdata[30]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[31] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[31]),
        .Q(m_axi_wdata[31]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[3] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[3]),
        .Q(m_axi_wdata[3]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[4] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[4]),
        .Q(m_axi_wdata[4]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[5] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[5]),
        .Q(m_axi_wdata[5]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[6] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[6]),
        .Q(m_axi_wdata[6]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[7] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[7]),
        .Q(m_axi_wdata[7]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[8] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[8]),
        .Q(m_axi_wdata[8]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wdata_reg[9] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wdata[9]),
        .Q(m_axi_wdata[9]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[0] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wen[0]),
        .Q(m_axi_wstrb[0]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[1] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wen[1]),
        .Q(m_axi_wstrb[1]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[2] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wen[2]),
        .Q(m_axi_wstrb[2]));
  FDCE #(
    .INIT(1'b0)) 
    \m_axi_wstrb_reg[3] 
       (.C(aclk),
        .CE(\m_axi_wdata[31]_i_1_n_0 ),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(dc_cpu_wen[3]),
        .Q(m_axi_wstrb[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h3A)) 
    m_axi_wvalid_i_1
       (.I0(has_dc_wr_req),
        .I1(m_axi_wready),
        .I2(m_axi_wlast),
        .O(m_axi_wvalid_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    m_axi_wvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .CLR(dc_dev_wrdy_i_2_n_0),
        .D(m_axi_wvalid_i_1_n_0),
        .Q(m_axi_wlast));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
