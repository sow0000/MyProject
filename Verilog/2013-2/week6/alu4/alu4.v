///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 4-bit Arithmetic Logic Unit
//FILE : alu4.v
//TESTBENCH : tb_alu4.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 4-bit Arithmetic Logic Unit
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module alu4(a, b, op, result, c, n, z, v); //Moudle of 4-bit Arithmetic Logic Unit
	input [3:0] a, b; //4-bit input
	input [2:0] op; //OP code
	output [3:0] result; //4-bit result
	output c, n, z, v; //output flags
	wire [3:0] w_not_a, w_not_b, w_and, w_or, w_xor, w_xnor, w_add, w_sub; //wire of results
	wire  c3_add, co_add, c3_sub, co_sub; //wire of carry
	
	_inv_4bits U0_inv_4bits(.a(a), .y(w_not_a)); //NOT A
	_inv_4bits U1_inv_4bits(.a(b), .y(w_not_b)); //NOT B
	_and2_4bits U2_and2_4bits(.a(a), .b(b), .y(w_and)); //A AND B
	_or2_4bits U3_or2_4bits(.a(a), .b(b), .y(w_or)); //A OR B
	_xor2_4bits U4_xor2_4bits(.a(a), .b(b), .y(w_xor)); //A XOR B
	_xnor2_4bits U5_xnor2_4bits(.a(a), .b(b), .y(w_xnor)); //A XNOR B
	cla4_ov U6_cla4_ov(.a(a), .b(b), .ci(1'b0), .s(w_add), .c3(c3_add), .co(co_add)); //Add B to A
	cla4_ov U7_cla4_ov(.a(a), .b(w_not_b), .ci(1'b1), .s(w_sub), .c3(c3_sub), .co(co_sub)); //SUB B from A
	mx8_4bits U8_mx8_4bits(.a(w_not_a), .b(w_not_b), .c(w_and), .d(w_or), .e(w_xor), .f(w_xnor), .g(w_add), .h(w_sub) ,.s0(op[0]), .s1(op[1]), .s2(op[2]), .y(result)); //Select result
	cal_flags4 U9_cal_flags4(.op(op), .result(result), .co_add(co_add), .c3_add(c3_add), .co_sub(co_sub), .c3_sub(c3_sub) ,.c(c), .n(n) ,.z(z), .v(v)); //Calculate flags

endmodule //End of module