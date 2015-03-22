///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-bit 8-to-1 multiplexer
//FILE : mx8_4bits.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-bit 8-to-1 Multiplexer. 
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx8_4bits(a, b, c, d, e, f, g ,h, s2, s1, s0, y); //Module of 4-bit 8-to-1 Multiplexer
	input [3:0] a, b, c, d ,e, f, g, h; //a~b : 4-bit inputs
	input  s2, s1, s0; //s0~2 : input of opcode
	output [3:0] y; //4-bit output
	
	mx8 U0_mx8(.a(a[0]), .b(b[0]), .c(c[0]), .d(d[0]), .e(e[0]), .f(f[0]), .g(g[0]), .h(h[0]), .s0(s0), .s1(s1), .s2(s2), .y(y[0])); //Select first bit output
	mx8 U1_mx8(.a(a[1]), .b(b[1]), .c(c[1]), .d(d[1]), .e(e[1]), .f(f[1]), .g(g[1]), .h(h[1]), .s0(s0), .s1(s1), .s2(s2), .y(y[1])); //Select second bit output
	mx8 U2_mx8(.a(a[2]), .b(b[2]), .c(c[2]), .d(d[2]), .e(e[2]), .f(f[2]), .g(g[2]), .h(h[2]), .s0(s0), .s1(s1), .s2(s2), .y(y[2])); //Select third bit output
	mx8 U3_mx8(.a(a[3]), .b(b[3]), .c(c[3]), .d(d[3]), .e(e[3]), .f(f[3]), .g(g[3]), .h(h[3]), .s0(s0), .s1(s1), .s2(s2), .y(y[3])); //Select fourth bit output
endmodule //End of module