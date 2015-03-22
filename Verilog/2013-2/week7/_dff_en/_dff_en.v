///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Enabled D flip-flop
//FILE : _dff_en.v
//TESTBENCH : tb_dff_en.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Enabled D flip-flop
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _dff_en(clk,en,d,q); //Module of Enabled D flip-flop
	input clk,en,d; //clk,d=input; //en=switch
	output q; //output
	
	wire w_d; //wire of D flip-flop
	
	mx2 U0_mx2(.d0(q),.d1(d),.s(en),.y(w_d)); //select q or d
	_dff U1_dff(.clk(clk),.d(w_d),.q(q)); //change q
	
endmodule //End of module