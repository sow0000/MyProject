///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Top
//FILE : top.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Top
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module top(clk,reset_n,M_req,M_wr,M_address,M_dout,M_grant,M_din,f_interrupt,m_interrupt); //module of Top
	input clk,reset_n,M_req,M_wr; //clock pulse, reset, master requirement, master write/read
	input [7:0] M_address; //master address
	input [31:0] M_dout; //master input data
	output M_grant,f_interrupt,m_interrupt; //master grant, factorial interrupt, multiplier interrupt
	output [31:0] M_din; //master output data
	
	wire M1_req,M1_wr,M1_grant; //wire of factorial master values
	wire S0_sel,S1_sel,S2_sel,S_wr; //wire of slave selection values
	wire [7:0] M1_address,S_address; //wire of factorial master address and slave address
	wire [31:0] M1_dout,S_din,S0_dout,S1_dout,S2_dout; //wire of factorial master output and slave values
	
	//module of BUS
	bus U0_bus(.clk(clk),.reset_n(reset_n),.M0_req(M_req),.M0_wr(M_wr),.M0_address(M_address),
				.M0_dout(M_dout),.M1_req(M1_req),.M1_wr(M1_wr),.M1_address(M1_address),.M1_dout(M1_dout),
				.S0_sel(S0_sel),.S1_sel(S1_sel),.S2_sel(S2_sel),.S_wr(S_wr),.S_address(S_address),.S_din(S_din),
				.M0_grant(M_grant),.M1_grant(M1_grant),.M_din(M_din),.S0_dout(S0_dout),.S1_dout(S1_dout),.S2_dout(S2_dout));
	
	//module of Random Access Memory
	ram U1_ram(.clk(clk),.reset_n(reset_n),.cen(S0_sel),.wen(S_wr),.addr(S_address),.din(S_din),.dout(S0_dout));
	
	//module of Factorial operator
	factorial U2_factorial(.clk(clk),.reset_n(reset_n),.S_sel(S1_sel),.S_wr(S_wr),.S_address(S_address),.S_din(S_din),.S_dout(S1_dout),
				.f_interrupt(f_interrupt),.m_interrupt(m_interrupt),.M_req(M1_req),.M_wr(M1_wr),.M_address(M1_address),.M_dout(M1_dout),.M_grant(M1_grant),.M_din(M_din));
	
	//module of Multiplier operator
	multiplier U3_multiplier(.clk(clk),.reset_n(reset_n),.S_sel(S2_sel),.S_wr(S_wr),.S_address(S_address),.S_din(S_din),.S_dout(S2_dout),.m_interrupt(m_interrupt));
endmodule //End of module