///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-bit Register
//FILE : _register8.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-bit Register
//LAST UPDATE : Nov. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _register8_r(clk,reset_n,d,q); //Module of 8-bit Register
	input clk,reset_n; //clock pulse
	input [7:0] d; //8-bit input
	output [7:0] q; //8-bit output
	
	_dff_r U0_dff_r(.clk(clk),.reset_n(reset_n),.d(d[0]),.q(q[0])); //save first 1bit of input
	_dff_r U1_dff_r(.clk(clk),.reset_n(reset_n),.d(d[1]),.q(q[1])); //save second 1bit of input
	_dff_r U2_dff_r(.clk(clk),.reset_n(reset_n),.d(d[2]),.q(q[2])); //save third 1bit of input
	_dff_r U3_dff_r(.clk(clk),.reset_n(reset_n),.d(d[3]),.q(q[3])); //save fourth 1bit of input
	_dff_r U4_dff_r(.clk(clk),.reset_n(reset_n),.d(d[4]),.q(q[4])); //save fifth 1bit of input
	_dff_r U5_dff_r(.clk(clk),.reset_n(reset_n),.d(d[5]),.q(q[5])); //save sixth 1bit of input
	_dff_r U6_dff_r(.clk(clk),.reset_n(reset_n),.d(d[6]),.q(q[6])); //save seventh 1bit of input
	_dff_r U7_dff_r(.clk(clk),.reset_n(reset_n),.d(d[7]),.q(q[7])); //save eighth 1bit of input
	
endmodule //End of module