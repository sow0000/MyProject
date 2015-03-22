///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-bit Carry Look-ahead Adder Overflow
//FILE : cla4_ov.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-bit Carry Look-ahead Adder to search overflow
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cla4_ov(a, b, ci, s, c3, co); //Module of 4-bit Carry Look-ahead Adder to search overflow
	input [3:0] a, b; //4-bit input
	input ci; //carry in
	output [3:0] s; //4-bit sum
	output c3, co; //c3 : third bit carry //co : carry out
 
	wire c1, c2; //wire of internal carry
	wire w0_c3; //wire of third bit carry
 
	fa_v2 U0_fa_v2 (.a(a[0]),.b(b[0]),.ci(ci), .s(s[0])); //Add b to a
	fa_v2 U1_fa_v2 (.a(a[1]),.b(b[1]),.ci(c1), .s(s[1]));
	fa_v2 U2_fa_v2 (.a(a[2]),.b(b[2]),.ci(c2), .s(s[2]));
	fa_v2 U3_fa_v2 (.a(a[3]),.b(b[3]),.ci(w0_c3), .s(s[3]));
 
	clb4 U4_clb4 (.a(a),.b(b),.ci(ci),.c1(c1),.c2(c2),.c3(w0_c3),.co(co)); //calculate carry
 
	assign c3=w0_c3; //input w0_c3 into c3 for output value
endmodule //End of module