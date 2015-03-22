///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : 32-bit Arithmetic Logic Unit
//FILE : alu32.v
//TESTBENCH : tb_alu32.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 SP1
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines 32-bit Arithmetic Logic Unit
//LAST UPDATE : Oct. 15, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module alu32(a, b, op, result, c, n, z, v); //Moudle of 32-bit Arithmetic Logic Unit
	input [31:0] a, b; //32-bit input
	input [2:0] op; //OP code
	output [31:0] result; //32-bit result
	output c, n, z, v; //output flags
	wire [31:0] w_not_a, w_not_b, w_and, w_or, w_xor, w_xnor, w_add, w_sub; //wire of results
	wire  c_prev_add, co_add, c_prev_sub, co_sub; //wire of carry
	
	_inv_32bits U0_inv_32bits(.a(a), .y(w_not_a)); //NOT A
	_inv_32bits U1_inv_32bits(.a(b), .y(w_not_b)); //NOT B
	_and2_32bits U2_and2_32bits(.a(a), .b(b), .y(w_and)); //A AND B
	_or2_32bits U3_or2_32bits(.a(a), .b(b), .y(w_or)); //A OR B
	_xor2_32bits U4_xor2_32bits(.a(a), .b(b), .y(w_xor)); //A XOR B
	_xnor2_32bits U5_xnor2_32bits(.a(a), .b(b), .y(w_xnor)); //A XNOR B
	cla32_ov U6_cla32_ov(.a(a), .b(b), .ci(1'b0), .s(w_add), .c31(c_prev_add), .co(co_add)); //Add B to A
	cla32_ov U7_cla32_ov(.a(a), .b(w_not_b), .ci(1'b1), .s(w_sub), .c31(c_prev_sub), .co(co_sub)); //SUB B from A
	mx8_32bits U8_mx8_32bits(.a(w_not_a), .b(w_not_b), .c(w_and), .d(w_or), .e(w_xor), .f(w_xnor), .g(w_add), .h(w_sub) ,.s0(op[0]), .s1(op[1]), .s2(op[2]), .y(result)); //Select result
	cal_flags32 U9_cal_flags32(.op(op), .result(result), .co_add(co_add), .co_prev_add(c_prev_add), .co_sub(co_sub), .co_prev_sub(c_prev_sub) ,.c(c), .n(n) ,.z(z), .v(v)); //Calculate flags

endmodule //End of module