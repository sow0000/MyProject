module Multiplier_Master(clk,reset_n,op_start,op_clear,multiplicand,multiplier,result,state);
	input clk,reset_n,op_start,op_clear;
	input [63:0] multiplicand,multiplier;
	output [127:0] result;
	output [1:0] state;
	
	wire s_interrupt,op_code;
	wire [1:0] next_state;
	wire [2:0] B_operation;
	wire [7:0] num,w0_next_num,w1_next_num;
	wire [31:0] result0,result1,result2,result3;
	wire [31:0] multiplicand0,multiplicand1,multiplicand2,multiplicand3;
	wire [63:0] complement;
	wire [127:0] w0_next_result,w1_next_result;
	wire [127:0] w0_next_multiplicand,w1_next_multiplicand;
	wire [127:0] B_multiplicand;
	
	_register3_r U0_register3_r(.clk(clk),.reset_n(reset_n),.d(next_state),.q(state));
	Mul_ns_logic U1_ns_logic(.op_start(op_start),.op_clear(op_clear),.s_interrupt(s_interrupt),.state(state),.next_state(next_state));
	
	mx4_8bits U2_next_num(.d0(8'h0),.d1(8'h0),.d2(8'h1),.d3(w0_next_num),.s(state),.y(w1_next_num));
	_register8_r U3_next_num(.clk(clk),.reset_n(reset_n),.d(w1_next_num),.q(num));
	
	mx4_128bits U4_next_result(.d0(128'h00),.d1({result3,result2,result1,result0}),.d2(128'h00),.d3(w0_next_result),.s(state),.y(w1_next_result));
	_register32_r U5_next_result(.clk(clk),.reset_n(reset_n),.d(w1_next_result[31:0]),.q(result0));
	_register32_r U6_next_result(.clk(clk),.reset_n(reset_n),.d(w1_next_result[63:32]),.q(result1));
	_register32_r U7_next_result(.clk(clk),.reset_n(reset_n),.d(w1_next_result[95:64]),.q(result2));
	_register32_r U8_next_result(.clk(clk),.reset_n(reset_n),.d(w1_next_result[127:96]),.q(result3));
	
	mx2_64bits U9_next_multiplicand(.d0(64'h00),.d1(64'hFFFF_FFFF_FFFF_FFFF),.s(multiplicand[63]),.y(complement));
	mx4_128bits U10_next_multiplicand(.d0(128'h00),.d1({multiplicand3,multiplicand2,multiplicand1,multiplicand0}),.d2({complement,multiplicand}),.d3(w0_next_multiplicand),.s(state),.y(w1_next_multiplicand));
	_register32_r U11_next_multiplicand(.clk(clk),.reset_n(reset_n),.d(w1_next_multiplicand[31:0]),.q(multiplicand0));
	_register32_r U12_next_multiplicand(.clk(clk),.reset_n(reset_n),.d(w1_next_multiplicand[63:32]),.q(multiplicand1));
	_register32_r U13_next_multiplicand(.clk(clk),.reset_n(reset_n),.d(w1_next_multiplicand[95:64]),.q(multiplicand2));
	_register32_r U14_next_multiplicand(.clk(clk),.reset_n(reset_n),.d(w1_next_multiplicand[127:96]),.q(multiplicand3));
	
	booth_enc U15_booth_enc(.num(num),.multiplier({multiplier,1'b0}),.s_interrupt(s_interrupt),.next_num(w0_next_num),.B_operation(B_operation));
	booth_sel U16_booth_sel(.B_operation(B_operation),.multiplicand({multiplicand3,multiplicand2,multiplicand1,multiplicand0}),.op_code(op_code),.B_multiplicand(B_multiplicand),.next_multiplicand(w0_next_multiplicand));
	cla128 U17_cla128(.a({result3,result2,result1,result0}),.b(B_multiplicand),.ci(op_code),.s(w0_next_result));
	
	assign result=w0_next_result;
	
endmodule //End of module