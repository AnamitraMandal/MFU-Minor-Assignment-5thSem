////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: P.20131013
//  \   \         Application: netgen
//  /   /         Filename: test_synthesis.v
// /___/   /\     Timestamp: Sat Nov 09 19:54:16 2019
// \   \  /  \ 
//  \___\/\___\
//             
// Command	: -intstyle ise -insert_glbl true -w -dir netgen/synthesis -ofmt verilog -sim test.ngc test_synthesis.v 
// Device	: xc6slx45-3-csg324
// Input file	: test.ngc
// Output file	: E:\test\netgen\synthesis\test_synthesis.v
// # of Modules	: 1
// Design Name	: test
// Xilinx        : E:\NewFolder\14.7\ISE_DS\ISE\
//             
// Purpose:    
//     This verilog netlist is a verification model and uses simulation 
//     primitives which may not represent the true implementation of the 
//     device, however the netlist is functionally correct and should not 
//     be modified. This file cannot be synthesized and should only be used 
//     with supported simulation tools.
//             
// Reference:  
//     Command Line Tools User Guide, Chapter 23 and Synthesis and Simulation Design Guide, Chapter 6
//             
////////////////////////////////////////////////////////////////////////////////

`timescale 1 ns/1 ps

module test (
  a, b, btn, clk, c
);
  input a;
  input b;
  input btn;
  input clk;
  output c;
  wire a_IBUF_0;
  wire b_IBUF_1;
  wire btn_IBUF_2;
  wire clk_BUFGP_3;
  wire d_4;
  wire \Madd_a_b_add_2_OUT<0>_lut<0> ;
  FDE   d (
    .C(clk_BUFGP_3),
    .CE(btn_IBUF_2),
    .D(\Madd_a_b_add_2_OUT<0>_lut<0> ),
    .Q(d_4)
  );
  LUT2 #(
    .INIT ( 4'h6 ))
  \Madd_a_b_add_2_OUT<0>_lut<0>1  (
    .I0(a_IBUF_0),
    .I1(b_IBUF_1),
    .O(\Madd_a_b_add_2_OUT<0>_lut<0> )
  );
  IBUF   a_IBUF (
    .I(a),
    .O(a_IBUF_0)
  );
  IBUF   b_IBUF (
    .I(b),
    .O(b_IBUF_1)
  );
  IBUF   btn_IBUF (
    .I(btn),
    .O(btn_IBUF_2)
  );
  OBUF   c_OBUF (
    .I(d_4),
    .O(c)
  );
  BUFGP   clk_BUFGP (
    .I(clk),
    .O(clk_BUFGP_3)
  );
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

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
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

