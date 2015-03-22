///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Booth encoder
//FILE : booth_enc.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Booth encoder
//LAST UPDATE : Dec. 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module booth_enc(num,multiplier,op_done,next_num,B_operation); //module of Booth encoder
	input [7:0] num; //current bit
	input [64:0] multiplier; //input multiplier
	output reg op_done; //operator done
	output [7:0] next_num; //next bit
	output [2:0] B_operation; //booth operation
	
	wire [7:0] W0_num,W1_num; //num+1, num-1
	wire W0_op,W1_op,W2_op; //wire for booth operation
	
	always@(num)
	begin
		if(num==8'h3F) op_done=1'b1; //meet MSB of multiplier, operation done
		else op_done=1'b0;
	end
	
	cla8 U0_cla8(.a(num),.b(8'h01),.ci(1'b0),.s(W0_num)); //num+1
	cla8 U1_cla8(.a(num),.b(8'hFF),.ci(1'b0),.s(W1_num)); //num-1
	cla8 U2_cla8(.a(num),.b(8'h02),.ci(1'b0),.s(next_num)); //next num = num+2
	
	assign W0_op=(~multiplier[W0_num])&(multiplier[num])&(multiplier[W1_num]);
	assign W1_op=(multiplier[W0_num])&(~multiplier[num])&(multiplier[W1_num]);
	assign W2_op=(multiplier[W0_num])&(multiplier[num])&(~multiplier[W1_num]);
	
	assign B_operation[2]=(multiplier[W0_num])&(~multiplier[num])&(~multiplier[W1_num]);
	assign B_operation[1]=(W0_op)|(W1_op)|(W2_op);
	assign B_operation[0]=(~multiplier[W0_num])&((multiplier[num])|(multiplier[W1_num]));
	
endmodule //End of module