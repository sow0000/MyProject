///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Resettable D flip-flop
//FILE : _dff_r.v
//TESTBENCH : tb_dff_r.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Resettable D flip-flop
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _dff_r(clk,reset_n,d,q); //Module of Resettable D flip-flop
	input clk,reset_n,d; //clk=clock pulse; //d=input; //reset_n=reset switch
	output q; //output
	
	wire w_d; //wire of D flip-flop
	
	_and2 U0_and2(.a(d),.b(reset_n),.y(w_d)); //select set or reset
	_dff U1_dff(.clk(clk),.d(w_d),.q(q)); //change q
	
endmodule //End of module