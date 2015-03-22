///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-bit Carry Look Ahead Block
//FILE : CarryLookAheadBlock4.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-bit Carry Look Ahead Block.
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module CarryLookAheadBlock4(a,b,ci,c1,c2,c3,co); //Module of Carry Ahead Block
	input [3:0] a, b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output c1,c2,c3,co; //c1~3, co : Output port for carry of result
	
	wire [3:0] g,p; //g : Wire for generate //p : Wire for propagate
	
	wire w0_c1; //Wire for intenal carry
	wire w0_c2, w1_c2; //Wire for intenal carry
	wire w0_c3, w1_c3, w2_c3; //Wire for intenal carry
	wire w0_co, w1_co, w2_co, w3_co; //Wire for intenal carry
	
	_and2 U0_and2 (.a(a[0]),.b(b[0]),.y(g[0])); //Calculate generate
	_and2 U1_and2 (.a(a[1]),.b(b[1]),.y(g[1]));
	_and2 U2_and2 (.a(a[2]),.b(b[2]),.y(g[2]));
	_and2 U3_and2 (.a(a[3]),.b(b[3]),.y(g[3]));
	

	_or2 U4_or2 (.a(a[0]),.b(b[0]),.y(p[0])); //Calculate propagate
	_or2 U5_or2 (.a(a[1]),.b(b[1]),.y(p[1]));
	_or2 U6_or2 (.a(a[2]),.b(b[2]),.y(p[2]));
	_or2 U7_or2 (.a(a[3]),.b(b[3]),.y(p[3]));
	
	_and2 U8_and2 (.a(p[0]),.b(ci),.y(w0_c1)); //Calculate c1
	_or2 U9_or2 (.a(g[0]),.b(w0_c1),.y(c1));
	
	_and2 U10_and2 (.a(p[1]),.b(g[0]),.y(w0_c2)); //Calculate c2
	_and3 U11_and3 (.a(p[1]),.b(p[0]),.c(ci),.y(w1_c2));
	_or3 U12_or3 (.a(g[1]),.b(w0_c2),.c(w1_c2),.y(c2));
	
	_and2 U13_and2 (.a(p[2]),.b(g[1]),.y(w0_c3)); //Calculate c3
	_and3 U14_and3 (.a(p[2]),.b(p[1]),.c(g[0]),.y(w1_c3));
	_and4 U15_and4 (.a(p[2]),.b(p[1]),.c(p[0]),.d(ci),.y(w2_c3));
	_or4 U16_or4 (.a(g[2]),.b(w0_c3),.c(w1_c3),.d(w2_c3),.y(c3));
	
	_and2 U17_and2 (.a(p[3]),.b(g[2]),.y(w0_co)); //Calculate co
	_and3 U18_and3 (.a(p[3]),.b(p[2]),.c(g[1]),.y(w1_co));
	_and4 U19_and4 (.a(p[3]),.b(p[2]),.c(p[1]),.d(g[0]),.y(w2_co));
	_and5 U20_and5 (.a(p[3]),.b(p[2]),.c(p[1]),.d(p[0]),.e(ci),.y(w3_co));
	_or5 U21_or5 (.a(g[3]),.b(w0_co),.c(w1_co),.d(w2_co),.e(w3_co),.y(co));
	
endmodule //End of module