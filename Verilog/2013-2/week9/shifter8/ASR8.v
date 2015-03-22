///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-bit Arithmetic Shift Right
//FILE : ASR8.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-bit Arithmetic Shift Right
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module ASR8(d_in,shamt, d_out); //Module of 8-bit Arithmetic Shift Right
	input [7:0] d_in; //input value
	input [1:0] shamt; //shift amount
	output [7:0] d_out; //output value

	mx4 U0_mx4(.y(d_out[7]),.d0(d_in[7]),.d1(d_in[7]),.d2(d_in[7]),.d3(d_in[7]),.s(shamt)); //shift right with MSB
	mx4 U1_mx4(.y(d_out[6]),.d0(d_in[6]),.d1(d_in[7]),.d2(d_in[7]),.d3(d_in[7]),.s(shamt));
	mx4 U2_mx4(.y(d_out[5]),.d0(d_in[5]),.d1(d_in[6]),.d2(d_in[7]),.d3(d_in[7]),.s(shamt));
	mx4 U3_mx4(.y(d_out[4]),.d0(d_in[4]),.d1(d_in[5]),.d2(d_in[6]),.d3(d_in[7]),.s(shamt));
	mx4 U4_mx4(.y(d_out[3]),.d0(d_in[3]),.d1(d_in[4]),.d2(d_in[5]),.d3(d_in[6]),.s(shamt));
	mx4 U5_mx4(.y(d_out[2]),.d0(d_in[2]),.d1(d_in[3]),.d2(d_in[4]),.d3(d_in[5]),.s(shamt));
	mx4 U6_mx4(.y(d_out[1]),.d0(d_in[1]),.d1(d_in[2]),.d2(d_in[3]),.d3(d_in[4]),.s(shamt));
	mx4 U7_mx4(.y(d_out[0]),.d0(d_in[0]),.d1(d_in[1]),.d2(d_in[2]),.d3(d_in[3]),.s(shamt));

endmodule //End of module