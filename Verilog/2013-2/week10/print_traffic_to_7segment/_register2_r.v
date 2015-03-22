///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 2-bit Register
//FILE : _register2_r.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 2-bit Register
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _register2_r(clk,reset_n,d,q); //Module of 2-bit Register
	input clk,reset_n; //clock pulse
	input [1:0] d; //2-bit input
	output [1:0] q; //2-bit output
	
	_dff_r U0_dff_r(.clk(clk),.reset_n(reset_n),.d(d[0]),.q(q[0])); //save first 1bit of input
	_dff_r U1_dff_r(.clk(clk),.reset_n(reset_n),.d(d[1]),.q(q[1])); //save second 1bit of input

endmodule //End of module