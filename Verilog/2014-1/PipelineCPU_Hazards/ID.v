////////////////////////////////////////////////////////////////
//	TITLE : Instruction Decoder
//	FILE : ID.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering	
//	STUDENT ID : 2010720092, 2010720117	
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim	
//	PLATFORM : Windows 7	
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Instruction Decoder.	
//								Use RF, MainControl, SEU, Register each four module.
//	LAST UPDATE : 05.19, 2014	
////////////////////////////////////////////////////////////////

module ID(i_clk,i_rst_n,RegWrite,i_next_PC,i_write_reg,i_write_data,i_data,IDFlush,EX_Bubble,o_jump,o_next_pc,o_read_data1,o_read_data2,o_imm,o_src_reg,o_tar_reg,o_des_reg,o_WB_control,o_MEM_control,o_EX_control);
	input i_clk,i_rst_n,RegWrite,IDFlush,EX_Bubble;
	input [4:0] i_write_reg;
	input [31:0]i_next_PC,i_data,i_write_data;
	output o_jump;
	output [1:0] o_WB_control;
	output [2:0] o_MEM_control;
	output [3:0] o_EX_control;
	output [4:0] o_src_reg,o_tar_reg,o_des_reg;
	output [31:0]o_next_pc,o_read_data1,o_read_data2,o_imm;
	
	wire w_RegDst,w_Branch,w_MemRead,w_MemtoReg,w_MemWrite,w_ALUSrc,w_RegWrite,w_sel;
	wire [1:0] w_ALUOp;
	wire [8:0] w_control;
	wire [31:0] w_read_data1,w_read_data2,w_imm,w_next_pc;
	
	assign w_sel = EX_Bubble | IDFlush;
	assign w_control = (w_sel==0) ? {w_MemtoReg,w_RegWrite,w_MemWrite,w_MemRead,w_Branch,w_ALUSrc,w_ALUOp,w_RegDst} : 9'b0;
	
	RF				U0_RF(.i_Write_reg(i_write_reg),.RegWrite(RegWrite),.i_Write_data(i_write_data),.i_rst_n(i_rst_n),.i_clk(i_clk),
						.i_Read_reg1(i_data[25:21]),.i_Read_reg2(i_data[20:16]),.o_Read_data1(w_read_data1),.o_Read_data2(w_read_data2)); // Register File
	R_ID_EX		U1_ID_EX(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_next_pc(w_next_pc),.i_read_data1(w_read_data1),.i_read_data2(w_read_data2),
						.i_imm(w_imm),.i_src_reg(i_data[25:21]),.i_tar_reg(i_data[20:16]),.i_des_reg(i_data[15:11]),.i_WB_control(w_control[8:7]),
						.i_MEM_control(w_control[6:4]),.i_EX_control(w_control[3:0]),.o_next_pc(o_next_pc),
						.o_read_data1(o_read_data1),.o_read_data2(o_read_data2),.o_imm(o_imm),.o_src_reg(o_src_reg),.o_tar_reg(o_tar_reg),
						.o_des_reg(o_des_reg),.o_WB_control(o_WB_control),.o_MEM_control(o_MEM_control),.o_EX_control(o_EX_control)); // Register
	MainControl	U2_MainControl(.op(i_data[31:26]),.RegDst(w_RegDst),.Jump(o_jump),.Branch(w_Branch),.MemRead(w_MemRead),
										.MemtoReg(w_MemtoReg),.ALUOp(w_ALUOp),.MemWrite(w_MemWrite),.ALUSrc(w_ALUSrc),.RegWrite(w_RegWrite)); // Main Control
	SEU			U3_SEU(.i_halfword(i_data[15:0]),.o_word(w_imm)); // Sign Extension Unit
	ADD			U3_ADD_PC(.i_data1({w_imm[29:0],2'b0}),.i_data2(i_next_pc),.o_sum(w_next_pc)); // Adder for PC
	
endmodule //End of module