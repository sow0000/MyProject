module EX(i_clk,i_rst_n,i_next_pc,i_read_data1,i_read_data2,i_imm,i_tar_reg,i_des_reg,i_WB_control,i_MEM_control,i_EX_control,o_branch_pc,o_result,o_zero,o_read_data2,o_write_reg,o_WB_control,o_MEM_control);
	input i_clk,i_rst_n;
	input [1:0] i_WB_control;
	input [2:0] i_MEM_control;
	input [3:0] i_EX_control;
	input [4:0] i_tar_reg,i_des_reg;
	input [31:0] i_next_pc,i_read_data1,i_read_data2,i_imm;
	output o_zero;
	output [1:0] o_WB_control;
	output [2:0] o_MEM_control;
	output [4:0] o_write_reg;
	output [31:0] o_branch_pc,o_result,o_read_data2;
	
	wire w_zero;
	wire [3:0] w_ALUop;
	wire [31:0] w_result,w_branch_pc,w_read_data2,w_write_reg;
	
	ALU				U0_ALU(.i_data1(i_read_data1),.i_data2(w_read_data2),.shamt(i_imm[10:6]),.ALUop(w_ALUop),.o_result(w_result),.o_zero(w_zero));
	R_EX_MEM			U1_EX_MEM(.i_clk(i_clk),.i_rst_n(i_rst_n),.i_branch_pc(w_branch_pc),.i_result(w_result),.i_zero(w_zero),.i_read_data2(i_read_data2),
									.i_write_reg(w_write_reg),.i_WB_control(i_WB_control),.i_MEM_control(i_MEM_control),.o_branch_pc(o_branch_pc),.o_result(o_result),
									.o_zero(o_zero),.o_read_data2(o_read_data2),.o_write_reg(o_write_reg),.o_WB_control(o_WB_control),.o_MEM_control(o_MEM_control));
	ADD				U3_ADD_Branch(.i_data1(i_next_pc),.i_data2({i_imm[29:0],2'b00}),.o_sum(w_branch_pc)); // Adder for branch
	MUX2_1			U4_MUX_data(.i_data1(i_read_data2),.i_data2(i_imm),.sel(i_EX_control[3]),.o_data(w_read_data2));
	MUX2_1_5bits	U5_MUX_reg(.i_data1(i_tar_reg),.i_data2(i_des_reg),.sel(i_EX_control[0]),.o_data(w_write_reg));
	ALUControl		U6_ALUControl(.funct(i_imm[5:0]),.ALUOp(i_EX_control[2:1]),.ALU_control_signal(w_ALUop)); // ALU Control
	
	
endmodule //End of module