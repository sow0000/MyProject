///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Full Adder
//FILE : FullAdder.v
//TESTBENCH : tb_FullAdder.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Full Adder. 
//LAST UPDATE : Sep. 29, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module FullAdder(a, b, ci, co, s); //Module of Full Adder
	input a, b, ci; //a,b : Variable for input binary signals //ci : Variable of input carry value for full adder
	output co, s; //co : Output port for carry of result //s : Output port for result
	
	wire sm, c1, c2; //sm : Wire for internal result //c1,c2 : Wire for internal carry
	
	HalfAdder U0_HalfAdder(.a(b),.b(ci),.co(c1),.s(sm)); //Add b and input carry use half adder
	HalfAdder U1_HalfAdder(.a(a),.b(sm),.co(c2),.s(s)); //Add a and result of first half adder use half adder
	_or2 U2_or2(.a(c2),.b(c1),.y(co)); //co = c1 + c2
endmodule //End of module