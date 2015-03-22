///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-bit Carry Look Ahead
//FILE : cla8.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-bit Carry Look Ahead Adder
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cla8(a,b,ci,s,co); //Module of 8-bit Carry Look Ahead Adder
	input [7:0] a,b; //infput
	input ci; //carry in
	output [7:0] s; //output
	output co; //carry out
	
	wire c1; //internal carry
	
	cla4 U0_cla4(.a(a[3:0]),.b(b[3:0]),.ci(ci),.s(s[3:0]),.co(c1)); //calculate first 4-bit
	cla4 U1_cla4(.a(a[7:4]),.b(b[7:4]),.ci(c1),.s(s[7:4]),.co(co)); //calculate the others
	
endmodule //End of module