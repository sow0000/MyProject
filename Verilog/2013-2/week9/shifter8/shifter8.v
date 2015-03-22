///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 8-bit Loadable Shifter
//FILE : shifter.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 8-bit Loadable Shifter
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module shifter8(clk,reset_n,op,shamt,d_in,d_out); //Module of 8-bit Loadable Shifter
	input clk,reset_n; //clk : clock pulse; //reset_n : reset switch
	input [2:0] op; //operation code
	input [1:0] shamt; //shift amount
	input [7:0] d_in; //input value
	output [7:0] d_out; //output value
	
	wire [7:0] d_out; //current state
	wire [7:0] do_next; //next state
	
	_register8_r U0_reg8_r (.clk(clk),.reset_n(reset_n),.d(do_next),.q(d_out)); //save value
	cc_logic U1_cc_logic (.op(op),.shamt(shamt),.d_in(d_in),.d_out(d_out),.do_next(do_next)); //operating next state
	
endmodule //End of module