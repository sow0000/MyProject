///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-bit Calculate flags
//FILE : cal_flags4.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-bit Calculate flags
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cal_flags4(op, result, co_add, c3_add, co_sub, c3_sub, c, n, z, v); //Module of 4-bit Calculate flags
	input [2:0] op; //OP code
	input [3:0] result; //result of alu
	input co_add, c3_add, co_sub, c3_sub; //carry of alu
	output c, n, z, v; //output flags
	
	assign c = (op[2:1] != 2'b11) ? 1'b0 : ((op[0] ==1'b0) ? co_add : co_sub); //co=flag of carry
	assign n = result[3]; //MSB=flag of negative
	assign z = (result == 4'b0) ? 1'b1 : 1'b0; //if result is 0, set flag of zero
	assign v = (op[2:1] != 2'b11) ? 1'b0 : ((op[0]) == 1'b0) ? (co_add^c3_add) : (co_sub^c3_sub); //co^c3=flag of overflow
	
endmodule //End of module