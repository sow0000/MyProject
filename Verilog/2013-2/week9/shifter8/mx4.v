///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-to-1 multiplexer
//FILE : mx4.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-to-1 Multiplexer.
//LAST UPDATE : Nov. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx4(y,d0,d1,d2,d3,s); //Module of 4-to-1 Multiplexer.
	input d0, d1, d2, d3; //d0~3 : input data.
	input [1:0] s; //s : seletion input data
	output y; //Output value
	
	mx2 U0_mx2(.y(w0),.d0(d0),.d1(d1),.s(s[0])); //select d0 or d1
	mx2 U1_mx2(.y(w1),.d0(d2),.d1(d3),.s(s[0])); //select d2 or d3
	mx2 U2_mx2(.y(y),.d0(w0),.d1(w1),.s(s[1])); //select {d0,d1} or {d2,d3}
	
endmodule //End of module