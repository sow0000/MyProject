///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-to-1 multiplexer
//FILE : mx8.v
//TESTBENCH : tb_mx8.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-to-1 Multiplexer. 
//LAST UPDATE : Sep. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx8(y,a,b,c,d,e,f,g,h,s0,s1,s2); //Module of 8-to-1 Multiplexer
	input a,b,c,d,e,f,g,h,s0,s1,s2;      //a~h : Variable of input data //s0~2 : Varible of selection input data.
	output y;                            //Output data of mx8.
	wire w0,w1,w00,w01,w10,w11;          //w0~1 : Wire for output data of mx24~5. Also wire for input data of final mx2(mx26) 
													 //w00~11 : Wire for output data of mx20~3. Also wire for input data of mx24~5.
	mx2 mx20(.y(w00),.d0(a),.d1(b),.s(s0)); //Select output data between a and b according to s0
	mx2 mx21(.y(w01),.d0(c),.d1(d),.s(s0)); //Select output data between c and d according to s0
	mx2 mx22(.y(w10),.d0(e),.d1(f),.s(s0)); //Select output data between e and f according to s0
	mx2 mx23(.y(w11),.d0(g),.d1(h),.s(s0)); //Select output data between g and h according to s0
	mx2 mx24(.y(w0),.d0(w00),.d1(w01),.s(s1)); //Select output data between w00 and w01 according to s1
	mx2 mx25(.y(w1),.d0(w10),.d1(w11),.s(s1)); //Select output data between w10 and w11 according to s1
	mx2 mx26(.y(y),.d0(w0),.d1(w1),.s(s2)); //Select output data between w0 and w1 according to s2
	
endmodule //End of module

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