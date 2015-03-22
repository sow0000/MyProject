///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit Carry Look-ahead Adder Overflow
//FILE : cla32_ov.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32-bit Carry Look-ahead Adder to search overflow
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cla32_ov(a, b, ci ,s, co, c31); //Module of 4-bit Carry Look-ahead Adder to search overflow
	input [31:0] a, b; //4-bit input
	input ci; //carry in
	output [31:0] s; //4-bit sum
	output c31, co; //c31 : 31rd bit carry //co : carry out
	wire c1,c2,c3,c4,c5,c6,c7; //wire of internal carry
	
	cla4 U0_cla4(.a(a[3:0]), .b(b[3:0]), .ci(ci), .s(s[3:0]), .co(c1)); //Add b to a
	cla4 U1_cla4(.a(a[7:4]), .b(b[7:4]), .ci(c1), .s(s[7:4]), .co(c2));
	cla4 U2_cla4(.a(a[11:8]), .b(b[11:8]), .ci(c2), .s(s[11:8]), .co(c3));
	cla4 U3_cla4(.a(a[15:12]), .b(b[15:12]), .ci(c3), .s(s[15:12]), .co(c4));
	cla4 U4_cla4(.a(a[19:16]), .b(b[19:16]), .ci(c4), .s(s[19:16]), .co(c5));
	cla4 U5_cla4(.a(a[23:20]), .b(b[23:20]), .ci(c5), .s(s[23:20]), .co(c6));
	cla4 U6_cla4(.a(a[27:24]), .b(b[27:24]), .ci(c6), .s(s[27:24]), .co(c7));
	cla4_ov U7_cla4_ov(.a(a[31:28]), .b(b[31:28]), .ci(c7) ,.s(s[31:28]), .c3(c31), .co(co)); //pick up carry
	
endmodule  //End of module