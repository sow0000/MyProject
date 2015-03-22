///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Combinational Circuit Logic
//FILE : cc_logic.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Combinational Circuit Logic
//LAST UPDATE : Nov. 06, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cc_logic(op,shamt,d_in,d_out,do_next); //Module of Combinational Circuit Logic
	input [2:0] op; //operation code
	input [1:0] shamt; //shift amount
	input [7:0] d_in; //input value
	input [7:0] d_out; //current state
	output [7:0] do_next; //next state
	reg [7:0] do_next; //register of next state
	
	wire [7:0] d_lsl; //result of lsl
	wire [7:0] d_lsr; //result of lsr
	wire [7:0] d_asr; //result of asr
	
	parameter NOP=3'b000; //no operation
	parameter LOAD=3'b001; //load
	parameter LSL=3'b010; //shift left
	parameter LSR=3'b011; //shift right
	parameter ASR=3'b100; //shift right with MSB
	
	always@(op,shamt,d_in,d_out,d_lsl,d_lsr,d_asr)
	begin
	case(op)
		NOP		:	do_next=d_out; //not change
		LOAD		:	do_next=d_in; //load d_in
		LSL		:	do_next=d_lsl; //shift left
		LSR		:	do_next=d_lsr; //shift right
		ASR		:	do_next=d_asr; //shift right with MSB
		default	:	do_next=8'hxx; //output high impedence
	endcase
	end
	
	LSL8 U0_LSL8(.d_in(d_out),.shamt(shamt),.d_out(d_lsl)); //shift left
	LSR8 U1_LSR8(.d_in(d_out),.shamt(shamt),.d_out(d_lsr)); //shift right
	ASR8 U2_ASR8(.d_in(d_out),.shamt(shamt),.d_out(d_asr));//shift right with MSB
	
endmodule //End of module