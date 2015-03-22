module Factorial(clk,reset_n,S_sel,S_wr,S_address,S_din,S_dout,f_interrupt,m_interrupt,M_req,M_wr,M_address,M_dout,M_grant,M_din);
	input clk,reset_n,S_sel,S_wr,M_grant,m_interrupt;
	input [7:0] S_address;
	input [31:0] S_din,M_din;
	output M_wr,M_req,f_interrupt;
	output [7:0] M_address;
	output [31:0] S_dout,M_dout;
	
	wire op_start,op_clear;
	wire [31:0] N_value;
	wire [63:0] result;
	wire [3:0] state;
	
	Factorial_slave U0_Factorial_slave(.clk(clk),.reset_n(reset_n),.S_sel(S_sel),.S_wr(S_wr),.S_address(S_address),.S_din(S_din),.S_dout(S_dout),
						.f_interrupt(f_interrupt),.N_value(N_value),.op_start(op_start),.op_clear(op_clear),.result(result),.state(state));
	Factorial_master U0_Factorial_master(.clk(clk),.reset_n(reset_n),.m_interrupt(m_interrupt),.M_grant(M_grant),.M_din(M_din),.M_req(M_req),.M_wr(M_wr),.M_address(M_address),
						.M_dout(M_dout),.N_value(N_value),.op_start(op_start),.op_clear(op_clear),.result(result),.state(state));

endmodule //End of module