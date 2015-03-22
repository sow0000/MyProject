///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-bit Loadable Up/Down Counter
//FILE : cntr8.v
//TESTBENCH : tb_cntr8.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-bit Loadable Up/Down Counter
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cntr8(clk,reset_n,inc,load,d_in,d_out,o_state); //Module of 8-bit Loadable Up/Down Counter
	input clk,reset_n,inc,load; //clk : clock pulse; //reset_n : reset switch; //inc : increase switch; //load : load switch
	input [7:0] d_in; //input value
	output [7:0] d_out; //output value
	output [2:0] o_state; //current state
	
	wire [2:0] next_state; //next state
	wire [2:0] state; //current state
	
	assign o_state=state; //output current state
	
	_register3_r U0_register3_r(.clk(clk),.reset_n(reset_n),.d(next_state),.q(state)); //store state in register
	ns_logic U1_ns_logic(.load(load),.inc(inc),.state(state),.next_state(next_state)); //operate next state
	os_logic U2_os_logic(.state(state),.d_in(d_in),.d_out(d_out)); //output state
	
endmodule //End of module