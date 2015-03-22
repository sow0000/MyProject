////////////////////////////////////////////////////////////////
//	TITLE : Single Cylcle CPU
//	FILE : SingleCycleCPU.v	
//	ORGANIZATION : Kwangwoon Univ. Computer Engineering
//	STUDENT ID : 2010720092, 2010720117
//	STUDENT NAME : Hyunjae Lee, Seongjoong Kim		
//	PLATFORM : Windows 7
//	SIMULATOR : ModelSim PE Student Edition 10.3	
//	COMPILER : ModelSim PE Student Edition 10.3	
//	DESCRIPTION : This module defines Single Cylcle CPU.	
//								Use .
//	LAST UPDATE : 04.07, 2014
////////////////////////////////////////////////////////////////
module SingleCycleCPU(i_clk,i_rst_n);
	input i_clk,i_rst_n;
	
	// wire for connect each module
	wire w_RegDst,w_Jump,w_Branch,w_MemRead,w_MemtoReg,w_MemWrite,w_ALUSrc,w_RegWrite;
	wire [1:0] w_ALUop;
	wire [3:0] w_ALUCtrl;
	wire [31:0] w_ADD_PC,w_PC_data,w_IM_instr,w_RF_data1,w_RF_data2,
					w_ALU_data2,w_ALU_result,
					w_SEU_word,w_ADD_BR,w_DM_data,w_WD_data,
					w_MUX_WR,w_MUX_BR,w_MUX_J;

	// Connect all module
	PC				U0_PC(.i_next_pc(w_MUX_J),.o_pc(w_PC_data),.i_rst_n(i_rst_n),.i_clk(i_clk)); // Program Counter
	IM				U1_IM(.i_addr(w_PC_data),.o_instr(w_IM_instr)); // Instruction Memory
	ADD			U2_ADD_PC(.i_data1(w_PC_data),.i_data2(32'h0000_0004),.o_sum(w_ADD_PC)); // Adder for Program Counter
	RF				U3_RF(.i_Write_reg(w_MUX_WR),.RegWrite(w_RegWrite),.i_Write_data(w_WD_data),.i_rst_n(i_rst_n),.i_clk(i_clk),
							.i_Read_reg1(w_IM_instr[25:21]),.i_Read_reg2(w_IM_instr[20:16]),.o_Read_data1(w_RF_data1),.o_Read_data2(w_RF_data2));
	ALU			U4_ALU(.i_data1(w_RF_data1),.i_data2(w_ALU_data2),.ALUop(w_ALUCtrl),.o_result(w_ALU_result),.o_zero(o_zero)); // Register File
	DM				U5_DM(.i_clk(i_clk),.MemRead(w_MemRead),.MemWrite(w_MemWrite),.i_addr(w_ALU_result),.i_data(w_RF_data2),.o_data(w_DM_data)); // Arithmetic Logic Unit
	SEU			U6_SEU(.i_halfword(w_IM_instr[15:0]),.o_word(w_SEU_word)); // Data Memory
	ADD			U7_ADD_BR(.i_data1(w_ADD_PC),.i_data2({w_SEU_word[29:0],2'b00}),.o_sum(w_ADD_BR)); // Adder for Branch
	mx2_5b		U8_MUX_WR(.i_data1(w_IM_instr[20:16]),.i_data2(w_IM_instr[15:11]),.i_sel(w_RegDst),.o_data(w_MUX_WR)); // MUX for Write Register
	mx2_32b		U9_MUX_ALU(.i_data1(w_RF_data2),.i_data2(w_SEU_word),.i_sel(w_ALUSrc),.o_data(w_ALU_data2)); // MUX for ALU
	mx2_32b		U10_MUX_WD(.i_data1(w_ALU_result),.i_data2(w_DM_data),.i_sel(w_MemtoReg),.o_data(w_WD_data)); // MUX for Write Data
	mx2_32b		U11_MUX_BR(.i_data1(w_ADD_PC),.i_data2(w_ADD_BR),.i_sel(w_Branch&o_zero),.o_data(w_MUX_BR)); // MUX for Brach
	mx2_32b		U12_MUX_J(.i_data1(w_MUX_BR),.i_data2({w_ADD_PC[31:28],w_IM_instr[25:0],2'b00}),.i_sel(w_Jump),.o_data(w_MUX_J)); // MUX for Jump
	MainControl	U13_MainControl(.op(w_IM_instr[31:26]),.RegDst(w_RegDst),.Jump(w_Jump),.Branch(w_Branch),.MemRead(w_MemRead),
										.MemtoReg(w_MemtoReg),.ALUOp(w_ALUop),.MemWrite(w_MemWrite),.ALUSrc(w_ALUSrc),.RegWrite(w_RegWrite)); // Main Control
	ALUControl	U14_ALUControl(.funct(w_IM_instr[5:0]),.ALUOp(w_ALUop),.ALU_control_signal(w_ALUCtrl)); // ALU Control

endmodule
