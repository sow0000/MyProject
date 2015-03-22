module Factorial_master(clk,reset_n,m_interrupt,M_grant,M_din,M_req,M_wr,M_address,M_dout,N_value,op_start,op_clear,result,state);
	input clk,reset_n,m_interrupt,M_grant,op_start,op_clear;
	input [31:0] M_din,N_value;
	output M_req,M_wr;
	output [7:0] M_address;
	output [31:0] M_dout;
	output [63:0] result;
	output [3:0] state;
	
	wire op_done,S_grant;
	wire [3:0] next_state;
	
	_register4_r U0_state(.clk(clk),.reset_n(reset_n),.d(next_state),.q(state));
	Fact_ns_logic U1_ns_logic(.state(state),.op_start(op_start),.op_clear(op_clear),.op_done(op_done),.S_grant(S_grant),.M_grant(M_grant),.m_interrupt(m_interrupt),.next_state(next_state));
	Fact_os_logic U2_os_logic(state,op_done,S_grant,M_din,M_req,M_wr,M_address,N_value,M_dout,result);
endmodule //End of module