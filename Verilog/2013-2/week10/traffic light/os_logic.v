///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Output State Logic
//FILE : os_logic.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Output State Logic
//LAST UPDATE : Nov. 08, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module os_logic(state,La,Lb); //Module of Output State Logic
	input [1:0] state; //current state
	output [1:0] La; //output value
	output [1:0] Lb; //output value

	assign La[1]=state[1]; //Light A
	assign La[0]=~state[1]&state[0];
	assign Lb[1]=~state[1]; //Light B
	assign Lb[0]=state[1]&state[0];
	
endmodule //End of module