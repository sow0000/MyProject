////////////////////////////////////////////////////////////////
//	TITLE : Instruction Fetch
//	FILE : IF.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Instruction Fetch.	
//								Use PC, IM, ADD, MUX, Register each five module.
//	LAST UPDATE : 05.19, 2014	
////////////////////////////////////////////////////////////////

module IF(i_clk,i_rst_n,i_PCSrc,i_jump_addr,i_branch_addr,PC_Write,IFID_Write,Jump,o_next_pc,o_data);
	input i_clk,i_rst_n,i_PCSrc,PC_Write,IFID_Write,Jump;
	input [31:0] i_jump_addr,i_branch_addr;
	output [31:0] o_next_pc,o_data;
	
	wire IFFlush;
	wire [31:0] w_pc,w_ADD_pc,w_next_pc,w_data;
	
	assign IFFlush = i_PCSrc | Jump;
	assign w_next_pc = (Jump==0) ? ((i_PCSrc==0) ? w_ADD_pc : i_branch_addr) : i_jump_addr;
	
	PC				U0_PC(.i_next_pc(w_next_pc),.o_pc(w_pc),.i_rst_n(i_rst_n),.i_clk(i_clk),.PC_Write(PC_Write)); // Program Counter
	IM				U1_IM(.i_addr(w_pc),.o_instr(w_data)); // Instruction Memory
	R_IF_ID		U2_IF_ID(.i_clk(i_clk),.i_rst_n(i_rst_n),.IFID_Write(IFID_Write),.IFFlush(IFFlush),.i_next_pc(w_pc),.i_data(w_data),.o_next_pc(o_next_pc),.o_data(o_data)); // Register
	ADD			U3_ADD_PC(.i_data1(w_pc),.i_data2(32'h0000_0004),.o_sum(w_ADD_pc)); // Adder for Program Counter
	
endmodule //End of module