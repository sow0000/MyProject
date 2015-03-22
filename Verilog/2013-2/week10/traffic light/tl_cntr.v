///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Traffic light controller
//FILE : tl_cntr.v
//TESTBENCH : tb_tl_cntr.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Traffic light controller
//LAST UPDATE : Nov. 11, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module tl_cntr(clk,reset_n,Ta,Tb,La,Lb); //Module of Traffic light controller
	input clk,reset_n,Ta,Tb; //clk : clock pulse; //reset_n : reset switch; //Ta,Tb : Traffic
	output [1:0] La; //Light A
	output [1:0] Lb; //Light B
	
	wire [1:0] next_state; //next state
	wire [1:0] state; //current state
		
	_register2_r U0_register2_r(.clk(clk),.reset_n(reset_n),.d(next_state),.q(state)); //store state in register
	ns_logic U1_ns_logic(.Ta(Ta),.Tb(Tb),.state(state),.next_state(next_state)); //operate next state
	os_logic U2_os_logic(.state(state),.La(La),.Lb(Lb)); //output state

endmodule //End of module