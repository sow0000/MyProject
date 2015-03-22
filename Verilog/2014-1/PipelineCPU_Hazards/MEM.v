////////////////////////////////////////////////////////////////
//	TITLE : Memory access
//	FILE : MEM.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Memory access.	
//								Use DM, Register each two module.
//	LAST UPDATE : 05.19, 2014	
////////////////////////////////////////////////////////////////

module MEM(i_clk,i_rst_n,i_result,i_zero,i_read_data2,i_write_reg,i_WB_control,i_MEM_control,i_branch_pc,o_write_reg,o_write_data,o_result,o_WB_control,o_branch,o_branch_pc);
	input i_clk,i_rst_n,i_zero;
	input [1:0] i_WB_control;
	input [2:0] i_MEM_control;
	input [4:0] i_write_reg;
	input [31:0] i_result,i_read_data2,i_branch_pc;
	output o_branch;
	output [1:0] o_WB_control;
	output [4:0] o_write_reg;
	output [31:0] o_write_data,o_result,o_branch_pc;
	
	wire [31:0] w_data;
	
	assign o_branch_pc=i_branch_pc;
	assign o_branch=i_MEM_control[0]&i_zero;
	
	DM				U0_DM(.i_clk(i_clk),.MemRead(i_MEM_control[1]),.MemWrite(i_MEM_control[2]),.i_addr(i_result),.i_data(i_read_data2),.o_data(w_data)); // Data Memory
	R_MEM_WB		U1_MEM_WB(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_write_reg(i_write_reg),.i_write_data(w_data),.i_result(i_result),.i_WB_control(i_WB_control),
								.o_write_reg(o_write_reg),.o_write_data(o_write_data),.o_result(o_result),.o_WB_control(o_WB_control)); // Register

endmodule //End of module