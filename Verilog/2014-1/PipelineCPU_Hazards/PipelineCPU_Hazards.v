
module PipelineCPU_Hazards(i_clk,i_rst_n);
	input i_clk,i_rst_n;
	
	// wire for connect each module
	wire w_PCSrc,w_RegWrite,w_EX_MEM_zero,EX_Bubble,PC_Write,IFID_Write,Jump;
	wire [1:0] w_ID_EX_WB,w_EX_MEM_WB,w_MEM_WB_ctrl,ForwardA,ForwardB;
	wire [2:0] w_ID_EX_MEM,w_EX_MEM_ctrl;
	wire [3:0] w_ID_EX_ctrl;
	wire [4:0] w_WB_ID_reg,w_ID_FU_reg,w_ID_EX_tar,w_ID_EX_des,w_EX_MEM_reg,w_MEM_WB_reg;
	wire [31:0] w_IF_ID_PC,w_IF_ID_data,
					w_ID_EX_PC,w_ID_EX_read1,w_ID_EX_read2,w_ID_EX_imm,
					w_EX_MEM_PC,w_EX_MEM_result,w_EX_MEM_read,
					w_MEM_IF_PC,w_MEM_WB_data,w_MEM_WB_result,
					w_WB_ID_data;

	// Instruction Fetch
	IF		U0_IF(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_PCSrc(w_PCSrc),.i_jump_addr({w_IF_ID_PC[31:28],w_IF_ID_data[25:0],2'b0}),.i_branch_addr(w_MEM_IF_PC),.PC_Write(PC_Write),.IFID_Write(IFID_Write),.Jump(Jump),.o_next_pc(w_IF_ID_PC),.o_data(w_IF_ID_data));
	
	// Instruction Decoder
	ID		U1_ID(.i_clk(i_clk),.i_rst_n(i_rst_n),.RegWrite(w_RegWrite),.i_next_PC(w_IF_ID_PC),.i_write_reg(w_WB_ID_reg),.i_write_data(w_WB_ID_data),
					.i_data(w_IF_ID_data),.IDFlush(w_PCSrc),.EX_Bubble(EX_Bubble),.o_jump(Jump),.o_next_pc(w_ID_EX_PC),.o_read_data1(w_ID_EX_read1),.o_read_data2(w_ID_EX_read2),
					.o_imm(w_ID_EX_imm),.o_src_reg(w_ID_FU_reg),.o_tar_reg(w_ID_EX_tar),.o_des_reg(w_ID_EX_des),.o_WB_control(w_ID_EX_WB),.o_MEM_control(w_ID_EX_MEM),.o_EX_control(w_ID_EX_ctrl));

	// Excution
	EX		U2_EX(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_next_pc(w_ID_EX_PC),.i_read_data1(w_ID_EX_read1),.i_read_data2(w_ID_EX_read2),.i_imm(w_ID_EX_imm),
					.i_tar_reg(w_ID_EX_tar),.i_des_reg(w_ID_EX_des),.i_WB_control(w_ID_EX_WB),.i_MEM_control(w_ID_EX_MEM),.i_EX_control(w_ID_EX_ctrl),
					.ForwardA(ForwardA),.ForwardB(ForwardB),.i_mem_data(w_WB_ID_data),.EXFlush(w_PCSrc),.o_branch_pc(w_EX_MEM_PC),.o_result(w_EX_MEM_result),
					.o_zero(w_EX_MEM_zero),.o_read_data2(w_EX_MEM_read),.o_write_reg(w_EX_MEM_reg),.o_WB_control(w_EX_MEM_WB),.o_MEM_control(w_EX_MEM_ctrl));

	// Memory Access
	MEM	U3_MEM(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_result(w_EX_MEM_result),.i_zero(w_EX_MEM_zero),.i_read_data2(w_EX_MEM_read),.i_write_reg(w_EX_MEM_reg),
					.i_WB_control(w_EX_MEM_WB),.i_MEM_control(w_EX_MEM_ctrl),.i_branch_pc(w_EX_MEM_PC),.o_write_reg(w_MEM_WB_reg),.o_write_data(w_MEM_WB_data),
					.o_result(w_MEM_WB_result),.o_WB_control(w_MEM_WB_ctrl),.o_branch(w_PCSrc),.o_branch_pc(w_MEM_IF_PC));

	// Write Back
	WB		U4_WB(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_write_reg(w_MEM_WB_reg),.i_write_data(w_MEM_WB_data),.i_result(w_MEM_WB_result),
					.i_WB_control(w_MEM_WB_ctrl),.o_write_reg(w_WB_ID_reg),.o_write_data(w_WB_ID_data),.o_RegWrite(w_RegWrite));
	
	//Forwarding Unit
	FU		U5_FU(.IDEX_Rs(w_ID_FU_reg),.IDEX_Rt(w_ID_EX_tar),.EXMEM_Rd(w_EX_MEM_reg),.EXMEM_RegWrite(w_EX_MEM_WB[0]),.MEMWB_Rd(w_MEM_WB_reg),.MEMWB_RegWrite(w_MEM_WB_ctrl[0]),.ForwardA(ForwardA),.ForwardB(ForwardB));
	
	//Hazard Detection Unit
	HDU	U6_HDU(.IDEX_Rt(w_ID_EX_tar),.IFID_Rs(w_IF_ID_data[25:21]),.IFID_Rt(w_IF_ID_data[20:16]),.IDEX_MemRead(w_ID_EX_MEM[1]),.EX_Bubble(EX_Bubble),.PC_Write(PC_Write),.IFID_Write(IFID_Write));
	
endmodule
