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
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module os_logic(state,d_in,d_out); //Module of Output State Logic
	input [2:0] state; //current state
	input [7:0] d_in; //input value
	output [7:0] d_out; //output value
	
	reg [7:0] d_out; //register of output value
	wire [7:0] d_inc; //increase value
	wire [7:0] d_dec; //decrease value
	
	parameter IDLE_STATE=3'b000; //Ideal state
	parameter LOAD_STATE=3'b001; //Load state
	parameter INC_STATE=3'b010; //Increase state
	parameter INC2_STATE=3'b011; //Increase state 2
	parameter DEC_STATE=3'b100; //Decrease state
	parameter DEC2_STATE=3'b101; //Decrease state 2
	
	always@(state)
	begin
		case(state)
			IDLE_STATE	:	d_out=8'b00000000;
			LOAD_STATE	:	d_out=d_in;
			INC_STATE	:	d_out=d_inc;
			INC2_STATE	:	d_out=d_inc;
			DEC_STATE	:	d_out=d_dec;
			DEC2_STATE	:	d_out=d_dec;
			default		:	d_out=8'bx;
		endcase
	end
	
	cla8 U0_cla8(.a(d_out),.b(8'b00000001),.ci(1'b0),.s(d_inc));
	cla8 U1_cla8(.a(d_out),.b(8'b11111111),.ci(1'b0),.s(d_dec));
	
endmodule //End of module