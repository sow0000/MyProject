///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Gates
//FILE : gates.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines logic gates. 
//LAST UPDATE : Sep. 29, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _inv(a,y);
	input a;
	output y;
	
	assign y=~a;
endmodule

module _nand2(a,b,y);
	input a,b;
	output y;
	
	assign y=~(a&b);
endmodule

module _and2(a,b,y);
	input a,b;
	output y;
	
	assign y=a&b;
endmodule

module _or2(a,b,y);
	input a,b;
	output y;
	
	assign y=a|b;
endmodule

module _xor2(a,b,y);
	input a, b;
	output y;
	
	wire inv_a, inv_b;
	wire w0, w1;
	
	_inv U0_inv(.a(a), .y(inv_a));
	_inv U1_inv(.a(b), .y(inv_b));
	_and2 U2_and2(.a(inv_a), .b(b), .y(w0));
	_and2 U3_and2(.a(a),.b(inv_b), .y(w1));
	_or2 U4_or2(.a(w0), .b(w1),.y(y));
endmodule