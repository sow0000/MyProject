///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit Register
//FILE : _register32.v
//TESTBENCH : tb_register32.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32-bit Register
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _register32(clk,d,q); //Module of 32-bit Register
	input clk; //clock pulse
	input [31:0] d; //32-bit input
	output [31:0] q; //32-bit output
	
	_register8 U0_register8(.clk(clk),.d(d[7:0]),.q(q[7:0])); //save first 8bits of input
	_register8 U1_register8(.clk(clk),.d(d[15:8]),.q(q[15:8])); //save second 8bits of input
	_register8 U2_register8(.clk(clk),.d(d[23:16]),.q(q[23:16])); //save third 8bits of input
	_register8 U3_register8(.clk(clk),.d(d[31:24]),.q(q[31:24])); //save fourth 8bits of input
	
endmodule //End of module