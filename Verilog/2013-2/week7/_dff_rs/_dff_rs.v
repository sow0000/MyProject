///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Synchronous Set/Resettable D-flip flop
//FILE : _dff_rs.v
//TESTBENCH : tb_dff_rs.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Synchronous Set/Resettable D-flip flop
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _dff_rs(clk,set_n,reset_n,d,q); //Module of Synchronous Set/Resettable D-flip flop
	input clk,set_n,reset_n,d; //clk=clock pulse; //set_n=set switch; //reset_n=reset switch; //d=input
	output q; //output
	
	wire set,w0_d, w1_d; //set=wire of inverted set_n; //w0_d,w1_d=wire of D-flip flop
	
	_inv U0_inv(.a(set_n),.y(set)); //invert set_n
	_or2 U1_or2(.a(d),.b(set),.y(w0_d)); //select set or d
	_and2 U2_and2(.a(w0_d),.b(reset_n),.y(w1_d)); //select reset
	_dff U3_dff(.clk(clk),.d(w1_d),.q(q)); //change q
	
endmodule //End of module