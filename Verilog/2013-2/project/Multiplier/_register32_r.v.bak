///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 3-bit Register
//FILE : _register3_r.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 3-bit Register
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _register3_r(clk,reset_n,d,q); //Module of 3-bit Register
	input clk,reset_n; //clock pulse
	input [2:0] d; //3-bit input
	output [2:0] q; //3-bit output
	
	_dff_r U0_dff_r(.clk(clk),.reset_n(reset_n),.d(d[0]),.q(q[0])); //save first 1bit of input
	_dff_r U1_dff_r(.clk(clk),.reset_n(reset_n),.d(d[1]),.q(q[1])); //save second 1bit of input
	_dff_r U2_dff_r(.clk(clk),.reset_n(reset_n),.d(d[2]),.q(q[2])); //save third 1bit of input

endmodule //End of module