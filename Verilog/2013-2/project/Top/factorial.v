///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Factorial
//FILE : factorial.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Factorial
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module factorial(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,f_interrupt,m_interrupt,M_req,M_wr,M_address,M_dout,M_grant,M_din); //module of Factorial
	input clk,reset_n,S_sel,S_wr,M_grant,m_interrupt; //clock pulse, reset, slave selection, slace write/read, master grant, multiplier interrupt
	input [7:0] S_address; //slave address
	input [31:0] S_din,M_din; //slave input, master input
	output M_wr,M_req,f_interrupt; //master write/read, master grant requirement, factorial interrupt
	output [7:0] M_address; //master address
	output [31:0] S_dout,M_dout; //slave output, master output
	
	wire op_start,op_clear; //start, clear
	wire [31:0] N_value; //wire of N value
	wire [63:0] result; //wire of reault
	wire [4:0] state; //wire of state
	
	//input/output values
	factorial_slave U0_factorial_slave(.clk(clk),.reset_n(reset_n),.S_sel(S_sel),.S_wr(S_wr),.S_address(S_address),.S_din(S_din),.S_dout(S_dout),
						.f_interrupt(f_interrupt),.N_value(N_value),.op_start(op_start),.op_clear(op_clear),.result(result),.state(state));
	
	//factorial operationg with multiplier
	factorial_master U0_factorial_master(.clk(clk),.reset_n(reset_n),.m_interrupt(m_interrupt),.M_grant(M_grant),.M_din(M_din),.M_req(M_req),.M_wr(M_wr),.M_address(M_address),
						.M_dout(M_dout),.N_value(N_value),.op_start(op_start),.op_clear(op_clear),.result(result),.state(state));

endmodule //End of module