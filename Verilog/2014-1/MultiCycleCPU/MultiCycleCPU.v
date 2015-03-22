module MC_TOP(i_clk,i_rst_n);
	input i_clk,i_rst_n;
	
	wire w_zero,w_PCWriteCond,w_PCWrite,w_IorD,w_MemRead,w_MemWrite,w_MemtoReg,w_IRWrite,w_ALUSrcA,w_RegWrite,w_RegDst;
	wire [1:0] w_PCSource,w_ALUOp,w_ALUSrcB;
	wire [3:0] w_ALUCntl;
	wire [4:0] w_IRtoFSM,w_rs,w_rt,w_MUXtoREG1;
	wire [5:0] w_op;
	wire [15:0] w_Imm16;
	wire [31:0] w_PCtoMUX,w_MUXtoMEM,w_ALUtoOUT,w_OUTtoMUX,w_MUXtoPC,w_MEMtoIR,w_MDRtoMUX,w_MUXtoREG2,
					w_REGtoA,w_REGtoB,w_AtoMUX,w_BtoMUX,w_MUXtoALU1,w_MUXtoALU2,w_SEUtoMUX;
	
	PC 				U0_PC(.i_pc_w_c((w_PCWriteCond&w_zero)|w_PCWrite),.i_next_pc(w_MUXtoPC),.o_pc(w_PCtoMUX),.i_rst_n(i_rst_n),.i_clk(i_clk));
	MUX2_1 			U1_MUX2_1(.i_data1(w_PCtoMUX),.i_data2(w_OUTtoMUX),.sel(w_IorD),.o_data(w_MUXtoMEM));
	MEM				U2_MEMORY(.i_clk(i_clk),.i_rst_n(i_rst_n),.MemRead(w_MemRead),.MemWrite(w_MemWrite),.i_addr(w_MUXtoMEM),.i_WriteData(w_BtoMUX),.o_MemData(w_MEMtoIR));
	MDR				U3_MDR(.i_clk(i_clk),.i_data(w_MEMtoIR),.o_data(w_MDRtoMUX));
	IR					U4_IR(.i_clk(i_clk),.IRWrite(w_IRWrite),.i_Instr(w_MEMtoIR),.o_op(w_op),.o_rs(w_rs),.o_rt(w_rt),.o_Imm16(w_Imm16));
	FSM				U5_FSM(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_op(w_op),.PCWriteCond(w_PCWriteCond),.PCWrite(w_PCWrite),.IorD(w_IorD),
								.MemRead(w_MemRead),.MemWrite(w_MemWrite),.MemtoReg(w_MemtoReg),.IRWrite(w_IRWrite),.PCSource(w_PCSource),
								.ALUOp(w_ALUOp),.ALUSrcB(w_ALUSrcB),.ALUSrcA(w_ALUSrcA),.RegWrite(w_RegWrite),.RegDst(w_RegDst));
	MUX2_1_5bits	U6_MUX2_1_5bits(.i_data1(w_rt),.i_data2(w_Imm16[15:11]),.sel(w_RegDst),.o_data(w_MUXtoREG1));
	MUX2_1			U7_MUX2_1(.i_data1(w_OUTtoMUX),.i_data2(w_MDRtoMUX),.sel(w_MemtoReg),.o_data(w_MUXtoREG2));
	RF					U8_RF(.i_Write_reg(w_MUXtoREG1),.RegWrite(w_RegWrite),.i_Write_data(w_MUXtoREG2),.i_rst_n(i_rst_n),.i_clk(i_clk),
								.i_Read_reg1(w_rs),.i_Read_reg2(w_rt),.o_Read_data1(w_REGtoA),.o_Read_data2(w_REGtoB));
	A					U9_A(.i_clk(i_clk),.i_x(w_REGtoA),.o_y(w_AtoMUX));
	A					U10_B(.i_clk(i_clk),.i_x(w_REGtoB),.o_y(w_BtoMUX));
	MUX2_1			U11_MUX2_1(.i_data1(w_PCtoMUX),.i_data2(w_AtoMUX),.sel(w_ALUSrcA),.o_data(w_MUXtoALU1));
	SEU				U12_SEU(.i_halfword(w_Imm16),.o_word(w_SEUtoMUX));
	MUX4_1			U13_MUX4_1(.i_data1(w_BtoMUX),.i_data2(32'h0000_0004),.i_data3(w_SEUtoMUX),.i_data4({w_SEUtoMUX[29:0],2'b00}),.sel(w_ALUSrcB),.o_data(w_MUXtoALU2));
	ALUControl		U14_ALUControl(.funct(w_Imm16[5:0]),.ALUOp(w_ALUOp),.ALU_control_signal(w_ALUCntl));
	ALU				U15_ALU(.i_data1(w_MUXtoALU1),.i_data2(w_MUXtoALU2),.ALUop(w_ALUCntl),.o_result(w_ALUtoOUT),.o_zero(w_zero));
	ALUOut			U16_ALUOut(.i_clk(i_clk),.i_alu_result(w_ALUtoOUT),.o_alu_out(w_OUTtoMUX));
	MUX3_1			U17_MUX3_1(.i_data1(w_ALUtoOUT),.i_data2(w_OUTtoMUX),.i_data3({w_PCtoMUX[31:28],w_rs,w_rt,w_Imm16,2'b00}),.sel(w_PCSource),.o_data(w_MUXtoPC));
	//ADD				U18_JUMP_Addr(.i_data1(),.i_data2(),.o_sum());
	
endmodule //End of module
	