///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-bit Carry Look Ahead
//FILE : CarryLookAhead4.v
//TESTBENCH : tb_CarryLookAhead4.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-bit Carry Look Ahead Adder.
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module CarryLookAhead4(a,b,ci,s,co); //Module of 4-bit Carry Look Ahead
	input [3:0] a, b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [3:0] s; //s : Output port for result
	output co; //co : Output port for carry of result
	
	wire c1, c2, c3; //Wire for intenal carry

	
	FullAdder_v2 U0_FullAdder (.a(a[0]),.b(b[0]),.ci(ci), .s(s[0])); //Calculate first bit use full adder
	FullAdder_v2 U1_FullAdder (.a(a[1]),.b(b[1]),.ci(c1), .s(s[1])); //Calculate second bit use full adder
	FullAdder_v2 U2_FullAdder (.a(a[2]),.b(b[2]),.ci(c2), .s(s[2])); //Calculate third bit use full adder
	FullAdder_v2 U3_FullAdder (.a(a[3]),.b(b[3]),.ci(c3), .s(s[3])); //Calculate forth bit use full adder
	
	CarryLookAheadBlock4 U4_CarryLookAheadBlock4 (.a(a),.b(b),.ci(ci),.c1(c1),.c2(c2),.c3(c3),.co(co)); //Calculate value of carry out
	
endmodule //End of module