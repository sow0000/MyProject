///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Multiplier
//FILE : multiplier.v
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

module multiplier(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,m_interrupt); //module of multiplier
	input clk,reset_n,S_sel,S_wr; //clock pulse, reset, slave selction, slave wirte/read
	input [7:0] S_address; //slave address
	input [31:0] S_din; //slave input
	output [31:0] S_dout; //slave output
	output m_interrupt; //multiplier interrupt
	
	wire op_start,op_clear; //wire of operation
	wire [1:0] state; //state
	wire [63:0] multiplicand; //multiplicand
	wire [63:0] multipier; //multiplier
	wire [127:0] result; //wire of result
	
	//in/output data
	multiplier_slave U0_mul_slave(.clk(clk),.reset_n(reset_n),.S_sel(S_sel),.S_wr(S_wr),.S_address(S_address),
										.S_din(S_din),.S_dout(S_dout),.m_interrupt(m_interrupt),.op_start(op_start),.op_clear(op_clear),
										.multiplicand(multiplicand),.multiplier(multipier),.result(result),.state(state));
	
	//multiplier
	multiplier_master U1_mul_Master(.clk(clk),.reset_n(reset_n),.op_start(op_start),.op_clear(op_clear),
										.multiplicand(multiplicand),.multiplier(multipier),.result(result),.state(state));
	
endmodule //End of module