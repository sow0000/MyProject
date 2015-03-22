////////////////////////////////////////////////////////////////
//	TITLE : Execution
//	FILE : EX.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Execution.	
//								Use ALU, ADD, MUX, ALUControl, Register each six module.
//	LAST UPDATE : 05.19, 2014	
////////////////////////////////////////////////////////////////

module EX(i_clk,i_rst_n,i_next_pc,i_read_data1,i_read_data2,i_imm,i_tar_reg,i_des_reg,i_WB_control,i_MEM_control,i_EX_control,ForwardA,ForwardB,i_mem_data,EXFlush,o_branch_pc,o_result,o_zero,o_read_data2,o_write_reg,o_WB_control,o_MEM_control);
	input i_clk,i_rst_n,EXFlush;
	input [1:0] i_WB_control,ForwardA,ForwardB;
	input [2:0] i_MEM_control;
	input [3:0] i_EX_control;
	input [4:0] i_tar_reg,i_des_reg;
	input [31:0] i_next_pc,i_read_data1,i_read_data2,i_imm,i_mem_data;
	output o_zero;
	output [1:0] o_WB_control;
	output [2:0] o_MEM_control;
	output [4:0] o_write_reg;
	output [31:0] o_branch_pc,o_result,o_read_data2;
	
	wire w_zero;
	wire [1:0] w_WB_control;
	wire [2:0] w_MEM_control;
	wire [3:0] w_ALUop;
	wire [31:0] w_result,w_branch_pc,w_read_data1,w_read_data2,w_read_data3,w_write_reg;
	
	assign w_WB_control = (EXFlush==0) ? i_WB_control : 2'b0;
	assign w_MEM_control = (EXFlush==0) ? i_MEM_control : 3'b0;
	assign w_read_data1 = (ForwardA[1]==0) ? ((ForwardA[0]==0) ? i_read_data1 : i_mem_data) : o_result;
	assign w_read_data2 = (ForwardB[1]==0) ? ((ForwardA[0]==0) ? i_read_data2 : i_mem_data) : o_result;
	assign w_read_data3 = (i_EX_control[3]==0) ? w_read_data2 : i_imm;
	assign w_write_reg = (i_EX_control[0]==0) ? i_tar_reg : i_des_reg;
	
	
	ALU				U0_ALU(.i_data1(w_read_data1),.i_data2(w_read_data3),.shamt(i_imm[10:6]),.ALUop(w_ALUop),.o_result(w_result),.o_zero(w_zero)); // Arithmetic logic unit
	R_EX_MEM			U1_EX_MEM(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_branch_pc(w_branch_pc),.i_result(w_result),.i_zero(w_zero),.i_read_data2(i_read_data2),
									.i_write_reg(w_write_reg),.i_WB_control(w_WB_control),.i_MEM_control(w_MEM_control),.o_branch_pc(o_branch_pc),.o_result(o_result),
									.o_zero(o_zero),.o_read_data2(o_read_data2),.o_write_reg(o_write_reg),.o_WB_control(o_WB_control),.o_MEM_control(o_MEM_control)); // Register
	ADD				U3_ADD_Branch(.i_data1(i_next_pc),.i_data2({i_imm[29:0],2'b00}),.o_sum(w_branch_pc)); // Adder for branch
	ALUControl		U6_ALUControl(.funct(i_imm[5:0]),.ALUOp(i_EX_control[2:1]),.ALU_control_signal(w_ALUop)); // ALU Control
	
	
endmodule //End of module