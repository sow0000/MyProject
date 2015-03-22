///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Multiplier Next state logic
//FILE : mul_ns_logic.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Multiplier Next state logic
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module mul_ns_logic(op_start,op_clear,op_done,state,next_state); //module of Multiplier Next state logic
	input op_start,op_clear,op_done; //input switch
	input [1:0] state; //current state
	output [1:0] next_state; //next state
	
	wire w0_state,w1_state; //wire of state
	
	assign w0_state=(~state[1])&(~state[0])&(op_start)&(~op_clear);
	assign w1_state=(state[1])&(~op_clear)&(~op_done);
	
	assign next_state[1]=(w0_state)|(w1_state);
	assign next_state[0]=((state[1])|(state[0]))&(~op_clear);
endmodule //End of module
		