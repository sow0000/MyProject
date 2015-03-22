///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-to-1 multiplexer
//FILE : mx8.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-to-1 Multiplexer. 
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mx8(y,a,b,c,d,e,f,g,h,s0,s1,s2); //Module of 8-to-1 Multiplexer
	input a,b,c,d,e,f,g,h,s0,s1,s2;      //a~h : Variable of input data //s0~2 : Varible of selection input data.
	output y;                            //Output data of mx8.
	wire w0,w1,w00,w01,w10,w11;          //w0~1 : Wire for output data of mx24~5. Also wire for input data of final mx2(mx26) 
													 //w00~11 : Wire for output data of mx20~3. Also wire for input data of mx24~5.
	mx2 U0_mx2(.y(w00),.d0(a),.d1(b),.s(s0)); //Select output data between a and b according to s0
	mx2 U1_mx2(.y(w01),.d0(c),.d1(d),.s(s0)); //Select output data between c and d according to s0
	mx2 U2_mx2(.y(w10),.d0(e),.d1(f),.s(s0)); //Select output data between e and f according to s0
	mx2 U3_mx2(.y(w11),.d0(g),.d1(h),.s(s0)); //Select output data between g and h according to s0
	mx2 U4_mx2(.y(w0),.d0(w00),.d1(w01),.s(s1)); //Select output data between w00 and w01 according to s1
	mx2 U5_mx2(.y(w1),.d0(w10),.d1(w11),.s(s1)); //Select output data between w10 and w11 according to s1
	mx2 U6_mx2(.y(y),.d0(w0),.d1(w1),.s(s2)); //Select output data between w0 and w1 according to s2
	
endmodule //End of module