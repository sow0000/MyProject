///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : BUS
//FILE : bus.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines BUS
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module bus(clk,reset_n,M0_req,M0_wr,M0_address,M0_dout,M1_req,M1_wr,M1_address,M1_dout,S0_sel,S1_sel,S2_sel,S_wr,S_address,S_din,M0_grant,M1_grant,M_din,S0_dout,S1_dout,S2_dout); //module of BUS
	input clk,reset_n,M0_req,M0_wr,M1_req,M1_wr; //clock pulse, reset, requirement, write/read
	input [7:0] M0_address,M1_address; //address
	input [31:0] M0_dout,M1_dout,S0_dout,S1_dout,S2_dout; //master input values, slave output values
	
	output M0_grant,M1_grant,S0_sel,S1_sel,S2_sel,S_wr; //master grants, slave selections, slave write/read
	output [7:0] S_address; //slave address
	output [31:0] M_din,S_din; //master output, slave input
	
	reg [2:0] reg_sel; //selection register
	
	wire M0_grant,S0_sel,S1_sel,S2_sel; //wire of master grant and slave selections
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n) reg_sel <= 3'b0; //initialize selection register
		else reg_sel <= {S0_sel,S1_sel,S2_sel};
	end
	
	arbitrator U0_arbitrator(.clk(clk),.reset_n(reset_n),.M0_req(M0_req),.M1_req(M1_req),.M0_grant(M0_grant),.M1_grant(M1_grant)); //arbitrator
	mx2 U1_mx2(.d0(M1_wr),.d1(M0_wr),.s(M0_grant),.y(S_wr)); //select write/read permission
	mx2_8bits U2_mx2_8bits(.d0(M1_address),.d1(M0_address),.s(M0_grant),.y(S_address)); //select address
	mx2_32bits U3_mx2_32bits(.d0(M1_dout),.d1(M0_dout),.s(M0_grant),.y(S_din)); //select slave input value
	addr_dec U4_addr_dec(.addr(S_address),.s0(S0_sel),.s1(S1_sel),.s2(S2_sel)); //address decoder
	mx4_32bits U5_mx4_32bits(.y(M_din),.d0(S0_dout),.d1(S1_dout),.d2(S2_dout),.d3(32'h00),.s(reg_sel)); //select slave output selection
	
endmodule //End of module