////////////////////////////////////////////////////////////////
//	TITLE : Program Counter
//	FILE : PC.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering
//	STUDENT ID : 2010720092, 2010720117
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim		
//	PLATFORM : Windows 7
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Program Counter.	
//								Use 32 bit Register, and Reset signal.
//	LAST UPDATE : 04.29, 2014
////////////////////////////////////////////////////////////////
module PC(i_pc_w_c,i_next_pc,o_pc,i_rst_n,i_clk);
	input [31:0] i_next_pc;
 	input i_pc_w_c,i_rst_n, i_clk;
	output reg [31:0] o_pc;

	always @ (posedge i_clk or negedge i_rst_n) // clock is rising edge or reset is falling edge
	begin
		if(i_rst_n == 0) o_pc <= 32'h0000_0000; // if Reset is ON, then output is 0
		else if(i_pc_w_c == 1) o_pc <= i_next_pc; // if Reset is OFF, Write signal is ON, then output is next pc
	end

endmodule
