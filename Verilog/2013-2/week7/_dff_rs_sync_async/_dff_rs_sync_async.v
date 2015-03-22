///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Compare Synchronous & Asynchronous D-flip flop
//FILE : _dff_rs_sync_async.v
//TESTBENCH : tb_dff_rs_sync_async.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Compare Synchronous & Asynchronous D-flip flop
//LAST UPDATE : Oct. 18, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module _dff_rs_sync_async(clk,set_n,reset_n,d,q_sync,q_async); //Module of Compare Synchronous & Asynchronous D-flip flop
	input clk,set_n,reset_n,d; //clk=clock pulse; //set_n=set switch; //reset_n=reset switch; //d=input
	output q_sync,q_async; //output
	
	_dff_rs_sync U0_dff_rs_sync(.clk(clk),.set_n(set_n),.reset_n(reset_n),.d(d),.q(q_sync)); //Synchronous D-flip flop
	_dff_rs_async U1_dff_rs_async(.clk(clk),.set_n(set_n),.reset_n(reset_n),.d(d),.q(q_async)); //Asynchronous D-flip flop
	
endmodule //End of module