///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : D flip-flop
//FILE : _dff.v
//TESTBENCH : tb_dff.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines D flip-flop
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _dff(clk,d,q,q_bar); //Module of D flip-flop
	input clk,d; //clk=clock pulse; //input
	output q,q_bar; //output
	
	wire clk_bar,w_q; //clk_bar=wire of inverted clk; //w_q=wire of master D-latch and slave D-latch
	
	_inv U0_inv(.a(clk),.y(clk_bar)); //invert clk
	_dlatch U1_dlatch(.clk(clk_bar),.d(d),.q(w_q)); //master D-latch
	_dlatch U2_dlatch(.clk(clk),.d(w_q),.q(q),.q_bar(q_bar)); //slave D-latch
	
endmodule //End of module