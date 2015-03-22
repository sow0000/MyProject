///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Next State Logic
//FILE : ns_logic.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Next State Logic
//LAST UPDATE : Nov. 11, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module ns_logic(Ta,Tb,state,next_state); //Module of Next State Logic
	input Ta,Tb; //input values
	input [1:0] state; //current state
	output [1:0] next_state; //next state

	assign next_state[1]=state[1]^state[0];
	assign next_state[0]=((~state[1])&(~state[0])&(~Ta))|(state[1]&(~state[0])&(~Tb));

endmodule //End of module