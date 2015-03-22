module Multiplier(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,m_interrupt);
	input clk,reset_n,S_sel,S_wr;
	input [7:0] S_address;
	input [31:0] S_din;
	output [31:0] S_dout;
	output m_interrupt;
	
	wire op_start,op_clear;
	wire [1:0] state;
	wire [63:0] multiplicand;
	wire [63:0] multipier;
	wire [127:0] result;
	
	Multiplier_slave U0_Mul_slave(.clk(clk),.reset_n(reset_n),.S_sel(S_sel),.S_wr(S_wr),.S_address(S_address),
										.S_din(S_din),.S_dout(S_dout),.m_interrupt(m_interrupt),.op_start(op_start),.op_clear(op_clear),
										.multiplicand(multiplicand),.multiplier(multipier),.result(result),.state(state));
	Multiplier_Master U1_Mul_Master(.clk(clk),.reset_n(reset_n),.op_start(op_start),.op_clear(op_clear),
										.multiplicand(multiplicand),.multiplier(multipier),.result(result),.state(state));
	
endmodule //End of module