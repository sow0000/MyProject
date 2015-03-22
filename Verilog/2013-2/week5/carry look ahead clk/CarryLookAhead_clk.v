///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32bit Carry Look Ahead with clock
//FILE : CarryLookAhead_clk.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32bit Carry Look Ahead Adder with clock.
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module CarryLookAhead_clk(clock,a,b,ci,s_cla,co_cla); //Module of 4-bit Carry Look Ahead with clock
	input clock; //Clock pulse
	input [31:0] a, b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [31:0] s_cla; //s_cla : Output port for result
	output co_cla; //co_cla : Output port for carry of result
	
	reg [31:0] reg_a,reg_b; //Register for a, b
	reg reg_ci; //Register for ci
	reg [31:0] reg_s_cla; //Register for s_cla
	reg reg_co_cla; //Register for co_cla
	
	wire [31:0] wire_s_cla; //Wire for s_cla
	wire wire_co_cla; //Wire for co_cla
	
	always @ (posedge clock) //Doing follow source when clock is rising edge
	begin
		reg_a <= a; //Save a into regster
		reg_b <= b; //Save b into regster
		reg_ci <= ci; //Save ci into regster
		reg_s_cla <= wire_s_cla; //Save s_cla into regster
		reg_co_cla <= wire_co_cla; //Save co_cla into regster
	end
	
	CarryLookAhead32 U0_CarryLookAhead32(.a(reg_a),.b(reg_b),.ci(reg_ci),.s(wire_s_cla),.co(wire_co_cla)); //Add reg_a to reg_b
	
	assign s_cla=reg_s_cla; //Input reg_s_cla into s_cla
	assign co_cla=reg_co_cla; //Input reg_co_cla into co_cla
endmodule //End of module