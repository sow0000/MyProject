///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Half Adder
//FILE : HalfAdder.v
//TESTBENCH : tb_HalfAdder.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Half Adder. 
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module HalfAdder(a, b, co, s); //Module of Half Adder
	input a, b; //a,b : Variable for input binary signals
	output co, s; //co : Output port for carry of result //s : Output port for result
	
	assign s=a^b; //s = a ^ b
	assign co=a&b; //co = a x b
	
endmodule //End of module