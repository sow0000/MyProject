///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32bit Ripple Carry Adder with clock
//FILE : RippleCarryAdder_clk.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32bit Ripple Carry Adder with clock.
//LAST UPDATE : Oct. 10, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module RippleCarryAdder_clk(clock, a, b, ci, s_rca, co_rca); //Module of 4-bit Ripple Carry Adder with clock
	input clock; //Clock pulse
	input [31:0] a, b; //a,b : Variable of input binary number
	input ci; //ci : Variable of input carry value
	output [31:0] s_rca; //s_rca : Output port for result
	output co_rca; //co_rca : Output port for carry of result
	
	reg [31:0] reg_a,reg_b; //Register for a, b
	reg reg_ci; //Register for ci
	reg [31:0] reg_s_rca; //Register for s_rca
	reg reg_co_rca; //Register for co_rca
	
	wire [31:0] wire_s_rca; //Wire for s_rca
	wire wire_co_rca; //Wire for co_rca
	
	always @ (posedge clock) //Doing follow source when clock is rising edge
	begin
		reg_a <= a; //Save a into regster
		reg_b <= b; //Save b into regster
		reg_ci <= ci; //Save ci into regster
		reg_s_rca <= wire_s_rca; //Save s_rca into regster
		reg_co_rca <= wire_co_rca; //Save co_rca into regster
	end
	
	RippleCarryAdder32 U0_RippleCarryAdder32(.a(reg_a),.b(reg_b),.ci(reg_ci),.s(wire_s_rca),.co(wire_co_rca)); //Add reg_a to reg_b
	
	assign s_rca=reg_s_rca; //Input reg_s_rca into s_rca
	assign co_rca=reg_co_rca; //Input reg_co_rca into co_rca
	
endmodule //End of module