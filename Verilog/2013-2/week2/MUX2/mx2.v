///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 2-to-1 multiplexer
//FILE : mx2.v
//TESTBENCH : tb_mx2.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 2-to-1 Multiplexer.
//LAST UPDATE : Sep. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx2(y,d0,d1,s); //Module of 2-to-1 Multiplexer.
	input d0,d1,s; //d0~1 : Variables for input data. //s : Variable for seletion input data
	output y; //Output data of mx2.
	wire sb,w0,w1; //sb : Inverted value of s. Make different values between nd20 and nd21.
						//w0~1 : Wires for output data of nd20~1. Also wire for input data of mn22.
	iv iv0(.a(s),.y(sb)); //Invert value of s
	nd2 nd20(.a(d0),.b(sb),.y(w0)); //If values of d0 and sb are 1, w0 has 0 but if not, it has 1.
	nd2 nd21(.a(d1),.b(s),.y(w1)); //If values of d1 and s are 1, w1 has 0 but if not, it has 1.
	nd2 nd22(.a(w0),.b(w1),.y(y)); //If there is match signal, nd22 print out 1 and y will have 1.
	
endmodule //End of module

module iv(a,y); //Module of inverter.
	input a; //Variable for input data.
	output y; //Output data of iv.
	assign y=~a; //Input inverted valude of a into y.
endmodule //End of module

module nd2(a,b,y); //Module of 2-input NAND.
	input a,b; //a, b : Variables for input data.
	output y; //Output data of nd2
	assign y=~(a&b); //Input inverted value of result "a AND b" into y.
endmodule //End of module