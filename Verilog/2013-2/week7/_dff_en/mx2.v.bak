///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 2-to-1 multiplexer
//FILE : mx2.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 2-to-1 Multiplexer.
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx2(y,d0,d1,s); //Module of 2-to-1 Multiplexer.
	input d0,d1,s; //d0~1 : Variables for input data. //s : Variable for seletion input data
	output y; //Output data of mx2.
	wire sb,w0,w1; //sb : Inverted value of s. Make different values between nd20 and nd21.
						//w0~1 : Wires for output data of nd20~1. Also wire for input data of mn22.
	_inv U0_inv0(.a(s),.y(sb)); //Invert value of s
	_nand2 U1_nand2(.a(d0),.b(sb),.y(w0)); //If values of d0 and sb are 1, w0 has 0 but if not, it has 1.
	_nand2 U2_nand2(.a(d1),.b(s),.y(w1)); //If values of d1 and s are 1, w1 has 0 but if not, it has 1.
	_nand2 U3_nand2(.a(w0),.b(w1),.y(y)); //If there is match signal, nd22 print out 1 and y will have 1.
	
endmodule //End of module