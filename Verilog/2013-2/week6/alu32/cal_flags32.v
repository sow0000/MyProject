///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit Calculate flags
//FILE : cal_flags32.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32-bit Calculate flags
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module cal_flags32(op ,result, co_add, co_prev_add, co_sub, co_prev_sub, c, n, z, v); //Module of 32-bit Calculate flags
	input [2:0] op; //OP code
	input [31:0] result; //result of alu
	input co_add, co_prev_add, co_sub, co_prev_sub; //carry of alu
	output c, n, z, v; //output flags
	
	assign c =(op[2:1] != 2'b11) ? 1'b0 : (op[0] == 1'b0) ? co_add : co_sub; //co=flag of carry
	assign n = result[31]; //MSB=flag of negative
	assign z = (result == 32'b0) ? 1'b1 : 1'b0; //if result is 0, set flag of zero
	assign v = (op[2:1] != 2'b11) ? 1'b0 : (op[0] == 1'b0) ? (co_add^co_prev_add) : (co_sub^co_prev_sub); //co^c3=flag of overflow

endmodule //End of module