///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Ripple Carry Adder
//FILE : RippleCarryAdder.v
//TESTBENCH : tb_RippleCarryAdder.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Ripple Carry Adder.
//LAST UPDATE : Sep. 29, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module RippleCarryAdder(a, b, ci, s, co); //Module of Ripple Carry Adder
	input [3:0] a,b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value for full adder
	output [3:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire [2:0] c; //c : Wire for connect carry. We need not c[3] because we already have output port "co" for carry out
	wire ci; //ci : Wire for carry to input first half adder
	
	FullAdder U0_FullAdder(.a(a[0]),.b(b[0]),.ci(ci),.co(c[0]),.s(s[0])); //Calculate first bit use full adder
	FullAdder U1_FullAdder(.a(a[1]),.b(b[1]),.ci(c[0]),.co(c[1]),.s(s[1])); //Calculate second bit with first carry use full adder
	FullAdder U2_FullAdder(.a(a[2]),.b(b[2]),.ci(c[1]),.co(c[2]),.s(s[2])); //Calculate first bit with second carry use full adder	
	FullAdder U3_FullAdder(.a(a[3]),.b(b[3]),.ci(c[2]),.co(co),.s(s[3])); //Calculate first bit with third carry use full adder
endmodule //End of module