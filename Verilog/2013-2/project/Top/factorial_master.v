///////////////////////////////////////////////////////////////////////////////////////////////////
//TITLE : Factorial master
//FILE : factorial_master.v
//ORGANIZATION : Kwangwoon Univ. Computer Engineering
//STUDENT ID : 2010720092
//STUDENT NAME : Hyunjae Lee(kc803@naver.com)
//PLATFORM : Windows 7 64-Bit
//SIMULATOR : ModelSim-Altera 10.1d
//COMPILER : Altera Quartus II 13.0 64-Bit
//TARGET BOARD : Altera DE2-70
//DESCRIPTION : This module defines Factorial master
//LAST UPDATE : DEC, 01, 2013
///////////////////////////////////////////////////////////////////////////////////////////////////

module factorial_master(clk,reset_n,m_interrupt,M_grant,M_din,M_req,M_wr,M_address,M_dout,N_value,op_start,op_clear,result,state); //module of Factorial master
	input clk,reset_n,m_interrupt,M_grant,op_start,op_clear; //clock pulse, reset, master interrupt
	input [31:0] M_din,N_value; //master input, N value
	output M_req,M_wr; //master requirement, master write/read
	output [7:0] M_address; //master address
	output [31:0] M_dout; //master output
	output [63:0] result; //result
	output [4:0] state; //state
	
	reg [31:0] reg_N_value; //register of N value
	
	wire op_done,S_grant; //operation done, slave grant
	wire [4:0] next_state; //next state
	wire [31:0] result0,result1,next_N_value; //next N value
	wire [63:0] next_result;
	
	assign result={result1,result0};
	
	always@(posedge clk, negedge reset_n)
	begin
		if(!reset_n) reg_N_value<=32'h00; //initialize
		else if(state==5'b00000) reg_N_value<=N_value; //set N value
		else reg_N_value<=next_N_value; //next N value
	end
	
	//state register
	_register5_r U0_state(.clk(clk),.reset_n(reset_n),.d(next_state),.q(state));
	
	//result
	_register32_r U1_register(.clk(clk),.reset_n(reset_n),.d(next_result[31:0]),.q(result0));
	_register32_r U2_register(.clk(clk),.reset_n(reset_n),.d(next_result[63:32]),.q(result1));
	
	//next state
	fact_ns_logic U3_ns_logic(.state(state),.op_start(op_start),.op_clear(op_clear),.op_done(op_done),.S_grant(S_grant),.M_grant(M_grant),.m_interrupt(m_interrupt),.next_state(next_state));
	
	//output state
	fact_os_logic U4_os_logic(.state(state),.op_done(op_done),.S_grant(S_grant),.M_din(M_din),.M_req(M_req),.M_wr(M_wr),.M_address(M_address),.N_value(reg_N_value),.M_dout(M_dout),.result(result),.next_result(next_result),.next_N_value(next_N_value));
	
endmodule //End of module